import 'package:uzhindoma/ui/common/order_dialog_controller.dart';
import 'package:uzhindoma/ui/common/widgets/input/phone_input.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/screen/about/about_screen.dart';
import 'package:uzhindoma/ui/screen/auth/auth_screen.dart';
import 'package:uzhindoma/ui/screen/cart/cart_screen.dart';
import 'package:uzhindoma/ui/screen/confirmation/confirmation_screen.dart';
import 'package:uzhindoma/ui/screen/confirmation_replacement_phone_number/confirmation_replacement_phone_number_screen.dart';
import 'package:uzhindoma/ui/screen/discount/discount_screen.dart';
import 'package:uzhindoma/ui/screen/main/widget/cards/premium_dish_card.dart';
import 'package:uzhindoma/ui/screen/main/widget/drawer/main_drawer_widget.dart';
import 'package:uzhindoma/ui/screen/orders_history/orders_history_screen.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/change_order/change_order_screen.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/new_order_info/new_order_info_screen.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/rate_order/rate_order_screen.dart';
import 'package:uzhindoma/ui/screen/product_details/product_details_screen.dart';
import 'package:uzhindoma/ui/screen/profile/profile_screen.dart';
import 'package:uzhindoma/ui/screen/profile/tabs/user_details/user_details_widget.dart';
import 'package:uzhindoma/ui/screen/promo/promo_screen.dart';
import 'package:uzhindoma/ui/screen/recipes/recipes_screen.dart';
import 'package:uzhindoma/ui/screen/replacement_phone_number/replacement_phone_number_screen.dart';
import 'package:uzhindoma/ui/widget/address_form/address_form.dart';
import 'package:uzhindoma/util/const.dart';

const String closeAppText = 'Нажмите еще раз, чтобы выйти';

/// Экран онбординга
const String skipOnboardingButtonText = 'Пропустить';
const String startOnboardingButtonText = 'Начать';
const String onboardingTitle1 = 'Каждую неделю\nновое меню';
const String onboardingTitle2 = 'Пошаговые\nрецепты';
const String onboardingTitle3 = 'Бонусы\nи подарки';

// Основной экран
const String discountBottomSheetTitle = 'Как получить скидку';
const String appBarWeekTitleDefault = 'Меню недели';
const String mainScreenChangeWeekTitle =
    'При смене недели корзина очистится. Сменить неделю?';
const String mainScreenChangeWeekAccept = 'Сменить неделю';
const String mainScreenChangeWeekCancel = 'Не менять';
const String mainScreenPromoText = ' при заказе до 5 ужинов';
const String mainScreenPromoTextShort = ' до 5 ужинов';

const String updateDialogText = 'Доступна новая версия приложения';
const String updateDialogAgreeButtonText = 'Обновить';
const String updateDialogDisagreeButtonText = 'Отмена';

String getDiscountText(int discount) => '$discount%';

//Todo убрать - с сервера
const String discountBottomSheetTempContent =
    'После первого заказа вы получите скидку 3$nbsp%, которая будет действовать неделю. Второй заказ в течение недели повысит скидку до 7$nbsp%. Скидка 3$nbsp% и 7$nbsp% действует на все меню.\n\nКроме того, вы всегда можете получить скидку 10$nbsp% на ужины, если закажете сразу четыре. Пятый увеличит скидку до 17$nbsp%.';
const String weekInfoText =
    'Новое меню каждую неделю.\nДоставляем по понедельникам, пятницам и воскресеньям.';
//Todo убрать до сюда

// Корзина
// String getHintToAvailable(int count) =>
//     'Добавьте $count ${mainDishesPlural(count)} для заказа';
String getHintToAvailable({int minPrice, int deltaPrice}) =>
    'Заказ от $minPrice₽. Не хватает еще $deltaPrice₽';

String getHintToDiscount(int count, int discount) =>
    'Добавьте ещё $count ${mainDishesPlural(count)} для скидки $discount %';

//локальные уведомления
const notificationChannelId = 'channel_id'; //TODO notification id
const notificationChannelName =
    'notification_channel'; //TODO notification channel
