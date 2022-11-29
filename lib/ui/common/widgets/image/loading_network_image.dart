import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';

/// Изображение, загружаемое из интернета.
class LoadingNetworkImage extends StatelessWidget {
  const LoadingNetworkImage({
    Key key,
    @required this.imageUrl,
    this.width,
    this.height,
    this.boxFit = BoxFit.cover,
  })  : assert(imageUrl != null),
        assert(boxFit != null),
        super(key: key);

  final String imageUrl;
  final double width;
  final double height;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl,
        height: height,
        width: width,
        fit: boxFit,
        placeholderBuilder: (ctx) {
          return SkeletonWidget(
            isLoading: true,
            height: height,
            width: width,
          );
        },
      );
    }

    return Image.network(
      imageUrl ?? '',
      height: height,
      width: width,
      fit: boxFit,
      loadingBuilder: (ctx, child, progress) {
        return progress == null
            ? child
            : SkeletonWidget(
                isLoading: true,
                height: height,
                width: width,
              );
      },
      errorBuilder: (ctx, error, stacktrace) {
        // изображение подходящее
        return SkeletonWidget(
          isLoading: false,
          height: height,
          width: width,
        );
      },
    );
  }
}
