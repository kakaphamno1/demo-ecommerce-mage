import 'package:flutter/cupertino.dart';
import 'package:magento2_app/res/app_themes.dart';

// ignore: must_be_immutable
class LabelValueWidget extends StatelessWidget {
  String title, value;
  bool boldValue;
  TextStyle? titleStyle, valueStyle;

  LabelValueWidget(this.title, this.value, {this.boldValue = false, this.titleStyle, this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Text(
            title,
            style: titleStyle ?? ThemeText.default_P2_14.copyWith(color: ThemeColor.textColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text(
            value,
            style: valueStyle ??
                (boldValue ? ThemeText.default_S1_16 : ThemeText.normal_400_14.copyWith(color: ThemeColor.textColor)),
          ),
        ),
      ],
    );
  }
}
