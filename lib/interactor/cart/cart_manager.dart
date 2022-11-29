import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pedantic/pedantic.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/cart/cart.dart';
import 'package:uzhindoma/domain/cart/cart_element.dart';
import 'package:uzhindoma/domain/cart/edit_cart_item.dart';
import 'package:uzhindoma/interactor/cart/cart_action.dart';
import 'package:uzhindoma/interactor/cart/cart_interactor.dart';
import 'package:uzhindoma/interactor/catalog/catalog_interactor.dart';
import 'package:uzhindoma/interactor/order/no_paper_recipe_storage.dart';
import 'package:uzhindoma/interactor/token/token_storage.dart';

/// Менеджер работы с корзиной.
///
/// В основе менеджера лежит сразу несколько подходов.
/// Корзина имеет позитивный принцип работы, при этом ее состояние реальное.
/// Для обеспечения подобной работы стейт корзины отражает реальное состояние,
/// а так же имеется нотифер уведомляющий о текущем позитивном состоянии.
///
/// Например:
/// добавление некоторого продукта в корзину, сразу приведет позитивное
/// состояние в исполненное. Однако до завершения запроса реальное состояние
/// не изменится.
///
/// Из запросов на взаимодействие с корзиной формируется оптимизированная
/// очередь обращений к серверу. На время обработки этой очереди корзина
/// переходит в состояние загрузки. Ошибки, происходящие во время обработки
/// очереди, обрабатываются стандартным обработчиком ошибок. По окончании
/// обработки очереди запрашивается актуальное состояние. Полное состояние
/// корзины окажется в состоянии ошибки только в случае отвала запроса
/// актуализации корзины.
class CartManager {
  CartManager(this._authInfoStorage,this._catalogInteractor,this._cartInteractor, this._errorHandler, this._noPaperStorage) {
    _errorController = StreamController<Exception>.broadcast();
  }

  final AuthInfoStorage _authInfoStorage;
  final CatalogInteractor _catalogInteractor;
  final CartInteractor _cartInteractor;
  final ErrorHandler _errorHandler;
  final NoPaperRecipeStorage _noPaperStorage;

  final _pool = <CartAction>[];
  final _done = <CartAction>[];
  CartAction _currentAction;
  bool _isPoolLocked = false;
  StreamController<Exception> _errorController;
  String promoname = '';

  // final cartState = EntityStreamedState<Cart>();
  final cartState = EntityStreamedState<Cart>();
  final positiveListNotifier = ValueNotifier<Map<String, int>>({});
  bool selectRecipe = false;
  // bool selectRecipeErr = false;

  /// Поток состояния кнопки Отказ от бумажных рецептов
  /// 0 - тип рецепта, 1 - состояние чекбоксов
  final noPaperRecipeState = StreamedState<List<bool>>();

  /// Поток с ошибками
  Stream<Exception> get errorStream => _errorController?.stream;

  /// Метод первоначальной инициализации.
  /// Сразу запрашиваем корзину вдруг она уже есть на сервере.
  /// (Задел на будущее).
  Future<void> init() async {
    await cartState.loading();
    await _updateCart();
    // await _updateRecommend();
    await _initNoPaper();
  }

  void dispose() {
    _errorController?.close();
  }

  /// Обновить корзину
  void updateCart({String promo}) {
    if(promo != null){
      promoname = promo;
    }
    final action = UpdateCartAction();

    _handleAction(action);
  }

  /// Добавить товар в корзину
  void addToCart(CartElement item) {
    final action = CartElementAction(
      CartActionType.add,
      item,
      item.ratio,
    );

    _handleAction(action);
  }

  /// Удалить товар из корзины
  void removeFromCart(CartElement item) {
    final action = CartElementAction(
      CartActionType.remove,
      item,
      item.ratio,
    );

    _handleAction(action);
  }

  /// Удалить подарок из корзины
  void removeExtra(String extraId) {
    final action = RemoveExtraAction(
      id: extraId,
    );

    _handleAction(action);
  }

  /// Очистить корзину
  void clearCart() {
    _handleAction(ClearCartAction());
  }

  void _handleAction(CartAction action) {
    if (action is UpdateCartAction) {
      _pool.add(action);
      // Дополнительных изменений не надо
    }

    if (action is CartElementAction) {
      final pooledAction = _pool.whereType<CartElementAction>().firstWhere(
            (e) => e.id == action.id,
            orElse: () => null,
          );
      if (pooledAction == null) {
        _pool.add(action);
      } else {
        final currentCount = pooledAction.count *
            (pooledAction.type == CartActionType.remove ? -1 : 1);
        final addCount =
            action.count * (action.type == CartActionType.remove ? -1 : 1);
        final newCount = currentCount + addCount;

        if (newCount == 0) {
          _pool.remove(pooledAction);
        } else {
          final newAction = CartElementAction(
            newCount > 0 ? CartActionType.add : CartActionType.remove,
            action.item,
            newCount.abs(),
          );

          _pool
            ..insert(_pool.indexOf(pooledAction), newAction)
            ..remove(pooledAction);
        }
      }

      _handlePositiveList();
    }

    if (action is RemoveExtraAction) {
      // проверим что такого еще нет
      final pooledAction = _pool.whereType<RemoveExtraAction>().firstWhere(
            (e) => e.id == action.id,
            orElse: () => null,
          );

      if (pooledAction == null) {
        _pool.add(action);
      }
    }

    if (action is ClearCartAction) {
      if (_pool.isNotEmpty) {
        _pool.clear();
      }

      _pool.add(action);

      _handlePositiveList();
    }

    _handlePool();
  }

  void _handlePool() {
    if (_isPoolLocked) {
      return;
    }

    if (_pool.isNotEmpty) {
      _processQueue();
    }
  }