const notificationDescription = 'notification';

/// [PremiumDishCard]
const premiumPremiumDishCardWidgetText = 'ПРЕМИУМ';

/// [ProductDetailsScreen]
const weWillBringProductDetailsWidgetText = 'Мы привезём';
const youWillNeedProductDetailsWidgetText = 'Вам понадобятся';
const in100ProductDetailsForYouWidgetText =
    'Пищевая и энергитическая ценность (100 гр.)';
const in100ProductDetailsWidgetText = 'В 100 г.';
const productProductDetailsWidgetText = 'продукта';
const kcalProductDetailsWidgetText = 'ккал';
const proteinProductDetailsWidgetText = 'белки';
const fatProductDetailsWidgetText = 'жиры';
const carbsProductDetailsWidgetText = 'углеводы';

/// [PhoneInput]
const phoneInputWidgetLabelText = 'Номер телефона';

/// [AuthScreen]
const authScreenEnterText = 'Вход';
const authScreenAcceptButtonText = 'Далее';
const authScreenAcceptEnterNumberPhoneErrorText =
    'Введите номер телефона, на который вам можно прислать СМС с кодом подтверждения';
const authScreenAcceptExceedTheNumberOfAttemptsErrorText =
    'Вы превысили количество попыток, попробуйте немного позднее';

const authScreenPolitics =
    'Нажимая кнопку «Далее» вы соглашаетесь с условиями ';
const authScreenPoliticsButtonUrlString = 'Пользовательского соглашения';
const authScreenPhoneEmpty = 'Поле не заполнено';
const authScreenPhoneWrongFormat = 'Неверный формат';

/// [MainDrawerWidget]
const ordersMainDrawerWidgetText = 'Заказы';
const recipesMainDrawerWidgetText = 'Рецепты';
const discountMainDrawerWidgetText = 'Получить 500 бонусов';
const profileMainDrawerWidgetText = 'Профиль';
const aboutServiceMainDrawerWidgetText = 'О сервисе';
const logoutMainDrawerWidgetText = 'Выйти';
const callToMainDrawerWidgetText = 'Мы на связи';
const everyDayMainDrawerWidgetText = 'ежедневно с 10 до 20';

/// [AboutScreen]
const aboutScreenUserAgreement = 'Пользовательское соглашение';
const aboutScreenBlog = 'Блог';
const aboutScreenFAQ = 'Частые вопросы';

/// [ConfirmationScreen]
const confirmationScreenSendNewCodeText = 'Отправить новый код';
const confirmationScreenOtherPhoneNumberText = 'Другой номер телефона';
const confirmationScreenOtherSentTextMessageText =
    'Мы отправили СМС с кодом на номер';
const confirmationScreenInvalidCodeText = 'Неверный код';

/// [AddressForm]
const addressCreateTitle = 'Добавление адреса';
const addressUpdateTitle = 'Редактирование адреса';
const addressFormAddressLabel = 'Город, улица, дом';
const addressFormFlatLabel = 'Квартира';
const addressFormSectionAddressLabel = 'Подъезд';
const addressFormFloorAddressLabel = 'Этаж';
const addressFormCommentAddressHint = 'Код, домофон, комментарии';
const commentLabel = 'Комментарий';
const addressIsDefaultAddressLabel = 'Основной адрес';
const addressNotFound = 'Адрес не найден';
const addressAdd = 'Добавить';

const addressesDefault = 'Основной';
const addressesAdditional = 'Дополнительные';
const addressAddNewAddressButton = 'Добавить адрес';

const addressDeleteDialogTitle = 'Удалить адрес?';
const deleteDialogAgree = 'Удалить';
const deleteDialogCancel = 'Не удалять';

String confirmationScreenSendNewCodeThroughText(String time) =>
    'Отправить новый код можно через $time';

