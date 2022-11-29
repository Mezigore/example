// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _UserClient implements UserClient {
  _UserClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<OtpRequiredData> patchChangePhone(changePhone) async {
    ArgumentError.checkNotNull(changePhone, 'changePhone');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(changePhone?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/user/changePhone',
        queryParameters: queryParameters,
        options: Options(
            method: 'PATCH',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = OtpRequiredData.fromJson(_result.data);
    return value;
  }

  @override
  Future<InfoMessageData> patchConformChangePhone(conformChangePhone) async {
    ArgumentError.checkNotNull(conformChangePhone, 'conformChangePhone');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(conformChangePhone?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/user/conformChangePhone',
        queryParameters: queryParameters,
        options: Options(
            method: 'PATCH',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = InfoMessageData.fromJson(_result.data);
    return value;
  }

  @override
  Future<void> deleteFavourite(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/user/favourite',
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
  Future<List<FavouriteItemData>> getFavourite(searchText) async {
    ArgumentError.checkNotNull(searchText, 'searchText');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'searchText': searchText};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/user/favourite',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            FavouriteItemData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<void> postFavourite(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/user/favourite',
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
  Future<int> getOrdersCount() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<int>('/user/ordersCount',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<AllClientInfoData> getProfile() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/user/profile',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = AllClientInfoData.fromJson(_result.data);
    return value;
  }

  @override
  Future<InfoMessageData> patchProfile(updateProfile) async {
    ArgumentError.checkNotNull(updateProfile, 'updateProfile');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(updateProfile?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/user/profile',
        queryParameters: queryParameters,
        options: Options(
            method: 'PATCH',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = InfoMessageData.fromJson(_result.data);
    return value;
  }

  @override
  Future<void> deleteProfile() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/user/delete',
        queryParameters: queryParameters,
        options: Options(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    return null;
  }
}
