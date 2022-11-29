import 'package:dio/dio.dart';

/// Репозиторий <todo>
class TempRepository {
  TempRepository(this.http);

  final Dio http;
}