/// [OrderDialogController]
const dialogSelectCardTitle = 'Выберите карту для оплаты';
const dialogSelectAddressTitle = 'Адрес доставки';
const dialogSelectPaymentMethod = 'Способ оплаты';
const paymentMethodCard = 'Банковская карта';
const paymentMethodCash = 'Наличные';
const paymentMethodGooglePay = 'Google Pay';
const paymentMethodApplePay = 'Apple Pay';

/// [DiscountScreen]
const discountMainText = 'Бонусы';
const discountAboutBonusText = 'Важно знать: Бонусы сгорают через 2 месяца';
const discountHowGetText = 'Как мне получить ';
const discountBonusesText = 'бонусы?';
const discountBonusesOnAccountText = 'Бонусов на счету: ';
const discountSocialCardInfoText =
    'Отправьте другу ссылку на наш промо-набор. \nВыгода для всех — ваш друг попробует вкусные ужины по привлекательной цене, а вы получите 500 бонусов на счёт за первый заказ и 5% от суммы всех последующих заказов друга в течение 84 дней.';
const discountSocialCardSharedLinkText =
    'Просто поделитесь ссылкой с\nдрузьями:';
const discountSocialCardGetBonusesText = 'Получите еще 500\nбонусов!';
const discountSocialCardBonusesForFriendText = 'Бонусы за друга';
const discountSocialCard500Text = '500';
const discountSocialCardBonusesText = 'бонусов';
const discountSocialCardFirstOrderText = 'За первый\nзаказ друга';
const discountSocialCardFromAmountText = 'От суммы последующих\nзаказов друга';
const discountSocialCard84Text = '84';
const discountSocialCardDaysText = 'дня';
const discountSocialCardYouGetBonusesText =
    'Вы получаете бонусы\nза заказы друга';
const discountSocialCardCopyLinkText = 'Скопировать ссылку';
const discountSocialCardSharedScialLinkText = 'Поделиться в соц. сетях:';
const discountSocialCardFriendsText = 'Приглашено друзей: ';
const discountSocialCardShareButtonText = 'Поделиться';

///[PromoScreen]
const promoScreenTitleText = 'Промо-набор';
const promoScreenButtonText = '5 блюд';
const promoScreenSpendText = '5 ужинов на двоих за ';
const promoScreenAboutText =
    'Доставим продукты с рецептами бесплатно в удобное время!';
const promoScreenBottomSheetTitle = 'Вы уже заказывали этот набор!';
const promoScreenBottomSheetTempContent =
    'Совсем недавно вы уже заказывали эти ужины. Вы можете попробовать блюда из основного меню.';
const promoScreenBottomSheetCloseButtonText = 'Перейти в меню';

/// [ProfileScreen]
const profileScreenProfileText = 'Профиль';
const profileScreenMyDetailsText = 'МОИ ДАННЫЕ';
const profileScreenAddressesText = 'АДРЕСА';
const profileScreenPaymentText = 'ОПЛАТА';
const profileScreenErrorText =
    'Не удалось загрузить страницу.\nПопробуйте обновить позже.';
const userCardsAddCard = 'Добавить карту';
const userCardsEmptyCardsList =
    'Здесь можно привязать карту, чтобы заказывать быстрее. Мы никогда не списываем деньги без вашего ведома.';
const userCardsNeedDelete = 'Удалить карту?';
const userDeleteQuestion = 'Уверены, что хотите удалить аккаунт?';

/// [UserDetailsWidget]
const userDetailsWidgetMainText = 'Главное';
const userDetailsBirthdayReminder =
    'Добавьте дату рождения, чтобы получить скидку 1000₽ в день рождения';
const userDetailsWidgetMoreText = 'Дополнительно';
const userDetailsWidgetFavoriteDishesText = 'Любимые блюда';
const userDetailsWidgetFavoriteDishesLabelTextText = 'Любимое блюдо';
const userDetailsWidgetFavoriteDishesInfoText =
    'Учитываем эту информацию при подборе меню. Можно указать до 5 блюд';
const userDetailsWidgetMinimalInformationText =
    'Без этого не сможем принять заказ';
