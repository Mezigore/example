import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';

/// WM для CartNoPaper - Отказ от бумажных рецептов
class CartNoPaperWidgetModel extends WidgetModel {
  CartNoPaperWidgetModel(
    WidgetModelDependencies baseDependencies,
    this._cartManager,
    this.bottomSheet,
  ) : super(baseDependencies);

  final CartManager _cartManager;
  final bool bottomSheet;

  StreamedState<List<bool>> get noPaperRecipeState => _cartManager.noPaperRecipeState;

  /// Тап по кнопке Отказ от бумажных рецептов
  final noPaperAction = Action<bool>();

  @override
  void onBind() {
    super.onBind();

    bind<void>(noPaperAction, (isNoPaper) => _noPaperAction(isNoPaper as bool));
  }

  /// Обрабатываем клик по кнопке
  Future<void> _noPaperAction(bool isNeedPaper) =>
      _cartManager.setNoPaper(isNeedPaper: isNeedPaper);
}
