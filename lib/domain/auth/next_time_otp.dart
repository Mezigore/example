import 'package:flutter/material.dart';

/// Модель-компаньон отправленной смс.
/// [nextOtp] - время ожидания в секундах перед отправкой следующей смс.
class NextTimeOtp {
  NextTimeOtp({
    @required this.nextOtp,
  });

  final int nextOtp;
}
