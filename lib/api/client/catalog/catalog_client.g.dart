// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CatalogClient implements CatalogClient {
  _CatalogClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<CategoryItemData>> getMenu(city, date) async {
    ArgumentError.checkNotNull(city, 'city');
    ArgumentError.checkNotNull(date, 'date');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'city': city, r'date': date};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/catalog',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map(
            (dynamic i) => CategoryItemData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<WeekItemData>> getWeekInfo(city) async {
    ArgumentError.checkNotNull(city, 'city');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'city': city};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/catalog/weeks',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map((dynamic i) => WeekItemData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<RecommendationItemData> recommend(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/catalog/recommend?userID={id}',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = RecommendationItemData.fromJson(_result.data);
    return value;
  }

  @override
  Future<PromoItemData> getPromo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/catalog/promoApp',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            ),
        data: _data);
    final value = PromoItemData.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<CityItemData>> getCities() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/catalog/cities',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map((dynamic i) => CityItemData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<CityItemData> getCityByPosition(lat, long) async {
    ArgumentError.checkNotNull(lat, 'lat');
    ArgumentError.checkNotNull(long, 'long');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'lat': lat, r'long': long};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/catalog/cities/preferred',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = CityItemData.fromJson(_result.data);
    return value;
  }

  @override
  Future<CityItemData> getCityByIp() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/catalog/cities/preferred',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = CityItemData.fromJson(_result.data);
    return value;
  }
}
