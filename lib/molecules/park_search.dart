import 'package:flutter/material.dart';
import 'package:parks_bark/app/strings.dart';
import 'package:parks_bark/app/text_styles.dart';
import 'package:parks_bark/models/park.dart';
import 'package:parks_bark/models/current_park.dart';
import 'package:parks_bark/models/place_result.dart';
import 'package:parks_bark/services/place_service.dart';
import 'package:parks_bark/services/rated_parks_service.dart';
import 'package:parks_bark/views/view_rating.dart';
import 'package:provider/provider.dart';

class ParkSearch extends SearchDelegate {
  // TODO: Add debounce to input so we're not hitting the API a _ton_
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: AppStrings.clear,
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: AppStrings.back,
      icon: const Icon(Icons.clear),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final _placeService = PlaceService();
    return Container(
      child: FutureBuilder(
        future: _placeService.getAutocomplete(query),
        builder: (context, AsyncSnapshot<List<PlaceResult>> snapshot) {
          if (!snapshot.hasData || query.length < 3) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: const Text(
                    AppStrings.searchHint,
                    style: AppTextStyles.shadowHint,
                  ),
                ),
              ],
            );
          } else if (snapshot.data?.length == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: const Text(
                    AppStrings.noResults,
                    style: AppTextStyles.shadowHint,
                  ),
                )
              ],
            );
          } else {
            final results = snapshot.data;
            return ListView.builder(
              itemCount: results?.length,
              itemBuilder: (context, index) {
                return _ResultListItem(
                  parkId: results?[index].id ?? '',
                  parkName: results?[index].structuredFormatting?.mainText ?? '',
                  description: results?[index].structuredFormatting?.secondaryText ?? '',
                );
              },
            );
          }
        }
      ),
    );
  }
}

class _ResultListItem extends StatelessWidget {
  final String parkId;
  final String parkName;
  final String description;

  _ResultListItem({
    Key? key,
    required this.parkId,
    required this.parkName,
    required this.description,
  }) : super(key: key);

  Widget build(BuildContext context) {
    var title = parkName;
    var subtitle = description;
    return Card(
      margin: EdgeInsets.all(2),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () async {
          var parkRef = context.read<CurrentPark>();
          final parkEntry = await RatedParksService().getParkByPlaceId(parkId);
          if (parkEntry != null) {
            parkRef.setCurrentPark(parkEntry);
          } else {
            parkRef.setCurrentPark(Park(id: parkId, name: parkName, description: subtitle));
          }

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewRatingPage()),
          );
        },
      ),
    );
  }
}
