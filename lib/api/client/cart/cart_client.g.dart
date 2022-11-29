// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CartClient implements CartClient {
  _CartClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<CartData> getCart() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/cart',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = CartData.fromJson(_result.data);
    return value;
  }

  @override
  Future<CartData> getPromoCart(promoname) async {
    ArgumentError.checkNotNull(promoname, 'promoname');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/cart?promoname=$promoname',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            ),
        data: _data);
    final value = CartData.fromJson(_result.data);
    return value;
  }

  @override
  Future<void> clearCart() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/cart/clear',
        queryParameters: queryParameters,
        options: Options(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    return null;
  }

  @override
  Future<void> addToCart(data) async {
    ArgumentError.checkNotNull(data, 'data');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data?.toJson() ?? <String, dynamic>{});
    await _dio.request<void>('/cart',
        queryParameters: queryParameters,
        options: Options(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    return null;
  }

  @override
  Future<void> removeFromCart(data) async {
    ArgumentError.checkNotNull(data, 'data');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data?.toJson() ?? <String, dynamic>{});
    await _dio.request<void>('/cart',
        queryParameters: queryParameters,
        options: Options(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    return null;
  }

  @override
  Future<void> removeExtra(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/cart/extra',
        queryParameters: queryParameters,
        options: Options(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    return null;
  }

  @override
  Future<String> addPromo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/cart/addPromo',
        queryParameters: queryParameters,
        options: Options(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            ),
        data: _data);
    return _result.data['text'];
  }

}
