import 'package:flutter/material.dart';
import 'package:parks_bark/app/text_styles.dart';

class RatingGroup extends StatelessWidget {
  final String title;
  final int currentRating;
  final List<int> _starValues = <int>[1, 2, 3, 4, 5];
  final void Function(int value) onPressedHandler;
  final bool disabled;

  RatingGroup({
    Key? key,
    required this.title,
    required this.currentRating,
    required this.onPressedHandler,
    this.disabled = false,
  }) : super(key: key);

  Widget _buildStar (int starCount, int ratingValue, void Function(int value)? pressedHandler) {
    return IconButton(
      icon: Icon(Icons.star_rate_rounded),
      iconSize: 48,
      color: ratingValue >= starCount ? Colors.orange.shade200 : Colors.grey.shade400,
      disabledColor: ratingValue >= starCount ? Colors.orange.shade200 : Colors.grey.shade400,
      onPressed: disabled ? null : () => pressedHandler!(starCount),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.ratingGroupHeading,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ..._starValues.map((value) => _buildStar(value, currentRating, onPressedHandler))
            ],
          ),
        ],
      ),
    );
  }
}
