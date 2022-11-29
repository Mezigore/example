// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AppClient implements AppClient {
  _AppClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<AppVersionData> getAppVersion() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/apps/versions',
        queryParameters: queryParameters,
        options: Options(
          method: 'GET',
          headers: <String, dynamic>{},
          extra: _extra,
        ),
        data: _data);
    final value = AppVersionData.fromJson(_result.data);
    return value;
  }
}