const userDetailsWidgetNameText = 'Имя';
const userDetailsWidgetSurnameText = 'Фамилия';
const userDetailsWidgetPhoneText = 'Телефон';
const userDetailsWidgetEmailText = 'Почта';
const userDetailsWidgetBirthdayText = 'Дата рождения';
const userDetailsWidgetSaveText = 'Сохранить';
const userDetailsWidgetBirthdayInfoText =
    'После заполнения нельзя будет поменять';
const userDetailsWidgetInfoSmsText =
    'Присылаем СМС с деталями доставки. Можем позвонить, если остались вопросы по заказу';
const userDetailsWidgetDetailsInfoText = 'Присылаем детали заказа и чеки';
const userDetailsWidgetMoreInfoText =
    'Необязательно для заказа, но помогает нам лучше понимать аудиторию и развивать сервис';
const userDetailsWidgetRadioManText = 'Мужчина';
const userDetailsWidgetRadioWomanText = 'Женщина';
const userDetailsWidgetFailSnackBarText =
    'Не удалось изменить данные.\nПопробуйте позже.';
const userDetailsWidgetSuccessfullyText = 'Данные изменены.';
const userDetailsWidgetSearchErrorText =
    'Не удалось получить список блюд.\nПопробуйте позже.';
const userDetailsWidgetNoSearchText = 'Не нашлось блюд с таким\nназванием';

/// [ReplacementPhoneNumberScreen]
const replacementPhoneNumberScreenChangeTheNumberText = 'Смена номера телефона';
const replacementPhoneNumberScreenNextText = 'Далее';
const replacementPhoneNumberScreenChangeTheNumberInfoText =
    'Введите номер телефона, на который вам можно прислать СМС с кодом подтверждения';

/// [ConfirmationReplacementPhoneNumberScreen]
const confirmationReplacementPhoneNumberChangeTheNumberText =
    'Смена номера телефона';

const cartTitleCardText = 'Корзина';
const cartDeleteDishTitle = 'Удалить блюдо из заказа?';

/// OrderScreens
const createOrderTitle = 'Оформление заказа';
const createOrderClientTitle = 'Получатель';
const createOrderUserInfoDescription =
    'Без этих данных не сможем принять заказ. Вы всегда можете изменить их в профиле';
const createOrderPhoneTitle =
    'Присылаем СМС с деталями доставки. Можем позвонить, если остались вопросы по заказу';
const createOrderEmailTitle = 'Присылаем детали заказа и чеки';
const createOrderAddressTitle = 'Адрес доставки';
const createOrderAddressComment = 'Комментарий';
const createOrderAnotherClient = 'Другой получатель';
const createOrderBtnNextTitle = 'Далее';
const createOrderBtnCreateTitle = 'Заказать';
const createOrderCloseSheetTitle = 'Вернуться в меню?';
const createOrderCloseSheetSubtitle = 'Выбранные блюда сохранятся в корзине';
const createOrderCloseSheetCancel = 'Продолжить оформление';
const createOrderCloseSheetAccept = 'Вернуться в меню';
const createOrderDateTitle = 'Дата';
const createOrderTimeIntervalTitle = 'Время';
const createOrderThanks = 'Спасибо за заказ!';
const createOrderOpenOrders = 'Посмотреть заказы';
const createOrderOpenRecipes = 'Все рецепты в приложении';
const createOrderOpenCatalog = 'Вернуться в каталог';
const createOrderOpenDiscount = 'Пригласить друга и получить 500₽';
const createOrderPaymentTitle = 'Оплата';
const createOrderAddCard = 'Добавить карту';
const createOrderApplyPromoCode = 'Применить промокод';
const createOrderPromoCode = 'Промокод';
const createOrderApplyBonus = 'Списать бонусы';
const createOrderDiscontTitle = 'Скидки за лояльность';
const createOrderDiscontText =
    'Уже со следующим заказом вы получите скидку, которая будет расти.От 3 до 7 %. Чаще заказываете - больше скидка.';
const createOrderNewOrderTitle =
    'У вас уже есть заказ на эту неделю. Оформить ещё один?';
