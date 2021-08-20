import 'package:flutter/material.dart';
import 'package:parks_bark/app/color_sets.dart';
import 'package:parks_bark/app/strings.dart';
import 'package:parks_bark/app/text_styles.dart';
import 'package:parks_bark/models/current_park.dart';
import 'package:parks_bark/molecules/rating_group.dart';
import 'package:parks_bark/molecules/rating_heading.dart';
import 'package:parks_bark/views/rate_park.dart';
import 'package:provider/provider.dart';

class ViewRatingPage extends StatelessWidget {
  ViewRatingPage({ Key? key }) : super(key: key);

  final int _cleanlinessRating = 5;
  final int _noiseRating = 2;
  final int _sizeRating = 3;
  final int _locationRating = 5;
  final int _activityEquipmentRating = 1;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };

      if (states.any(interactiveStates.contains)) {
        return BrandColors.brandPrimary;
      }

      return BrandColors.brandPrimary;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('View Rating'),
      ),
      body: SingleChildScrollView(
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                color: Colors.grey.shade400,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                    ),
                    child: const Text(
                      AppStrings.noImage,
                      style: AppTextStyles.imageOverlayDark,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 32),
                      child: Row(
                        children: [
                          Expanded(
                            // child: Consumer<CurrentPark>(
                            //   builder: (context, park, child) => RatingHeading(
                            //     name: park.currentPark?.id ?? '',
                            //     addressLine1: park.currentPark?.description ?? '',
                            //     addressLine2: park.currentPark?.description ?? '',
                            //   ),
                            // ),
                            child: RatingHeading(
                              name: context.watch<CurrentPark>().currentPark?.id ?? '',
                              addressLine1: context.watch<CurrentPark>().currentPark?.id ?? '',
                              addressLine2: context.watch<CurrentPark>().currentPark?.id ?? '',
                            ),
                          ),
                          Row(
                            children: [
                              _MiniRating(
                                rating: _getOverallRating([
                                  _cleanlinessRating,
                                  _noiseRating,
                                  _sizeRating,
                                  _locationRating,
                                  _activityEquipmentRating
                                ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    RatingGroup(
                      title: AppStrings.cleanliness,
                      currentRating: _cleanlinessRating,
                      onPressedHandler: (value) { },
                      disabled: true,
                    ),
                    RatingGroup(
                      title: AppStrings.noise,
                      currentRating: _noiseRating,
                      onPressedHandler: (value) { },
                      disabled: true,
                    ),
                    RatingGroup(
                      title: AppStrings.size,
                      currentRating: _sizeRating,
                      onPressedHandler: (value) { },
                      disabled: true,
                    ),
                    RatingGroup(
                      title: AppStrings.location,
                      currentRating: _locationRating,
                      onPressedHandler: (value) { },
                      disabled: true,
                    ),
                    RatingGroup(
                      title: AppStrings.activityEquipment,
                      currentRating: _activityEquipmentRating,
                      onPressedHandler: (value) { },
                      disabled: true,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 48),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text(
                              'Rate This Park',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                color: Colors.black87,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith(getColor),
                              minimumSize: MaterialStateProperty.resolveWith<Size?>((states) => Size(150, 48)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RateParkPage()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getOverallRating(List<int> ratings) {
    var total = 0;

    for (final val in ratings) {
      total += val;
    }

    return (total / ratings.length);
  }
}

class _MiniRating extends StatelessWidget {
  _MiniRating({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final double rating;
  final _starValues = [1, 2, 3, 4, 5];

  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ..._starValues.map((value) => _buildStar(value, rating.round())),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '($rating)',
              style: AppTextStyles.ratingValue,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildStar(int starCount, int ratingValue) {
    return Icon(
      Icons.star_rate_rounded,
      color: ratingValue >= starCount ? Colors.orange.shade200 : Colors.grey.shade400,
    );
  }
}
