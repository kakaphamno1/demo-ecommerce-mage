import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:magento2_app/res/app_themes.dart';

class EmptyDataWidget extends StatelessWidget {
  final String text;
  final EdgeInsets textPadding;

  const EmptyDataWidget({Key? key, this.text = "", this.textPadding = const EdgeInsets.only(top: 15)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/emty_data.png",
          width: 226,
          height: 106,
        ),
        this.text.isEmpty
            ? Container()
            : Padding(
          padding: textPadding,
              child: Text(
                  this.text,
                  style: ThemeText.fontRegular14,
                  textAlign: TextAlign.center,
                ),
            )
      ],
    );
  }
}
