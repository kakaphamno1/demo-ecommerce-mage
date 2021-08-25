import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class MyCircleAvatar extends StatelessWidget {
  final double avatarSize;
  final String avatarUrl;
  final Uint8List? bytes;

  const MyCircleAvatar({Key? key, this.avatarSize = 68, this.avatarUrl = "", this.bytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget image;
    if (this.bytes != null) {
      image = Image.memory(
        bytes!,
        fit: BoxFit.cover,
      );
    } else {
      image = FadeInImage.assetNetwork(
        placeholder: 'assets/images/default-avatar.png',
        image: this.avatarUrl,
        imageErrorBuilder: (context, error, stackTrace) => Image.asset('assets/images/default-avatar.png'),
        fit: BoxFit.cover,
      );
    }

    return Container(
      width: avatarSize,
      height: avatarSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(avatarSize),
        child: image,
      ),
    );
  }
}
