// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _PaymentClient implements PaymentClient {
  _PaymentClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<PaymentCardData>> getCards() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/cards',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map((dynamic i) => PaymentCardData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<InfoMessageData> deleteCardsId(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/cards/$id',
        queryParameters: queryParameters,
        options: Options(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = InfoMessageData.fromJson(_result.data);
    return value;
  }

  @override
  Future<InfoMessageData> putCardsId(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/cards/$id',
        queryParameters: queryParameters,
        options: Options(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = InfoMessageData.fromJson(_result.data);
    return value;
  }
}
