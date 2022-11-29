import 'package:intl/intl.dart';
import 'package:uzhindoma/util/const.dart';

const String nextButtonText = 'Готово';
const String closeButtonText = 'Закрыть';
const String okText = 'ОК';
const String cancelText = 'ОТМЕНА';
const String itemNotFoundException = 'Товар не найден';

const String userNotFoundText = 'Пользователь не найден';

const String wrongPromoCode = 'Неверный промокод';

///  Время - сокращенный текст
const minutesShort = 'мин.';
const hourShort = 'ч.';
const daysShort = 'д.';

const gramText = 'г.';
const rubleText = '₽';
const ellipsisText = '...';

const prefixPhoneNumberText = '+7';

//placeholder
const String errorPlaceholderTitleText = 'Данные недоступны';
const String errorPlaceholderSubtitleText = 'Попробуйте повторить позже';
const String errorPlaceholderBtnText = 'Обновить';

//ошибки сети
const serverErrorMessage =
    'Нет ответа от сервера, попробуйте еще раз или зайдите позже';
const serverErrorNotFound =
    'Произошла ошибка, данные не найдены. Попробуйте позже еще раз';
const defaultHttpErrorMessage =
    'Произошла ошибка, данные не найдены. Попробуйте позже еще раз';
const forbiddenErrorMessage = 'Доступ запрещен';
const noInternetConnectionErrorMessage =
    'Нет соединения с интернетом, проверьте подключение';
const badResponseErrorMessage =
    'Произошла ошибка загрузки данных на экране. Попробуйте позже еще раз';
const unexpectedErrorMessage = 'Непредвиденная ошибка';
const commonErrorText = 'Произошла ошибка. Попробуйте позже';
const errorAddressText =
    'Произошла ошибка. Проверьте корректность введенных данных';
const errorEmptyFields = 'Произошла ошибка. Все поля должны быть заполнены';

const saveTitle = 'Сохранить';

String daysText(int days) => '$days ${dayPlural(days)}';

String hoursText(int hours) => '$hours ${hourPlural(hours)}';

String minutesText(int minutes) => '$minutes ${minutesPlural(minutes)}';

String dayPlural(int days) => Intl.plural(
      days,
      zero: emptyString,
      one: 'день',
      two: 'дня',
      few: 'дней',
      other: 'дней',
      many: 'дней',
    );

String hourPlural(int hours) => Intl.plural(
      hours,
      zero: emptyString,
      one: 'час',
      two: 'часа',
      few: 'часов',
      other: 'часа',
      many: 'часов',
    );

String minutesPlural(int minutes) => Intl.plural(
      minutes,
      zero: 'минут',
      one: 'минута',
      two: 'минуты',
      few: 'минут',
      other: 'минут',
      many: 'минут',
    );

String dishesPlural(int dishes) => Intl.plural(
      dishes,
      zero: 'блюд',
      one: 'блюдо',
      two: 'блюда',
      few: 'блюда',
      other: 'блюд',
      many: 'блюд',
    );

String mainDishesPlural(int dishes) => Intl.plural(
      dishes,
      zero: 'ужин',
      one: 'ужин',
      two: 'ужина',
      few: 'ужина',
      other: 'ужинов',
      many: 'ужинов',
    );

/// Ширина экрана маленьких устройств
double smallDevice = 320;