const createOrderNewOrderSubtitle =
    'Это можно будет изменить на следующем шаге';
const createOrderNewOrderSelf = 'Заказать для себя';
const createOrderNewOrderAnotherClient = 'Заказать другому человеку';
const createOrderAlreadyPayedTitle =
    'При заказе продуктов заранее на следующую неделю, мы спишем деньги автоматически в$nbspближайший вторник перед днём доставки. При оформлении заказа на эту неделю$nbsp-$nbspденьги будут списаны с$nbspкарты сразу.';
const createOrderMayBePayedTitle =
    'Отследить статус, изменить или отменить доставку можно в разделе «Заказы»';
const createOrderFirstOrderTitle1 = 'Поздравляем, вы стали членом клуба';
const createOrderFirstOrderTitle2 = ' Ужин Дома Family!';
const createOrderWrongAddressMoscow =
    'Ваша корзина собрана для Москвы и мы не сможем доставить её по указанному адресу. Хотите выбрать другой или собрать корзину заново?';
const createOrderWrongAddressStP =
    'Ваша корзина собрана для Питера и мы не сможем доставить её по указанному адресу. Хотите выбрать другой или собрать корзину заново?';
const createOrderWrongAddressDefault =
    'Ваша корзина собрана для другого города и мы не сможем доставить её по указанному адресу. Хотите выбрать другой или собрать корзину заново?';
const createOrderChangeAddress = 'Выбрать другой адрес';
const createOrderClearCart = 'Собрать корзину заново';
const createOrderNeedToSelectDate =
    'Перед продолжением необходимо выбрать дату и время доставки.';

/// Стоимость заказа
const fullPriceTitle = 'Сумма';
const discountTitle = 'Ужин Дома Family';
const discountCountTitle = 'Скидка за';
const priceTitle = 'Итого';
const bonusesTitle = 'Бонусы';
const promoCodeTitle = 'Промокод';

/// [OrdersHistoryScreen]
const orderHistoryAppBarTitle = 'Заказы';
const orderHistoryNewTabTitle = 'НОВЫЕ';
const orderHistoryCompletedTabTitle = 'ВЫПОЛНЕННЫЕ';
const orderCanceled = 'ОТМЕНЁН';
const orderPaid = 'ОПЛАЧЕН';
const orderConfirmed = 'ПОДТВЕРЖДЁН';
const orderDeliveryTitle = 'Доставка';
const orderAddressTitle = 'По адресу';
const orderPaymentTitle = 'Оплата';
const recipeTypeTitle = 'Рецепт';
const recipeType = 'Тип рецепта';
const paperRecipe = 'Бумажный';
const noPaperRecipe = 'Электронный';
const orderChange = 'Изменить';
const orderRestore = 'Восстановить';
const orderEmpty = 'У вас пока нет заказов';
const orderDelivered = 'доставлен';
const orderRateBtn = 'Оценить';
const orderCancelPaidTitle = 'Оплаченный заказ можно отменить через менеджера';
const orderCancelPaidAccept = 'Позвонить менеджеру';
const orderCancelPaidCancel = 'Не отменять';
const orderCancelConfirmedTitle = 'Отменить заказ?';
const orderCancelConfirmedAccept = 'Отменить заказ';
const orderCancelConfirmedCancel = 'Не отменять';
const orderCancelReasonLeave = 'Уезжаем и не сможем получить заказ';
const orderCancelReasonMenu = 'Не подошло меню';
const orderCancelReasonDate = 'Не подошла дата и время доставки';
const orderCancelReasonPayment = 'Не прошла оплата';
const orderCancelReasonAnotherService = 'Заказали в другом сервисе';
const orderCancelReasonAnotherOrder = 'Оформили другой заказ';
const orderCancelReasonOther = 'Другое';
const orderCancelReasonComment = 'Комментарий';
const orderCancelReasonSubtitle =
    'Мы очень хотим улучшить сервис! Поэтому, пожалуйста, укажите причину отмены заказа';
