import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart' hide Action, Banner;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uzhindoma/domain/banner/new_banners.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/screen/main/widget/new_banners/widgets/dialog.dart';
import 'package:uzhindoma/ui/screen/main/widget/new_banners/new_banners_gallery_wm.dart';
import 'package:uzhindoma/ui/screen/main/widget/new_banners/di/new_banners_gallery_component.dart';

/// Гелерея баннеров для главного экрана
class NewBannersGallery extends MwwmWidget<NewBannersGalleryComponent> {
  NewBannersGallery({Key key})
      : super(
    widgetModelBuilder: createBannerGalleryWidgetModel,
    dependenciesBuilder: (context) => NewBannersGalleryComponent(context),
    widgetStateBuilder: () => _NewBannersGalleryState(),
    key: key,
  );
}


class _NewBannersGalleryState extends WidgetState<NewBannersGalleryWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return EntityStateBuilder<List<NewBanners>>(
      streamedState: wm.newBannersListState,
      loadingChild: const SizedBox.shrink(),
      child: (context, banners) {
        return (banners?.length ?? 0) == 0
            ? const SizedBox.shrink()
            : Banners(wm: wm,);
      },
    );
  }
}

class Banners extends StatefulWidget {
  const Banners({Key key, this.wm}) : super(key: key,);

  final NewBannersGalleryWidgetModel wm;

  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  List<Widget> imageSliders;
  List<List<NewBanners>> listBanners;

  @override
  void initState() {
    super.initState();
    listBanners = widget.wm.parseBanners(widget.wm.newBannersListState.value.data);

    imageSliders = listBanners
        .map((item) => Cards(
      item: item,
      wm: widget.wm,
    )).toList();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: Column(
          children: [
            const SizedBox(height: 8,),
            SizedBox(
              height: MediaQuery.of(context).size.width/3.7,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                items: imageSliders,
                carouselController: _controller,
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    disableCenter: true,
                    viewportFraction: 0.90,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: listBanners.asMap().entries.map((entry) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 9.0,
                    height: 9.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == entry.key ? iconColorAccent : iconColorCornflowerBlue2 ,
                    ),
                  ),
                );
              }).toList(),
            ),
            // const SizedBox(height: 15,),
          ]),
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({Key key, this.item, this.wm,}) : super(key: key,);

  final NewBannersGalleryWidgetModel wm;
  final List<NewBanners> item;

  void _tapHandler({String type, String value, BuildContext context}) async {
    if (type == 'press_copy') {
      await FlutterClipboard.copy(value).whenComplete(() => BannersDialog.showBannerCopyInfoDialog(context: context, promocode: value));
    } else if (type == 'app_link') {
      await wm.openScreenAction(/*'discount'*/value);
    } else if (type == 'site_link') {
      await wm.openBrowserAction(/*'https://www.google.com/'*/ value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      // width: screenWidth-100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
            return InkWell(
            onTap: () =>
                _tapHandler(type: item[i].type, value: item[i].value, context: context),
            child: /*Padding(
                padding: item[i].size == 'big'? const EdgeInsets.only(left: 8.0): EdgeInsets.zero,
                child:*/ SizedBox(
                  width: item[i].size == 'big'? screenWidth/1.8: screenWidth/3.7,
                  // height: screenWidth/3.7,
                  child: _ImageBanner(imageUrl: item[i].image,),
                ),
              /*),*/
            );

        },
        separatorBuilder: (_, i) {
          return SizedBox(width: (screenWidth-(screenWidth*0.13)-((screenWidth/3.7)*3))/2,);
        },
        itemCount: item.length,
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
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
      ),
    );
  }
}