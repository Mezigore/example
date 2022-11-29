import 'dart:async';

import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/domain/catalog/week_item.dart';
import 'package:uzhindoma/interactor/catalog/catalog_interactor.dart';
import 'package:uzhindoma/interactor/catalog/menu_storage.dart';
import 'package:uzhindoma/interactor/city/city_manager.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';

/// Менеджер для хранения меню
class MenuManager {
  MenuManager(
    this._catalogInteractor,
    this._cityManager,
    this._menuStorage,
  );

  final CatalogInteractor _catalogInteractor;
  final CityManager _cityManager;
  final MenuStorage _menuStorage;

  /// Меню на текущей неделе
  final menuState = EntityStreamedState<List<CategoryItem>>();

  /// Список возможных загруженных недель
  final weeksInfoState = EntityStreamedState<List<WeekItem>>();

  /// Текущая неделя
  final currentWeekState = StreamedState<WeekItem>();

  StreamSubscription _citySubscription;
  StreamSubscription _weekSubscription;

  /// Текущее загруженное меню
  List<CategoryItem> get currentMenu => menuState.value?.data;

  List<MenuItem> get allDishes => currentMenu
      ?.reduce(
        (value, element) => value..products.addAll(element.products),
      )
      ?.products;

  WeekItem get currentWeek => currentWeekState.value;

  set currentWeek(WeekItem week) {
    if (week.id == currentWeek.id) return;
    currentWeekState.accept(week);
    _menuStorage.setLastWeek(week.id);
    loadMenu();
  }

  String get _currentCity => _cityManager.currentCity.value?.data?.id;

  void init() {
    weeksInfoState.loading();
    menuState.loading();
    _citySubscription?.cancel();
    _citySubscription = _cityManager.currentCity.stream.listen(
      (entity) async {
        if (entity.isLoading || entity.hasError) return;
        await loadWeeks();
      },
    );
    _weekSubscription?.cancel();
    _weekSubscription = currentWeekState.stream.listen(
      (entity) => loadMenu(),
    );
  }

  /// Для уничтожения подписки
  void dispose() {
    _citySubscription?.cancel();
    _weekSubscription?.cancel();
  }

  /// Получить из загруженного меню продукт по id
  MenuItem getMenuItemById(String id) {
    return allDishes.firstWhere((item) => item.id == id, orElse: () => null);
  }