  Future<void> _processQueue() async {
    _isPoolLocked = true;
    await cartState.loading(cartState.value?.data);

    while (_pool.isNotEmpty) {
      _currentAction = _pool.removeAt(0);

      Future<void> editFuture;

      switch (_currentAction.runtimeType) {
        case UpdateCartAction:
          // Мы ничего не меняем
          break;
        case CartElementAction:
          final currentAction = _currentAction as CartElementAction;
          final edit = EditCartItem(currentAction.id, currentAction.count);
          editFuture = currentAction.type == CartActionType.add
              ? _cartInteractor.addToCart(edit)
              : _cartInteractor.removeFromCart(edit);
          break;
        case RemoveExtraAction:
          final currentAction = _currentAction as RemoveExtraAction;
          editFuture = _cartInteractor.removeExtra(currentAction.id);
          break;
        case ClearCartAction:
          editFuture = _cartInteractor.clearCart();
          break;
        default:
          throw UnimplementedError(
              'Handle for cart action $_currentAction not found');
      }

      try {
        if (editFuture != null) {
          await editFuture;
        }
        _done.add(_currentAction);
      } on Exception catch (e) {
        _done.add(FailedCartAction(_currentAction));
        _handlePositiveList();
        _errorHandler.handleError(e);
        _errorController.add(e);
      } finally {
        _currentAction = null;
      }
    }

    unawaited(_updateCart());
  }

  void _handlePositiveList() {
    final positiveList = <String, int>{};

    final cart = cartState.value?.data;
    if (cart != null) {
      final menu = cart.menu;
      for (final item in menu) {
        final id = item.id;
        final qty = item.qty;

        var count = positiveList[id] ?? 0;
        count += qty;
        positiveList[id] = count;
      }
    }

    final poolList = <CartAction>[];
    if (_done.isNotEmpty) {
      poolList.addAll(_done);
    }
    if (_currentAction != null) {
      poolList.add(_currentAction);
    }
    if (_pool.isNotEmpty) {
      poolList.addAll(_pool);
    }

    for (final action in poolList) {
      if (action is UpdateCartAction) {
        /// Значит не влияет на изменение корзины
      }
      if (action is FailedCartAction) {
        /// Значит не влияет на изменение корзины
        // final failed = action.action;
        // if (failed is CartElementAction) {
        //   final id = failed.id;
        //   final qty = -failed.changeValue;
        //
        //   var count = positiveList[id] ?? 0;
        //   count += qty;
        //   positiveList[id] = count;
        // }
      }
      if (action is CartElementAction) {
        final id = action.id;
        final qty = action.changeValue;

        var count = positiveList[id] ?? 0;
        count += qty;
        positiveList[id] = count;
      }
      if (action is ClearCartAction) {
        positiveList.clear();
      }
    }

    positiveListNotifier.value = positiveList;
  }

  Future<void> _updateRecommend() async {
    var cart = cartState.value.data;
    ///recommend
    final recommend = await _catalogInteractor.getRecommend(_authInfoStorage.userIdLast);
    cart = cart.copyWith(recommendationItem: recommend);
    if (_pool.isNotEmpty) {
      unawaited(_processQueue());
    } else {
      await cartState.content(cart);
      _done.clear();

      // await _resetNoPaperDefault();
    }
  }

  /// Обноление корзины
  Future<void> _updateCart() async {
    Cart cart;
    try {
      if(promoname != ''){
        cart = await _cartInteractor.getPromoCart(promoname: promoname);
        cart = cart.copyWith(promoname: promoname);
        promoname = '';
      }else{
        cart = await _cartInteractor.getCart();
      }
      // ///recommend
      // final recommend = await _catalogInteractor.getRecommend(_authInfoStorage.userIdLast);
      // cart = cart.copyWith(recommendationItem: recommend);

      if (_pool.isNotEmpty) {
        unawaited(_processQueue());
      } else {
        await cartState.content(cart);
        _done.clear();

        await _resetNoPaperDefault();
      }
    } on Exception catch (e) {
      // может быть надо более выборочно обрабатывать ошибки - пока так
      final oldCart = cartState.value?.data;
      final newEntity = EntityState.error(e, oldCart);
      await cartState.accept(newEntity);
    } finally {
      _handlePositiveList();
      _isPoolLocked = false;
    }
  }

  /// Работа с кнопкой в корзине Отказ от бумажных рецептов
  /// Получаем из кэша текущее состояние чекбокса
  /// В стрим передается тип выбранного рецепта и состояние чекбоксов
  Future<void> _initNoPaper() async {
    final isNoPaperRecipe = await _noPaperStorage.getNoPaper();
    await noPaperRecipeState.accept([null, true]);
  }

  /// Обрабатываем клик по кнопке
  Future<void> setNoPaper({@required bool isNeedPaper}) async {
    selectRecipe = true;
    await noPaperRecipeState.accept([isNeedPaper, true]);
    await _noPaperStorage.setNoPaper(isNoPaperRecipe: isNeedPaper);
  }

  /// Обработка ошибки при невыбранном типе рецепта
  Future<void> noSelectRecipeErr() async {
    await noPaperRecipeState.accept([null, false]);
  }

  /// Установить значение по умолчанию (false)
  Future<void> setNoPaperDefault() async {
    await noPaperRecipeState.accept([false, true]);
    await _noPaperStorage.setDefaultNoPaper();
  }

  /// Сбросить значение флага если корзина пустая
  Future<void> _resetNoPaperDefault() async {
    final cart = cartState.value?.data;

    if (cart == null ||
        (cart.menu?.isEmpty ?? true) && (cart.extraItems?.isEmpty ?? true)) {
      await setNoPaperDefault();
    }
  }
}
