import 'package:flutter/material.dart' hide Action, Banner;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/banner/banner.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/main/widget/banner/banner_gallery_wm.dart';
import 'package:uzhindoma/ui/screen/main/widget/banner/di/banner_gallery_component.dart';

/// Гелерея баннеров для главного экрана
class BannerGallery extends MwwmWidget<BannerGalleryComponent> {
  BannerGallery({Key key})
      : super(
          widgetModelBuilder: createBannerGalleryWidgetModel,
          dependenciesBuilder: (context) => BannerGalleryComponent(context),
          widgetStateBuilder: () => _BannerGalleryState(),
          key: key,
        );
}

class _BannerGalleryState extends WidgetState<BannerGalleryWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return EntityStateBuilder<List<Banner>>(
      streamedState: wm.bannerListState,
      loadingChild: const SizedBox.shrink(),
      child: (context, banners) {
        return (banners?.length ?? 0) == 0
            ? const SizedBox.shrink()
            : SizedBox(
                height: 110,
                child: PageView.builder(
                  itemCount: banners?.length ?? 0,
                  itemBuilder: (context, items) {
                    final Banner banner = banners[items];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () => wm.openBrowserAction(banner.url),
                        child: _BannerForMenuWidget(
                          title: banner.title,
                          description: banner.description,
                          imageUrl: banner.imageUrl,
                        ),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}

/// Баннер для меню
class _BannerForMenuWidget extends StatelessWidget {
  const _BannerForMenuWidget({
    Key key,
    @required String title,
    @required String description,
    String imageUrl,
  })  : _title = title,
        _description = description,
        _imageUrl = imageUrl,
        super(key: key);

  /// Иконка
  final String _imageUrl;

  /// Текст баннера
  final String _title;

  /// Текст кнопки
  final String _description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: bannerPrimary,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _ImageBanner(
            imageUrl: _imageUrl,
          ),
          _InfoBanner(
            title: _title,
            description: _description,
          ),
        ],
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({
    Key key,
    @required this.title,
    @required this.description,
  })  : assert(title != null),
        assert(description != null),
        super(key: key);

  /// Текст баннера
  final String title;

  /// Текст кнопки
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 115, right: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 23),
          Text(
            title,
            style: textRegular14,
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: textMedium14,
          ),
        ],
      ),
    );
  }
}

class _ImageBanner extends StatelessWidget {
  const _ImageBanner({
    Key key,
    @required this.imageUrl,
  })  : assert(imageUrl != null),
        super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      color: whiteTransparent,
      colorBlendMode: BlendMode.srcATop,
      loadingBuilder: (ctx, child, progress) {
        if (progress == null) {
          return child;
        } else {
          return const SkeletonWidget(isLoading: true);
        }
      },
      errorBuilder: (ctx, error, stacktrace) {
        return const SizedBox.shrink();
      },
    );
  }
}
