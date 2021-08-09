import 'package:flutter/material.dart';
import 'package:parks_bark/views/Home.dart';
import '../app/ColorSets.dart';

class RatingSubmittedPage extends StatefulWidget {
  RatingSubmittedPage({ Key? key }) : super(key: key);

  @override
  _RatingSubmittedPageState createState() => _RatingSubmittedPageState();
}

class _RatingSubmittedPageState extends State<RatingSubmittedPage> {
  final String _parkName = 'Lakewood Dog Park';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rating Submitted!'),
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
                _parkName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.star_rate_rounded,
                    size: 48,
                    color: BrandColors.starFilled,
                  ),
                  Icon(
                    Icons.star_rate_rounded,
                    size: 48,
                    color: BrandColors.starFilled,
                  ),
                  Icon(
                    Icons.star_rate_rounded,
                    size: 48,
                    color: BrandColors.starFilled
                  ),
                  Icon(
                    Icons.star_half_rounded,
                    size: 48,
                    color: BrandColors.starFilled,
                  ),
                  Icon(
                    Icons.star_rate_rounded,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline_outlined,
                    size: 250,
                    color: Colors.green.shade700,
                  ),
                  Text(
                    'Submitted',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: Colors.green.shade700,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
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
                  child: Text('Back to Home'),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
