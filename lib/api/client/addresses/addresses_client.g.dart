// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addresses_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AddressesClient implements AddressesClient {
  _AddressesClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<UserAddressData>> getAddresses() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/addresses',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
        ),
        data: _data);
    var value = _result.data
        .map((dynamic i) => UserAddressData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<UserAddressData>> postAddresses(newAddress) async {
    ArgumentError.checkNotNull(newAddress, 'newAddress');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(newAddress?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<List<dynamic>>('/addresses',
        queryParameters: queryParameters,
        options: Options(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map((dynamic i) => UserAddressData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<UserAddressData>> deleteAddressesId(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/addresses/$id',
        queryParameters: queryParameters,
        options: Options(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map((dynamic i) => UserAddressData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<UserAddressData>> putAddressesId(id, newAddress) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(newAddress, 'newAddress');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(newAddress?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<List<dynamic>>('/addresses/$id',
        queryParameters: queryParameters,
        options: Options(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map((dynamic i) => UserAddressData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<String>> getSearch(address) async {
    ArgumentError.checkNotNull(address, 'address');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'address': address};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/addresses/search',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = _result.data.cast<String>();
    return value;
  }
}
