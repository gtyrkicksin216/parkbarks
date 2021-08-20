import 'package:flutter/material.dart';
import 'package:parks_bark/app/global_styles.dart';
import 'package:parks_bark/models/rated_parks.dart';
import 'package:parks_bark/app/strings.dart';
import 'package:parks_bark/services/rated_parks_service.dart';
import 'package:parks_bark/views/Home.dart';
import 'package:provider/provider.dart';

class RatingSubmittedPage extends StatefulWidget {
  final String parkName;
  final List<int> ratings;

  RatingSubmittedPage({
    Key? key,
    required this.parkName,
    required this.ratings,
  }) : super(key: key);

  @override
  _RatingSubmittedPageState createState() => _RatingSubmittedPageState();
}

class _RatingSubmittedPageState extends State<RatingSubmittedPage> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    /* the `..` is called a cascade https://dart.dev/codelabs/dart-cheatsheet#cascades */
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 850),
    )
    ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final double averageRating = (widget.ratings.reduce((value, element) => value + element) / this.widget.ratings.length);
    final int averageRatingRounded = averageRating.round();

    void sendHome() async {
      final allParks = await RatedParksService().getAllRatedParks();
      context.read<RatedParks>().setParks(allParks);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false
      );
    }

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.ratingSubmitted),
          elevation: AppStyles.appBarElevation,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 24),
                alignment: Alignment.center,
                child: Text(
                  this.widget.parkName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...[1, 2, 3, 4, 5].map((value) => _buildStar(value, averageRatingRounded)),
                      ],
                    ),
                    Center(
                      child: Text(
                        '$averageRating',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                          letterSpacing: 0.75,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline_outlined,
                        size: 250,
                        semanticLabel: AppStrings.successCheckmarkLabel,
                        color: Colors.tealAccent.shade400,
                      ),
                      Text(
                        AppStrings.submitted,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          color: Colors.tealAccent.shade400,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 64,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: const Text(AppStrings.backHome),
                    onPressed: () {
                      sendHome();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        sendHome();

        return false;
      }
    );
  }
}

Widget _buildStar(int starCount, int ratingValue) {
  return Icon(
    Icons.star_rate_rounded,
    size: 48,
    color: ratingValue >= starCount ? Colors.orange.shade200 : Colors.grey.shade400,
  );
}
