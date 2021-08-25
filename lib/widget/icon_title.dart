import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconTitle extends StatelessWidget {
  final double iconSize;
  final String iconAsset;
  final String text;
  final Color? textColor;
  final EdgeInsets padding;

  const IconTitle({Key? key, this.iconSize = 20, required this.iconAsset, this.text = '', this.textColor, this.padding = const EdgeInsets.only(bottom: 10, top: 10, left: 10)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            iconAsset,
            height: iconSize,
            width: iconSize,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: textColor),
          ))
        ],
      ),
    );
  }
}
