// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parks_bark/models/park.dart';
import 'package:parks_bark/models/current_park.dart';
import 'package:parks_bark/services/rated_parks_service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:parks_bark/app/strings.dart';
import 'package:parks_bark/models/place_result.dart';
import 'package:parks_bark/molecules/park_search.dart';
import 'package:parks_bark/services/place_service.dart';
import 'package:parks_bark/views/view_rating.dart';
import 'package:parks_bark/app/color_sets.dart';

// Routable components
import './rate_park.dart';

class HomePage extends StatefulWidget {
  final String title = 'Browse Parks';

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _parkSearchValueController = TextEditingController(text: '');
  final _placeService = PlaceService();
  late String _parkSearchValue;
  late List<PlaceResult> _searchResults;
  late FocusNode _searchTextFocusNode = FocusNode();
  late Future<List<Park>> _ratedParkList;

  @override
  void dispose() {
    super.dispose();
    _parkSearchValueController.dispose();
    _searchTextFocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Get rated parks
    _ratedParkList = RatedParksService().getAllRatedParks();
    _parkSearchValue = _parkSearchValueController.text.isNotEmpty ? _parkSearchValueController.text : '';
    _parkSearchValueController.addListener(() {
      setState(() {
        _parkSearchValue = _parkSearchValueController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        child: Container(
          child: Column(
            children: [
              // TextField(
              //   focusNode: _searchTextFocusNode,
              //   decoration: const InputDecoration(
              //     labelText: AppStrings.searchParks,
              //     border: const OutlineInputBorder(),
              //     floatingLabelBehavior: FloatingLabelBehavior.never,
              //   ),
              //   // controller: _parkSearchValueController,
              //   // onTap: () {
              //   //   showSearch(
              //   //     context: context,
              //   //     delegate: ParkSearch(),
              //   //   );
              //   // },
              // ),
              // Text(this._parkSearchValue),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: _ParksList(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          _searchTextFocusNode.unfocus();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.search,
          color: Colors.black87,
          semanticLabel: AppStrings.searchParks,
        ),
        backgroundColor: BrandColors.brandPrimary,
        onPressed: () {
          // _searchTextFocusNode.requestFocus();
          showSearch(
            context: context,
            delegate: ParkSearch(),
          );
        },
      )
    );
  }
}

class _ParksList extends StatelessWidget {
  final List<String> _mockListData = <String>['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven sub', 'twelve sub'];
  final List<String> _mockListSubtitleData = <String>['one sub', 'two sub', 'three sub', 'four sub', 'five sub', 'six sub', 'seven sub', 'eight sub', 'nine sub', 'ten sub', 'eleven sub', 'twelve sub'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsetsDirectional.only(top: 16, bottom: 64),
      // shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      
      itemCount: _mockListData.length,
      itemBuilder: (BuildContext context, int index) {
        return _ParksListItem(title: _mockListData[index], subtitle: _mockListSubtitleData[index]);
      },
      // separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class _ParksListItem extends StatelessWidget {
  final String title;
  final String subtitle;

  _ParksListItem({ Key? key, required this.title, required this.subtitle }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(2),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {
          // var ref = Provider.of<CurrentPark>(context);
          var ref = context.read<CurrentPark>();
          ref.setCurrentPark(Park(id: title, description: subtitle));

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewRatingPage()),
          );
        },
        // trailing: _InlineRateButton()
      ),
    );
  }
}

class _InlineRateButton extends StatelessWidget {
  _InlineRateButton({ Key? key }) : super(key: key);

  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(AppStrings.inlineRatePark),
          Icon(
            Icons.star_rounded,
            color: BrandColors.starFilled,
            semanticLabel: AppStrings.ratingStarLabelFilled,
          )
        ],
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RateParkPage()),
        );
      },
    );
  }
}
