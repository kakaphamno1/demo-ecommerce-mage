import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magento2_app/res/app_themes.dart';
import 'package:magento2_app/widget/marquee_widget.dart';

import 'badge.dart';
import 'loading_button.dart';

Widget BadgeWidget(String count, String? iconSvg, {Function()? onTap, double? height, double? width, Key? key}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      child: Padding(
        key: key,
        padding: const EdgeInsets.all(12),
        child: Badge(
            showBadge: count.isNotEmpty && count != "0",
            borderSide: BorderSide(color: Colors.white, width: 0.3),
            badgeColor: ThemeColor.AppRed[500]!,
            elevation: 0,
            badgeContent: Text(
              count,
              style: TextStyle(color: Colors.white),
            ),
            child: SvgPicture.asset(
              iconSvg ?? 'assets/cart.svg',
              height: height ?? 24,
              width: width ?? 24,
            )),
      ),
      onTap: onTap,
    ),
  );
}

Widget ActionText(String text,
    {Color? actionTextColor,
      Function()? onTap,
      Widget? leftIcon,
      Widget? rightIcon,
      TextStyle? textStyle,
      double? verticalPadding,
      BoxDecoration? decoration,
      double? horizontalPadding}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        decoration: decoration,
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 8, horizontal: horizontalPadding ?? 8),
        child: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            leftIcon ?? SizedBox(),
            Padding(
              padding: EdgeInsets.only(left: leftIcon != null ? 4 : 0, right: rightIcon != null ? 4 : 0),
              child: Text(
                text,
                style: textStyle ??
                    TextStyle(color: actionTextColor ?? ThemeColor.action, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            rightIcon ?? SizedBox(),
          ],
        ),
      ),
    ),
  );
}

Widget NormalButton(BuildContext context,
    {String? text,
      bool isLoading = false,
      Widget? leftIcon,
      Widget? rightIcon,
      void Function()? onTap,
      bool wrapContent = false,
      bool isOutLine = false,
      bool enable = true,
      Color? background,
      Color? textColor,
      EdgeInsets? padding,
      bool marquee = false,
      Key? key}) {
  var outline = BoxDecoration(
      border: Border.all(width: 1, color: enable ? (background ?? ThemeColor.primary) : ThemeColor.AppDark[500]!),
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.0));

  var solid = BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
    color: enable ? ThemeColor.primary : ThemeColor.AppDark[500]!,
    // boxShadow: kElevationToShadow[1],
    border: Border.all(width: 1, color: enable ? (background ?? ThemeColor.primary) : ThemeColor.AppDark[500]!),
  );

  Widget child;
  child = Row(
    mainAxisSize: wrapContent ? MainAxisSize.min : MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      enable ? leftIcon ?? SizedBox() : SizedBox(),
      Flexible(
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: marquee
              ? Marquee(
            textDirection: TextDirection.rtl,
            child: Text(text ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor ??
                        (isOutLine ? (enable ? ThemeColor.primary : ThemeColor.AppDark[500]!) : Colors.white),
                    fontSize: 16,
                    fontWeight: isOutLine ? FontWeight.w500 : FontWeight.w700)),
          )
              : Text(text ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textColor ?? (isOutLine ? (enable ? ThemeColor.primary : ThemeColor.AppDark[500]!) : Colors.white),
                  fontSize: 16,
                  fontWeight: isOutLine ? FontWeight.w500 : FontWeight.w700)),
        ),
      ),
      enable ? rightIcon ?? SizedBox() : SizedBox(),
    ],
  );
  return LoadingButton(
      key: key,
      loadingColor: isOutLine ? (background ?? Theme
          .of(context)
          .primaryColor) : Colors.white,
      isLoading: isLoading,
      decoration: isOutLine ? outline : solid,
      onPressed: enable ? onTap : null,
      child: child);
}