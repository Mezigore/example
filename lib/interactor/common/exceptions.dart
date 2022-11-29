import 'package:uzhindoma/ui/res/strings/common_strings.dart';

class MessagedException implements Exception {
  MessagedException(this.message);

  final String message;
}

/// Ошибка: ответ не найден
class NotFoundException extends MessagedException {
  NotFoundException(String message) : super(message);
}

/// Ошибка определения значения enum
class EnumArgumentException extends MessagedException {
  EnumArgumentException(String message) : super(message);
}

/// Ошибка недоступное действие
class UnavailableActionException extends MessagedException {
  UnavailableActionException(String message) : super(message);
}

/// Ошибка во время мапинга данных
class MappingException extends MessagedException {
  MappingException(this.mappingError) : super(mappingError.toString());
  final Error mappingError;
}

/// Ошибка применения промокода
class WrongPromoCodeException extends MessagedException {
  WrongPromoCodeException() : super(wrongPromoCode);
}

/// Ошибка отмена оплаты
class CancelPaymentException extends MessagedException {
  CancelPaymentException() : super('Пользователь закрыл шторку оплаты');
}
