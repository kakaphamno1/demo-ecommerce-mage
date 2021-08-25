import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magento2_app/res/app_themes.dart';

class BaseWidgetImage {
  static Widget loadImageRadius8(String url, {double? height, double? width, BoxFit? value}) {
    return loadImageNetWork(url, fit: value, height: height, width: width, radius: 8);
  }

  static Widget loadImageRadius(String url, {double? height, double? width, double radius = 8, BoxFit? fit}) {
    return loadImageNetWork(url, height: height, width: width, radius: radius, fit: fit);
  }
  static Widget loadImageCover(String? url, {double? height, double? width,double radius = 16}) {
    return loadImageNetWork(url, fit: BoxFit.cover, height: height, width: width, radius: radius);
  }


  static Widget loadImageFit(String? url, {double? height, double? width}) {
    return loadImageNetWork(url, fit: BoxFit.fill, height: height, width: width);
  }

  static Widget loadImage(String? url, {double? height, double? width, BoxFit? fit}) {
    return loadImageNetWork(url, height: height, width: width, fit: fit);
  }

  static Widget loadImageRadiusRight(String? url, {double? height, double? width}) {
    return loadImageNetWork(url, height: height, radius: 8, width: width, isBorderRight: true);
  }


  static Widget loadImageNetWork(String? url, {double? height, double? width, double radius= 0, BoxFit? fit, bool isBorderRight = false}) {

    return ClipRRect(
      borderRadius: isBorderRight
          ? BorderRadius.only(topRight: Radius.circular(radius))
          : BorderRadius.circular(double.parse(radius.toString())),
      child: Container(
        color: url == "" ? Colors.white : ThemeColor.AppDark[300],
        child: CachedNetworkImage(
          width: width,
          height: height,
          fadeInDuration: Duration(milliseconds: 0),
          fadeOutDuration: Duration(milliseconds: 0),
          fit: fit,
          imageUrl: getUrlImage(url),
          errorWidget: (context, url, error) => Image.asset("assets/images/ic_stub.png"),
        ),
      ),
    );
  }

  static String getUrlImage(String? url) {
    return  url ?? "";
  }

  static void checkMemory() {
    ImageCache imageCache = PaintingBinding.instance!.imageCache!;
    if (imageCache.currentSizeBytes >= 55 << 20 ||  imageCache.currentSize >= 40){
      imageCache.clear();
      imageCache.clearLiveImages();
    }
  }
}
