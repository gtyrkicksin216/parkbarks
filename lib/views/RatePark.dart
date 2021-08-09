import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parks_bark/views/Home.dart';
import 'package:parks_bark/views/RatingSubmitted.dart';
import '../app/ColorSets.dart';

class RateParkPage extends StatefulWidget {
  RateParkPage({ Key? key }) : super(key: key);

  @override
  _RateParkPageState createState() => _RateParkPageState();
}

class _RateParkPageState extends State<RateParkPage> {
  final List<double> _ratingValues = <double>[1, 2, 3, 4, 5];
  // NOTE: this will get removed and be static
  final List<String> _ratingFactors = <String>[
    'Cleanliness',
    'Noise',
    'Size',
    'Activity Equipment'
  ];
  int _cleanlinessRating = 0;
  int _noiseRating = 0;
  int _sizeRating = 0;
  int _locationRating = 0;
  int _activityEquipmentRating = 0;

  @override
  void dispose () {
    super.dispose();
  }

  @override
  void initState () {
    super.initState();
  }

  Map<String, dynamic> _toMap () {
    return {
      '_cleanlinessRating': _cleanlinessRating,
      '_noiseRating': _noiseRating,
      '_sizeRating': _sizeRating,
      '_locationRating': _locationRating,
      '_activityEquipmentRating': _activityEquipmentRating,
    };
  }

  dynamic get (String propertyName) {
    var _mapVal = _toMap();
    if (_mapVal.containsKey(propertyName)) {
      return _mapVal[propertyName];
    }
    throw ArgumentError('Property not found on class!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate This Park'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Park Name Here',
                      style: const TextStyle(
                        fontFamily: 'sans-serif',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Text(
                      '123 Main St.',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    'Cleveland, OH 44145',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 32),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.max,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [..._buildRatingGroup()],
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cleanliness',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStar(
                        1,
                        '_cleanlinessRating',
                        _updateCleanlinessRating,
                      ),
                      _buildStar(
                        2,
                        '_cleanlinessRating',
                        _updateCleanlinessRating,
                      ),
                      _buildStar(
                        3,
                        '_cleanlinessRating',
                        _updateCleanlinessRating,
                      ),
                      _buildStar(
                        4,
                        '_cleanlinessRating',
                        _updateCleanlinessRating,
                      ),
                      _buildStar(
                        5,
                        '_cleanlinessRating',
                        _updateCleanlinessRating,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Noise',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStar(
                        1,
                        '_noiseRating',
                        _updateNoiseRating,
                      ),
                      _buildStar(
                        2,
                        '_noiseRating',
                        _updateNoiseRating,
                      ),
                      _buildStar(
                        3,
                        '_noiseRating',
                        _updateNoiseRating,
                      ),
                      _buildStar(
                        4,
                        '_noiseRating',
                        _updateNoiseRating,
                      ),
                      _buildStar(
                        5,
                        '_noiseRating',
                        _updateNoiseRating,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Size',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStar(
                        1,
                        '_sizeRating',
                        _updateSizeRating,
                      ),
                      _buildStar(
                        2,
                        '_sizeRating',
                        _updateSizeRating,
                      ),
                      _buildStar(
                        3,
                        '_sizeRating',
                        _updateSizeRating,
                      ),
                      _buildStar(
                        4,
                        '_sizeRating',
                        _updateSizeRating,
                      ),
                      _buildStar(
                        5,
                        '_sizeRating',
                        _updateSizeRating,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStar(
                        1,
                        '_locationRating',
                        _updateLocationRating,
                      ),
                      _buildStar(
                        2,
                        '_locationRating',
                        _updateLocationRating,
                      ),
                      _buildStar(
                        3,
                        '_locationRating',
                        _updateLocationRating,
                      ),
                      _buildStar(
                        4,
                        '_locationRating',
                        _updateLocationRating,
                      ),
                      _buildStar(
                        5,
                        '_locationRating',
                        _updateLocationRating,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity Equipment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStar(
                        1,
                        '_activityEquipmentRating',
                        _updateActivityEquipmentRating,
                      ),
                      _buildStar(
                        2,
                        '_activityEquipmentRating',
                        _updateActivityEquipmentRating,
                      ),
                      _buildStar(
                        3,
                        '_activityEquipmentRating',
                        _updateActivityEquipmentRating,
                      ),
                      _buildStar(
                        4,
                        '_activityEquipmentRating',
                        _updateActivityEquipmentRating,
                      ),
                      _buildStar(
                        5,
                        '_activityEquipmentRating',
                        _updateActivityEquipmentRating,
                      ),
                    ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cancel_outlined,
                        color: Colors.red.shade400,
                      ),
                      Text('Cancel'),
                    ],
                  ),
                  onPressed: _cancelRating,
                ),
              ),
              Container(
                color: Colors.grey.shade300,
                width: 2,
              ),
              Expanded(
                child: TextButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.green.shade700,
                      ),
                      Text('Submit'),
                    ],
                  ),
                  onPressed: _submitRating,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Iterable<Widget> _buildRatingGroup() {
    return _ratingFactors.map((String factor) => Container(
      margin: EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            factor,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ..._ratingValues.map((double item) => IconButton(
                icon: Icon(Icons.star_border_rounded),
                iconSize: 48,
                color: Colors.grey,
                onPressed: () {
                  print(item);
                },
              )),
            ],
          ),
        ],
      ),
    ));
  }

  Widget _buildStar (int starCount, String ratingName, void Function(int value)? pressedHandler) {
    return IconButton(
      icon: Icon(Icons.star_rate_rounded),
      iconSize: 48,
      color: this.get(ratingName) >= starCount ? Colors.orange.shade200 : Colors.grey.shade400,
      onPressed: () => pressedHandler!(starCount),
    );
  }

  // FIXME: This is WET
  // '_cleanlinessRating': _cleanlinessRating,
  // '_noiseRating': _noiseRating,
  // '_sizeRating': _sizeRating,
  // '_locationRating': _locationRating,
  // '_activityEquipmentRating': _activityEquipmentRating,
  void _updateCleanlinessRating (int value) {
    setState(() {
      _cleanlinessRating = value;
    });
  }

  void _updateNoiseRating (int value) {
    setState(() {
      _noiseRating = value;
    });
  }

  void _updateSizeRating (int value) {
    setState(() {
      _sizeRating = value;
    });
  }

  void _updateLocationRating (int value) {
    setState(() {
      _locationRating = value;
    });
  }

  void _updateActivityEquipmentRating (int value) {
    setState(() {
      _activityEquipmentRating = value;
    });
  }

  void _cancelRating () {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      (route) => false,
    );
  }

  void _submitRating () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RatingSubmittedPage()),
    );
  }
}
