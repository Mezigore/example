// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OrderClient implements OrderClient {
  _OrderClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<DeliveryAvailableData> getAddress(cityId) async {
    ArgumentError.checkNotNull(cityId, 'cityId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'city_id': cityId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/order/address',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = DeliveryAvailableData.fromJson(_result.data);
    return value;
  }

  @override
  Future<OrderIdData> postCreate(createdOrder) async {
    ArgumentError.checkNotNull(createdOrder, 'createdOrder');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(createdOrder?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/order/create',
        queryParameters: queryParameters,
        options: Options(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = OrderIdData.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<InfoMessageData>> postIdPay(id, cardID) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(cardID, 'cardID');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(cardID?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<List<dynamic>>('/order/$id/pay',
        queryParameters: queryParameters,
        options: Options(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map((dynamic i) => InfoMessageData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<OrderSummData> postOrder() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/order',
        queryParameters: queryParameters,
        options: Options(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = OrderSummData.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<DeliveryDateData>> getPeriods(city) async {
    ArgumentError.checkNotNull(city, 'city');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'city': city};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/order/periods',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map(
            (dynamic i) => DeliveryDateData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<OrderSummData> deleteSummIdBonuses(summId) async {
    ArgumentError.checkNotNull(summId, 'summId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/order/$summId/bonuses',
        queryParameters: queryParameters,
        options: Options(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = OrderSummData.fromJson(_result.data);
    return value;
  }

  @override
  Future<BonusData> getSummIdBonuses(summId) async {
    ArgumentError.checkNotNull(summId, 'summId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/order/$summId/bonuses',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = BonusData.fromJson(_result.data);
    return value;
  }

  @override
  Future<OrderSummData> postSummIdBonuses(summId) async {
    ArgumentError.checkNotNull(summId, 'summId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/order/$summId/bonuses',
        queryParameters: queryParameters,
        options: Options(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = OrderSummData.fromJson(_result.data);
    return value;
  }

  @override
  Future<OrderSummData> deleteSummIdPromocode(summId) async {
    ArgumentError.checkNotNull(summId, 'summId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/order/$summId/promocode',
        queryParameters: queryParameters,
        options: Options(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = OrderSummData.fromJson(_result.data);
    return value;
  }

  @override
  Future<OrderSummData> postSummIdPromocode(summId, promocode) async {
    ArgumentError.checkNotNull(summId, 'summId');
    ArgumentError.checkNotNull(promocode, 'promocode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(promocode?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/order/$summId/promocode',
        queryParameters: queryParameters,
        options: Options(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    final value = OrderSummData.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<OrderFromHistoryData>> getHistory() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/order/history',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            OrderFromHistoryData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<NewOrderData>> getHistoryNew() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/order/history/new',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map((dynamic i) => NewOrderData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<DeliveryDateData>> getIdPeriods(id, city) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(city, 'city');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'city': city};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/order/$id/periods',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
           ),
        data: _data);
    var value = _result.data
        .map(
            (dynamic i) => DeliveryDateData.fromJson(i as Map<String, dynamic>))
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
  Future<InfoMessageData> postIdRestore(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/order/$id/restore',
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
  Future<InfoMessageData> deleteOrderId(id, reason) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(reason, 'reason');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll({'reason': reason});
    final _result = await _dio.request<Map<String, dynamic>>('/order/$id',
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
  Future<InfoMessageData> patchOrderId(id, orderUpdating) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(orderUpdating, 'orderUpdating');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(orderUpdating?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/order/$id',
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
  Future<InfoMessageData> postIdPaySystems(id, paySystem) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(paySystem, 'paySystem');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(paySystem?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/order/$id/pay_systems',
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
}
