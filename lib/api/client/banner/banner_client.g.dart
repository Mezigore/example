// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _BannerClient implements BannerClient {
  _BannerClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<BannerData>> getBanner() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/banners',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map((dynamic i) => BannerData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<NewBannersData>> getNewBanners() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/banners/app',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            ),
        data: _data);
    var value = _result.data
        .map((dynamic i) => NewBannersData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
