// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RecipesClient implements RecipesClient {
  _RecipesClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<RecipeData>> getNew() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/recipes/new',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map((dynamic i) => RecipeData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<RecipeData>> getRecipes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/recipes',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map((dynamic i) => RecipeData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<RecipeData>> getListLikeRecipes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/recipes/favorite',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map((dynamic i) => RecipeData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<InfoMessageData> postIdRate(id, ordersHistoryRaitings) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(ordersHistoryRaitings, 'ordersHistoryRaitings');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = ordersHistoryRaitings.map((e) => e.toJson()).toList();
    final _result = await _dio.request<Map<String, dynamic>>('/order/$id/rate',
        queryParameters: queryParameters,
        options: Options(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = InfoMessageData.fromJson(_result.data);
    return value;
  }

  @override
  Future<InfoMessageData> postRecipesId(id, arhive) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(arhive, 'arhive');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(arhive?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/recipes/$id',
        queryParameters: queryParameters,
        options: Options(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = InfoMessageData.fromJson(_result.data);
    return value;
  }

  @override
  Future<void> getLikeRecipes(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/recipes/like/$id',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    return null;
  }

  @override
  Future<void> getUnlikeRecipes(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/recipes/unlike/$id',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    return null;
  }
}
