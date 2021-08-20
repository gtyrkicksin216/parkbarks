import 'package:flutter/material.dart';
import 'package:parks_bark/app/text_styles.dart';

class RatingHeading extends StatelessWidget {
  RatingHeading({
    Key? key,
    required this.name,
    required this.addressLine1,
    required this.addressLine2
  }) : super(key: key);

  final String name;
  final String addressLine1;
  final String addressLine2;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Text(
              name,
              style: AppTextStyles.ratingHeading,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 4),
            child: Text(
              addressLine1,
              style: AppTextStyles.ratingAddress,
            ),
          ),
          Text(
            addressLine2,
            style: AppTextStyles.ratingAddress,
          ),
        ],
      ),
    );
  }
}
