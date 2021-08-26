import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:magento2_app/res/app_themes.dart';

// ignore: must_be_immutable
class QuantityWidget extends StatelessWidget {
  final int quantity;
  final GestureTapCallback? addTap;
  final GestureTapCallback? removeTap;
  Function(String)? changeText;
  final TextEditingController quantityController = new TextEditingController();
  final double height;
  final int? remainQuantity;
  bool canSubQuantity;
  QuantityWidget({
    this.quantity = 1,
    this.addTap,
    this.removeTap,
    this.height = 32,
    this.changeText,
    this.canSubQuantity = true,
    this.remainQuantity,
  }) {
    // quantityController.addListener(() {
    //   final text = quantity.toString();
    //   quantityController.value = quantityController.value.copyWith(
    //     text:  text,
    //     selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
    //     composing: TextRange.empty,
    //   );
    // });
    quantityController.value = TextEditingValue(
      text: quantity.toString(),
      selection: TextSelection.fromPosition(
        TextPosition(offset: quantity.toString().length),
      ),
    );
    // quantityController.value.copyWith(selection: TextSelection(
    //     baseOffset: quantityController.text.length,
    //     extentOffset: quantityController.text.length
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: removeTap,
              child: Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: canSubQuantity ? ThemeColor.AppPrimary[100]!.withOpacity(0.5) : ThemeColor.AppDark[300],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.remove,
                  color: canSubQuantity ? ThemeColor.primary : ThemeColor.AppDark[600],
                  size: 14,
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 200, minWidth: 30),
            child: IntrinsicWidth(
                child: TextFormField(
              maxLines: 1,
              style: TextStyle(fontSize: 16, color: ThemeColor.textColor, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
              onChanged: changeText,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 2, right: 2, top: 0, bottom: 0),
                isDense: true,
                border: InputBorder.none,
              ),
              controller: quantityController,
            )),
          ),
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              onTap: remainQuantity != null && (remainQuantity!.compareTo(quantity) <= 0) ? null : addTap,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ThemeColor.AppPrimary[100]!.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.add,
                  color: ThemeColor.primary,
                  size: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
