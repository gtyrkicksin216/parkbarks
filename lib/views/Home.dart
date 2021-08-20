import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parks_bark/app/global_styles.dart';
import 'package:parks_bark/app/text_styles.dart';
import 'package:parks_bark/models/park.dart';
import 'package:parks_bark/models/current_park.dart';
import 'package:parks_bark/models/park_rating.dart';
import 'package:parks_bark/models/rated_parks.dart';
import 'package:parks_bark/services/rated_parks_service.dart';
import 'package:provider/provider.dart';
import 'package:parks_bark/app/strings.dart';
import 'package:parks_bark/models/place_result.dart';
import 'package:parks_bark/molecules/park_search.dart';
import 'package:parks_bark/views/view_rating.dart';
import 'package:parks_bark/app/color_sets.dart';

// Routable components
import './rate_park.dart';

class HomePage extends StatefulWidget {
  final String title = AppStrings.browseParks;

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _parkSearchValueController = TextEditingController(text: '');
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
        elevation: AppStyles.appBarElevation,
      ),
      body: GestureDetector(
        child: Container(
          child: Column(
            children: [
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
        elevation: 0.2,
        onPressed: () {
          showSearch(
            context: context,
            delegate: ParkSearch(),
          );
        },
      )
    );
  }
}

class _ParksList extends StatefulWidget {
  _ParksList({Key? key}) : super(key: key);

  @override
  _ParksListState createState() => _ParksListState();
}

class _ParksListState extends State<_ParksList> {

  @override
  Widget build(BuildContext context) {
    final _parksList = context.watch<RatedParks>().ratedParksList;
    return _parksList != null && _parksList.length > 0
      ? RefreshIndicator(
        backgroundColor: BrandColors.brandAccent,
        color: Colors.white,
        child: ListView.builder(
          padding: EdgeInsets.only(top: 16, bottom: 64),
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _parksList.length,
          itemBuilder: (BuildContext context, int index) => _ParksListItem(
            id: _parksList[index].id,
            title: _parksList[index].name,
            subtitle: _parksList[index].description,
            rating: _parksList[index].rating,
          ),
        ),
        onRefresh: () async {
          context.read<RatedParks>().setParks(await RatedParksService().getAllRatedParks());
        },
      )
      : Container(
        child: Center(
          child: const Text(
            AppStrings.noRatedParks,
            style: AppTextStyles.shadowHint,
          ),
        ),
      );
  }
}

class _ParksListItem extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final ParkRating? rating;

  _ParksListItem({
    Key? key,
    required this.id,
    required this.title,
    required this.subtitle,
    this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(2),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {
          final ref = context.read<CurrentPark>();
          ref.setCurrentPark(Park(id: id, name: title,  description: subtitle, rating: rating));

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewRatingPage()),
          );
        },
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
