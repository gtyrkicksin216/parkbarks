import 'package:flutter/material.dart';
import 'package:parks_bark/app/color_sets.dart';
import 'package:parks_bark/app/strings.dart';
import 'package:parks_bark/app/text_styles.dart';
import 'package:parks_bark/app/global_styles.dart';
import 'package:parks_bark/models/current_park.dart';
import 'package:parks_bark/molecules/rating_group.dart';
import 'package:parks_bark/molecules/rating_heading.dart';
import 'package:parks_bark/views/rate_park.dart';
import 'package:provider/provider.dart';

class ViewRatingPage extends StatefulWidget {
  ViewRatingPage({ Key? key }) : super(key: key);

  @override
  _ViewRatingPageState createState() => _ViewRatingPageState();
}

class _ViewRatingPageState extends State<ViewRatingPage> {

  late int _cleanlinessRating = 0;
  late int _noiseRating = 0;
  late int _sizeRating = 0;
  late int _locationRating = 0;
  late int _activityEquipmentRating = 0;

  @override
  Widget build(BuildContext context) {
    final _ratings = context.watch<CurrentPark>().currentPark?.rating;
    if (_ratings != null) {
      _cleanlinessRating = _ratings.cleanliness;
      _noiseRating = _ratings.noise;
      _sizeRating = _ratings.size;
      _locationRating = _ratings.location;
      _activityEquipmentRating = _ratings.activityEquipment;
    }
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

    final parkRatings = context.watch<CurrentPark>().currentPark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.viewRating),
        elevation: AppStyles.appBarElevation,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
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
                  mainAxisSize: MainAxisSize.max,
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
                              name: context.watch<CurrentPark>().currentPark?.name ?? '',
                              addressLine1: context.watch<CurrentPark>().currentPark?.description ?? '',
                              addressLine2: '',
                            ),
                          ),
                          Row(
                            children: [
                              context.watch<CurrentPark>().currentPark?.rating != null
                                ? _MiniRating(
                                  rating: _getOverallRating([
                                    _cleanlinessRating,
                                    _noiseRating,
                                    _sizeRating,
                                    _locationRating,
                                    _activityEquipmentRating
                                  ]),
                                )
                                : Container(
                                  child: const Text(AppStrings.noRatedParks),
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                    context.watch<CurrentPark>().currentPark?.rating != null
                      ? Column(
                        children: [
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
                        ],
                      )
                      : Center(
                        child: Text(
                          AppStrings.parkNotRated,
                          style: AppTextStyles.shadowHint,
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.only(top: 48, bottom: 64),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: const Text(
                              AppStrings.ratePark,
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
                              elevation: MaterialStateProperty.resolveWith<double>((states) => 0.5)
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