  /// Загрузка меню
  Future<void> loadMenu() async {
    await menuState.loading(menuState.value?.data);
    try {
      if (_currentCity == null) {
        throw MessagedException('Неопределен город пользователя');
      }
      if (currentWeek == null) {
        throw MessagedException('Неопределена неделя для заказа');
      }
      final categories = await _catalogInteractor.getMenu(
        _currentCity,
        currentWeek.id,
      );

      //////HARDCODE/////
      // final String json = '{"id":"forYou","code":"foryou","name":"Для Вас","count":5,"description":"Мы подобрали эти блюда специально для вас","products":[{"id":"672763","name":"Рулетики по-римски с молодым картофелем и брусничным соусом","preview_img":"https://uzhindoma.ru/upload/resize_cache/iblock/716/772_480_1/frj2857fg6wxxk7uoso4t6fx4p8phaji.jpg","preview_img_128":"https://uzhindoma.ru/upload/resize_cache/iblock/716/128_128_2/frj2857fg6wxxk7uoso4t6fx4p8phaji.jpg","preview_img_for_you":"https://uzhindoma.ru/upload/resize_cache/iblock/716/270_139_2/frj2857fg6wxxk7uoso4t6fx4p8phaji.jpg","detail_img":"https://uzhindoma.ru/upload/resize_cache/iblock/716/772_480_1/frj2857fg6wxxk7uoso4t6fx4p8phaji.jpg","price":490,"discount_price":475,"discount5":392,"promo_price":392,"measure_unit":"за порцию","is_available":true,"type":"common","properties":{"rate":4.9,"add_photo":false,"show_add_first":false,"for_you":true,"is_veg":false,"promo_present":false,"bgu_cal_veg":0,"bgu_protein_veg":0,"bgu_fat_veg":0,"bgu_carb_veg":0,"cook_time":30,"weight":1200,"will_deliver":"Мини картофель 500гр, цельное филе индейки без кожи 300гр, бекон 6 ломтиков , шалфей, фирменный куриный бульон 150мл, брусничное варенье 60гр, чеснок, свежая зелень для украшения, сливочное масло 80гр, свежий укроп, зубочистки","you_need":"Доска, нож, кастрюля, сковорода, лопатка, духовка, прихватка, противень","prepare_comment":"Приготовить в течение 5 дней после доставки. При доставке в пн приготовить в течение 4 дней","labels":[{"title":"с духовкой","label_color":"ccccccff","text_color":"ffffffff"},{"title":"хит","label_color":"ffdd6cff","text_color":"000000ff"}],"main_label":null,"prepare":"5","bgu_cal":157.95,"bgu_protein":7.83,"bgu_fat":9.56,"bgu_carb":10.2,"is_recommend":false,"ratio":"2"}},{"id":"672764","name":"Свиная вырезка, томлённая с кабачками, сладким перцем и томатами","preview_img":"https://uzhindoma.ru/upload/resize_cache/iblock/c57/772_480_1/sq1vc8cjkvmjk6pljm5f80y8q5j1lzua.jpg","preview_img_128":"https://uzhindoma.ru/upload/resize_cache/iblock/c57/128_128_2/sq1vc8cjkvmjk6pljm5f80y8q5j1lzua.jpg","preview_img_for_you":"https://uzhindoma.ru/upload/resize_cache/iblock/c57/270_139_2/sq1vc8cjkvmjk6pljm5f80y8q5j1lzua.jpg","detail_img":"https://uzhindoma.ru/upload/resize_cache/iblock/c57/772_480_1/sq1vc8cjkvmjk6pljm5f80y8q5j1lzua.jpg","price":460,"discount_price":446,"discount5":368,"promo_price":368,"measure_unit":"за порцию","is_available":true,"type":"common","properties":{"rate":5,"add_photo":false,"show_add_first":false,"for_you":true,"is_veg":true,"promo_present":false,"bgu_cal_veg":77.38,"bgu_protein_veg":4.24,"bgu_fat_veg":2.34,"bgu_carb_veg":7.01,"cook_time":30,"weight":1300,"will_deliver":"Кусочки отборной свиной вырезки 300гр, мёд 40гр, сладкий соус чили 30гр, протёртые томаты 100гр, бальзамический уксус 10мл, свежие кабачки, перец сладкий замороженный 150гр, сезонные помидоры 170гр, очищенный красный лук, чеснок, оливковое масло 20мл , душистый свежий тимьян","you_need":"Доска, нож, сковорода, лопатка, растительное масло, соль","prepare_comment":"Приготовить в течение 5 дней после доставки. При доставке в пн приготовить в течение 4 дней","labels":[{"title":"легкое","label_color":"97f4d3ff","text_color":"054c37ff"}],"main_label":null,"prepare":"5","bgu_cal":78.4,"bgu_protein":5.24,"bgu_fat":3.24,"bgu_carb":7.01,"is_recommend":false,"ratio":"2"}},{"id":"672772","name":"Паста Лисы Алисы с мясным соусом а-ля Болоньезе","preview_img":"https://uzhindoma.ru/upload/resize_cache/iblock/526/772_480_1/z4fmfwyuqh4rjqzde6jsaj4wiu89632u.jpg","preview_img_128":"https://uzhindoma.ru/upload/resize_cache/iblock/526/128_128_2/z4fmfwyuqh4rjqzde6jsaj4wiu89632u.jpg","preview_img_for_you":"https://uzhindoma.ru/upload/resize_cache/iblock/526/270_139_2/z4fmfwyuqh4rjqzde6jsaj4wiu89632u.jpg","detail_img":"https://uzhindoma.ru/upload/resize_cache/iblock/526/772_480_1/z4fmfwyuqh4rjqzde6jsaj4wiu89632u.jpg","price":390,"discount_price":378,"discount5":312,"promo_price":312,"measure_unit":"за порцию","is_available":true,"type":"common","properties":{"rate":4.9,"add_photo":false,"show_add_first":false,"for_you":true,"is_veg":false,"promo_present":false,"bgu_cal_veg":0,"bgu_protein_veg":0,"bgu_fat_veg":0,"bgu_carb_veg":0,"cook_time":30,"weight":670,"will_deliver":"Фарш из отборной говядины 300гр, паста фузилли 200гр, очищенный репчатый лук, чеснок, томатная паста 50гр, прованские травы","you_need":"Доска, нож, кастрюля, дуршлаг, сковорода, лопатка, крышка, растительное масло, соль, перец","prepare_comment":"Приготовить в течение 7 дней после доставки. При доставке в пн приготовить в течение 6 дней","labels":[{"title":"подходит детям","label_color":"d4aaffff","text_color":"000000ff"},{"title":"хит","label_color":"ffdd6cff","text_color":"000000ff"}],"main_label":null,"prepare":"7","bgu_cal":228.33,"bgu_protein":11.02,"bgu_fat":9.12,"bgu_carb":24.4,"is_recommend":false,"ratio":"2"}},{"id":"672781","name":"Ароматная курица «Гори, гори ясно» в томатном соусе с гречкой","preview_img":"https://uzhindoma.ru/upload/resize_cache/iblock/03f/772_480_1/ede8azu420b24n03b5dggaqzh3sbs9zw.jpg","preview_img_128":"https://uzhindoma.ru/upload/resize_cache/iblock/03f/128_128_2/ede8azu420b24n03b5dggaqzh3sbs9zw.jpg","preview_img_for_you":"https://uzhindoma.ru/upload/resize_cache/iblock/03f/270_139_2/ede8azu420b24n03b5dggaqzh3sbs9zw.jpg","detail_img":"https://uzhindoma.ru/upload/resize_cache/iblock/03f/772_480_1/ede8azu420b24n03b5dggaqzh3sbs9zw.jpg","price":390,"discount_price":378,"discount5":312,"promo_price":312,"measure_unit":"за порцию","is_available":true,"type":"common","properties":{"rate":4.8,"add_photo":false,"show_add_first":false,"for_you":true,"is_veg":false,"promo_present":false,"bgu_cal_veg":0,"bgu_protein_veg":0,"bgu_fat_veg":0,"bgu_carb_veg":0,"cook_time":25,"weight":740,"will_deliver":"Кусочки куриного филе без кожи 300гр, очищенный репчатый лук, чеснок, мексиканские специи для тако, паприка, протёртые томаты 150гр, гречка 150гр","you_need":"Доска, нож, кастрюля, сковорода, лопатка, крышка, соль, перец, растительное масло","prepare_comment":"Приготовить в течение 5 дней после доставки. При доставке в пн приготовить в течение 4 дней","labels":[{"title":"подходит детям","label_color":"d4aaffff","text_color":"000000ff"},{"title":"хит","label_color":"ffdd6cff","text_color":"000000ff"}],"main_label":null,"prepare":"5","bgu_cal":130.95,"bgu_protein":12.61,"bgu_fat":1.18,"bgu_carb":16.69,"is_recommend":false,"ratio":"2"}},{"id":"672783","name":"Греческая пита с курицей, овощами и соусом Дзадзыки","preview_img":"https://uzhindoma.ru/upload/resize_cache/iblock/879/772_480_1/6g03nfds7bezsxqv9cn8kbdxg3t9x1jc.jpg","preview_img_128":"https://uzhindoma.ru/upload/resize_cache/iblock/879/128_128_2/6g03nfds7bezsxqv9cn8kbdxg3t9x1jc.jpg","preview_img_for_you":"https://uzhindoma.ru/upload/resize_cache/iblock/879/270_139_2/6g03nfds7bezsxqv9cn8kbdxg3t9x1jc.jpg","detail_img":"https://uzhindoma.ru/upload/resize_cache/iblock/879/772_480_1/6g03nfds7bezsxqv9cn8kbdxg3t9x1jc.jpg","price":460,"discount_price":446,"discount5":368,"promo_price":368,"measure_unit":"за порцию","is_available":true,"type":"common","properties":{"rate":4.8,"add_photo":false,"show_add_first":false,"for_you":true,"is_veg":false,"promo_present":false,"bgu_cal_veg":0,"bgu_protein_veg":0,"bgu_fat_veg":0,"bgu_carb_veg":0,"cook_time":30,"weight":1250,"will_deliver":"Кусочки куриного филе без кожи 300гр, пита 3шт , паприка, жидкий дым 5мл, йогурт классический 150гр, короткоплодные огурцы  140гр, белый картофель галла 400гр, красные помидоры черри 60гр, душистый свежий тимьян, чеснок, свежий укроп, свежая петрушка","you_need":"Духовка, прихватка, доска, нож, миска, сковорода, лопатка, противень, соль, перец, растительное масло","prepare_comment":"Приготовить в течение 3 дней после доставки. При доставке в пн приготовить в течение 2 дней","labels":[{"title":"легкое","label_color":"97f4d3ff","text_color":"054c37ff"},{"title":"хит","label_color":"ffdd6cff","text_color":"000000ff"}],"main_label":null,"prepare":"3","bgu_cal":96.12,"bgu_protein":7.94,"bgu_fat":1,"bgu_carb":13.23,"is_recommend":false,"ratio":"2"}}],"price":4380,"discount":3504}';
      //
      // final CategoryItemData parceJson = CategoryItemData.fromJson(jsonDecode(json) as Map<String, dynamic>);
      // List<CategoryItemData> listParceJson = [parceJson];
      // final List<CategoryItem> forYou = listParceJson.map(mapCategoryItem).toList();
      // categories.insert(0, forYou[0]);
      //////HARDCODE/////

      await menuState.content(categories);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<List<CategoryItem>>.error(
        e,
        menuState.value?.data,
      );
      await menuState.accept(newState);
      rethrow;
    }
  }

  /// Загрузка недель
  Future<void> loadWeeks() async {
    await weeksInfoState.loading(weeksInfoState.value?.data);
    try {
      if (_currentCity == null) {
        throw MessagedException('Неопределен город пользователя');
      }
      final weeks = await _catalogInteractor.getWeekInfo(_currentCity);
      weeks?.sort((f, s) => f.startDate.compareTo(s.startDate));
      final lastWeekId = await _menuStorage.getLastWeek();
      final week = weeks.firstWhere(
        (element) => element.id == lastWeekId,
        orElse: () => weeks[0],
      );
      await currentWeekState.accept(week);
      await weeksInfoState.content(weeks);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<List<WeekItem>>.error(
        e,
        weeksInfoState.value?.data,
      );
      await weeksInfoState.accept(newState);
      rethrow;
    }
  }
}