const orderChangePaidTitle = 'Этот заказ можно изменить только через менеджера';
const orderChangePaidAccept = 'Позвонить менеджеру';
const orderChangePaidCancel = 'Закрыть';
const orderChangeConfirmedTitle = 'Отменить заказ?';
const orderChangeAddress = 'Адрес доставки';
const orderChangeDeliveryTime = 'Дату и время доставки';
const orderChangePayment = 'Способ оплаты';
const orderChangeWrongAddress = 'Доставка в выбранный город невозможна.';

/// [CartScreen]
const cartCreateOrder = 'Оформить заказ';
const cartOpenCatalog = 'Выбрать блюда';
const cartListTitle = 'Ваш заказ';
const cartWeekPrefix = 'на неделю ';
const cartClearTitle = 'Удалить все блюда из заказа?';
const cartNoPaperRecipe = 'Электронный';
const cartPaperRecipe = 'Бумажный';
const cartNoPaperRecipeDescription =
    'Электронный рецепт будет доступен в приложении после доставки';
const cartPaperRecipeDescription = 'Бумажный рецепт доставим вместе с заказом';
const cartNoPaperText = 'Все ваши рецепты хранятся в приложении';
const cartRecipeTypeHeader = 'Тип Рецепта';
const cartRecipeTypeDescription =
    'Выберите тип рецепта, который вы хотите получить с заказом. Это обязательное поле.';
const cartRecipeTypeTitleErr =
    'Выберите тип рецепта, который вы хотите получить вместе с заказом:';
const cartNoPaperAbout1 =
    'Все электронные рецепты хранятся в приложении в разделе рецепты и всегда под рукой.';
const cartNoPaperAbout2 = 'Просто нажмите на нужное блюдо и начните готовить.';
const cartAddToOrderTitle = 'Добавьте к заказу';

/// [RateOrderScreen]
const rateScreenTitle = 'Оценка заказа';
const rateNoRatedTitle = 'Оцените блюдо';
const rateRatedDishTitle = 'Ваша оценка';
const rateRateRecipeTitle = 'Насколько понятен был рецепт?';

const rateLowTitle = 'Расскажите, что не понравилось?';
const rateLowCooking = 'Долгое и сложное приготовление';
const rateLowOther = 'Другое';
const rateLowQuality = 'Плохое качество продуктов';
const rateLowTaste = 'Вкус не понравился';

/// [NewOrderInfoScreen]
const orderInfoTitle = 'Просмотр заказа';
const orderInfoBackToList = 'Вернуться в заказы';

/// [ChangeOrderScreen]
const String changeOrderTitle = 'Изменение заказа';

/// [RecipesScreen]
const String recipesActualTitle = 'АКТУАЛЬНЫЕ';
const String recipesOldTitle = 'ВСЕ';
const String recipesLikeTitle = 'ЛЮБИМЫЕ';
const String recipesDetailTitle = 'Рецепт';
const String recipesSearchTitle = 'Поиск по блюду или ингредиенту';
const String recipesBtnDone = 'Блюдо готово!';
const String recipesBtnRate = 'Понравился рецепт?';
const String recipesDoneSnack = 'Рецепт скрыт из актуальных';
const String recipeIngredients = 'Ингредиенты';
const String recipesOldEmpty =
    'У вас пока нет ни одного рецепта. Они появятся, как только доставят первый заказ.';
const String recipesActualEmpty =
    'У вас пока нет новых рецептов. Они появятся, как только доставят блюда.';
const String recipesLikeEmpty =
    ' Вы пока не добавили ни одного рецепта в любимые.';
const String recipesDatePrefix = 'Приготовить до';
const String recipesNotAvailable = 'Рецепт откроется в день доставки';

const String selectPaymentsNoCard =
    'Необходимо выбрать карту или добавить новую.';

/// [New Banners]
const String copyTextDialog1 = 'Промокод ';
const String copyTextDialog2 =
    ' скопирован. Примените его при оформлении заказа.';
const String copyTextDialogBtn = 'Хорошо';
