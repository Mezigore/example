import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/util/const.dart';

/// Загружает image, показывает шиммер и ошибку
class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({
    Key key,
    this.urlImage,
    BoxFit boxFit,
    this.color,
  })  : _boxFit = boxFit ?? BoxFit.cover,
        super(key: key);

  /// url фото
  final String urlImage;
  final BoxFit _boxFit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      urlImage ?? emptyString,
      fit: _boxFit,
      color: color,
      colorBlendMode: BlendMode.srcATop,
      loadingBuilder: (context, child, loadingProgress) =>
          loadingProgress == null
              ? child
              : const SkeletonWidget(isLoading: true),
      errorBuilder: (context, _, __) => Image.asset(noPhoto),
    );
  }
}
