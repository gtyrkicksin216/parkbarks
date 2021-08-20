import 'package:flutter/material.dart';
import 'package:parks_bark/app/Strings.dart';
import 'package:parks_bark/app/text_styles.dart';
import 'package:parks_bark/models/park.dart';
import 'package:parks_bark/models/current_park.dart';
import 'package:parks_bark/models/place_result.dart';
import 'package:parks_bark/services/place_service.dart';
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
                    'No Results Found',
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
                return _ResultListItem(description: results?[index].description ?? '',);
              },
            );
          }
        }
      ),
    );
  }
}

class _ResultListItem extends StatelessWidget {
  final String description;

  _ResultListItem({
    Key? key,
    required this.description,
  }) : super(key: key);

  Widget build(BuildContext context) {
    var descriptionList = description.split(', ');
    var title = descriptionList[0];
    var subtitle = descriptionList.sublist(1).join(', ');
    return Card(
      margin: EdgeInsets.all(2),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {
          var parkRef = context.read<CurrentPark>();
          parkRef.setCurrentPark(Park(id: title, description: subtitle));

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewRatingPage()),
          );
        },
      ),
    );
  }
}
