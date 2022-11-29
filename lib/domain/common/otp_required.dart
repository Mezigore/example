/// Модель, которая приходит, если нужен ОТП
class OtpRequired {
  OtpRequired({
    this.nextOtp,
  });

  /// Время возможной отправки следующего кода. В секундах
  double nextOtp;
}
