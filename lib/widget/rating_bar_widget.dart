import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:magento2_app/res/app_themes.dart';

class RatingBarProductWidget extends StatelessWidget {
  final double? reviewAvg;
  final double? size;
  final Function(double)? onRatingUpdate;
  RatingBarProductWidget(this.reviewAvg, {this.size, this.onRatingUpdate});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RatingBar.builder(
        itemSize: size ?? 16,
        initialRating: reviewAvg ?? 0,
        direction: Axis.horizontal,
        allowHalfRating: false,
        wrapAlignment: WrapAlignment.end,
        unratedColor: Color(0xFFC8C9CA),
        itemCount: 5,
        itemBuilder: (context, _) => Icon(
          Icons.star_rounded,
          color: ThemeColor.secondary,
        ),
        onRatingUpdate: onRatingUpdate ?? (rating) {},
      ),
    );
  }
}
