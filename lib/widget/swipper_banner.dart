import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class SwipperBanner extends StatelessWidget {
  final List<String> banners;

  final double? height;

  SwipperBanner({required this.banners, this.height});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height ?? 130,
      child: Swiper(
        itemBuilder: (BuildContext context, index) {
          String url = banners[index];
          return CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.fill,
          );
        },
        itemCount: banners.length,
        pagination: new SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: new SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
              return Container(
                width: width,
                padding: EdgeInsets.only(bottom: 32),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(banners.length, (index) {
                      return config.activeIndex == index
                          ? Container(
                              margin: EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: Colors.white),
                              height: 4,
                              width: 20,
                            )
                          : Container(
                              margin: EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0x80ffffff)),
                              height: 4,
                              width: 4,
                            );
                    })),
              );
            })),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index) {
        },
      ),
    );
  }
}
