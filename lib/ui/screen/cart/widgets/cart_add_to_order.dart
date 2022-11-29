import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/catalog/menu/recommendation_item.dart';
import 'package:uzhindoma/ui/common/widgets/menu_item_button/menu_item_button_widget.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';
import 'package:uzhindoma/ui/widget/product/product_info.dart';
import 'package:uzhindoma/ui/widget/product/product_price.dart';

class CartAddToOrder extends StatelessWidget {
  const CartAddToOrder({Key key, this.recommend}) : super(key: key);

  final RecommendationItem recommend;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: Text(
              recommend.title,
              style: textMedium18,
            ),
          ),
          const SizedBox(height: 24,),
          SizedBox(
            height: 210,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(20,0, 20, 20),
              itemCount: recommend.products.length,
              separatorBuilder: (_, i){
                return const SizedBox(width: 10,);
              },
              itemBuilder: (context, i){
                return Container(
                  width: MediaQuery.of(context).size.width*0.88,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.08),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 8), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           SizedBox(
                            height: 102,
                            child: _ImageWidget(
                              imageUrl: recommend.products[i].previewImg,
                            ),
                          ),
                          // const SizedBox(width: 16),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.88 - 158,
                            child: Column(
                              children: [
                                Text(
                                  recommend.products[i].name,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: textRegular14,
                                ),
                                const SizedBox(height: 16),
                                ProductInfoWidget(
                                    cookingTime: recommend.products[i].properties.cookTimeUi,
                                    portion: recommend.products[i].properties.portionUi,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ProductPriceWidget(
                                      price: recommend.products[i].priceUi,
                                      measureUnit: recommend.products[i].measureUnit,
                                    ),
                                    MenuItemButtonWidget(
                                      cartElement: recommend.products[i],
                                      needAccentColor: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
              },
            ),
          ),
        ],
      );
  }
}


class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    Key key,
    @required this.imageUrl,
  })  : assert(imageUrl != null),
        super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: ProductImageWidget(
          urlImage: imageUrl,
          boxFit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
