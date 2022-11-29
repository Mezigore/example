import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uzhindoma/api/data/cart/cart_data.dart';
import 'package:uzhindoma/api/data/cart/edit_cart_item_data.dart';
import 'package:uzhindoma/interactor/common/urls.dart';

part 'cart_client.g.dart';

/// Интерфейс API корзины.
@RestApi()
abstract class CartClient {
  factory CartClient(Dio dio, {String baseUrl}) = _CartClient;

  @GET(CartApiUrl.getCart)
  Future<CartData> getCart();

  @GET(CartApiUrl.getPromoCart)
  Future<CartData> getPromoCart(@Query('promoname') String promoname);

  @POST(CartApiUrl.clearCart)
  Future<void> clearCart();

  @POST(CartApiUrl.addToCart)
  Future<void> addToCart(@Body() EditCartItemData data);

  @DELETE(CartApiUrl.removeFromCart)
  Future<void> removeFromCart(@Body() EditCartItemData data);

  @DELETE(CartApiUrl.removeExtra)
  Future<void> removeExtra(@Query('id') String id);

  @POST(CartApiUrl.addPromo)
  Future<String> addPromo();

}
