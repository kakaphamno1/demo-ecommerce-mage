

import 'package:flutter/cupertino.dart';

class AppSpinLoadMore extends StatelessWidget {
  final EdgeInsets padding;

  const AppSpinLoadMore({Key? key, this.padding = const EdgeInsets.all(10)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Padding(padding: padding,
      child: CupertinoActivityIndicator())
    ],);
  }

}