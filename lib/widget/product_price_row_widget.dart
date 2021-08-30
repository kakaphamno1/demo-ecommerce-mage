import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magento2_app/res/app_themes.dart';
import 'package:magento2_app/widget/ts_utils.dart';

class ProductPriceRowWidget extends StatelessWidget {
  final double? price, orgPrice;
  final double? priceSize, orgPriceSize;
  final FontWeight? priceWeight;
  final Color? priceColor, orgPriceColor;
  final String? currency;

  ProductPriceRowWidget(this.price, this.orgPrice,
      {this.priceColor, this.orgPriceColor, this.priceSize, this.orgPriceSize, this.priceWeight, this.currency});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        price != null && price! >= 0
            ? RichText(
                text: TextSpan(
                  text: TsUtils.formatCurrencyDynamic(price),
                  style: TextStyle(
                      fontWeight: priceWeight ?? FontWeight.w600,
                      fontSize: priceSize ?? 14,
                      color: priceColor ?? ThemeColor.AppRed[500]),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' ${currency ?? TsUtils.CURRENCY}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: priceSize != null ? priceSize! - 2 : 12,
                            color: priceColor ?? ThemeColor.AppRed[500])),
                  ],
                ),
              )
            : SizedBox(),
        SizedBox(width: 8),
        orgPrice != null && orgPrice! > 0 && orgPrice! > price!
            ? Text(
                '${TsUtils.formatCurrencyDynamic(orgPrice, currency: currency)}',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: orgPriceSize ?? 10,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.lineThrough),
              )
            : SizedBox(),
      ],
    );
  }
}
