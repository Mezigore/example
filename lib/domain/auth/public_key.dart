import 'package:flutter/material.dart';

/// Модель публичного ключа.
/// Используется как динамическая часть подтверждения серверу,
/// что мы валидный мобильный клиент при авторизации.
/// [publicKey] - публичный ключ, некоторая сгенерированная
/// сервером последовательность символов.
/// [endTime] - время истекания действия данного публичного ключа.
class PublicKey {
  PublicKey({
    @required this.publicKey,
    @required this.endTime,
  });

  final String publicKey;
  final DateTime endTime;
}
