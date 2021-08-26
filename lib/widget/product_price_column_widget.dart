import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magento2_app/res/app_themes.dart';
import 'package:magento2_app/widget/ts_utils.dart';

// ignore: must_be_immutable
class ProductPriceColumnWidget extends StatelessWidget {
  double? price, orgPrice;
  double? priceSize, orgPriceSize;
  FontWeight? priceWeight;
  bool hideIfNull;
  String currency;
  Color? priceColor, orgPriceColor;
  CrossAxisAlignment? crossAxisAlignment;
  ProductPriceColumnWidget(
      {this.price, this.orgPrice,this.priceSize, this.orgPriceSize, this.priceWeight, this.hideIfNull = true, this.priceColor, this.orgPriceColor, this.currency = TsUtils.CURRENCY, this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        price != null
            ? RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: TsUtils.formatNumber(price),
                  style: TextStyle(
                      fontWeight: priceWeight ?? FontWeight.w600,
                      fontSize: priceSize ?? 14,
                      color: priceColor ?? ThemeColor.AppRed[500]),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' $currency',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: priceSize != null ? priceSize! - 2 : 12,
                            color: priceColor ?? ThemeColor.AppRed[500])),
                  ],
                ),
              )
            : SizedBox(),
        orgPrice != null && orgPrice! > 0 && orgPrice!> price!
            ? Text(
                '${TsUtils.formatCurrency(orgPrice, currency: currency)}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: orgPriceColor ?? ThemeColor.captionTextColor,
                    fontSize: orgPriceSize ?? 10,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.lineThrough),
              )
            : hideIfNull
                ? SizedBox()
                : Text(
                    '',
                    style: TextStyle(fontSize: orgPriceSize ?? 10),
                  ),
      ],
    );
  }
}
