import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:magento2_app/res/app_themes.dart';

class SwipperProduct extends StatelessWidget {
  final List<String>? banners;

  final double? height;

  SwipperProduct({required this.banners, this.height});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (banners == null)
      return SizedBox(
        height: height,
      );
    return Container(
      width: width,
      height: height,
      child: Swiper(
        itemBuilder: (BuildContext context, index) {
          return InkWell(
            onTap: () {
            },
            child: CachedNetworkImage(
              imageUrl: banners![index],
              fit: BoxFit.fill,
            ),
          );
        },
        itemCount: banners!.length,
        //viewportFraction: 0.9,
        pagination: new SwiperPagination(
            alignment: Alignment.bottomRight,
            builder: new SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
              return Container(
                decoration: BoxDecoration(color: ThemeColor.colorUnit, borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.only(top: 2, bottom: 2, left: 6, right: 6),
                margin: EdgeInsets.only(bottom: 16, right: 16),
                child: Text(
                  "${config.activeIndex + 1}/${banners!.length}",
                  style: ThemeText.fontNormal12.copyWith(color: Colors.white),
                ),
              );
            })),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index) => print('index $index'),
      ),
    );
  }
}

