import 'package:parks_bark/models/place_structured_formatting.dart';

class PlaceResult {
  final String id;
  final String description;
  final PlaceStructuredFormatting? structuredFormatting;
  // TODO: Pull in rest of info

  PlaceResult({
    this.description = '',
    this.id = '',
    this.structuredFormatting,
  });

  PlaceResult.fromJson(Map<String, dynamic> json)
    : id = json['place_id'],
      description = json['description'],
      structuredFormatting = PlaceStructuredFormatting.fromJson(json['structured_formatting']);

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "structuredFormatting": structuredFormatting,
  };
}

// {
//   "description": "Lakewood Dog Park, North Fairfield Road, Wauconda, IL, USA",
//   "matched_substrings": [
//     {
//       "length": 17,
//       "offset": 0
//     }
//   ],
//   "place_id": "ChIJncOnhtmeD4gRNYhe1RXC0bs",
//   "reference": "ChIJncOnhtmeD4gRNYhe1RXC0bs",
//   "structured_formatting": {
//     "main_text": "Lakewood Dog Park",
//     "main_text_matched_substrings": [
//       {
//         "length": 17,
//         "offset": 0
//       }
//     ],
//     "secondary_text": "North Fairfield Road, Wauconda, IL, USA"
//   },
//   "terms": [
//     {
//       "offset": 0,
//       "value": "Lakewood Dog Park"
//     },
//     {
//       "offset": 19,
//       "value": "North Fairfield Road"
//     },
//     {
//       "offset": 41,
//       "value": "Wauconda"
//     },
//     {
//       "offset": 51,
//       "value": "IL"
//     },
//     {
//       "offset": 55,
//       "value": "USA"
//     }
//   ],
//   "types": [
//     "tourist_attraction",
//     "park",
//     "point_of_interest",
//     "establishment"
//   ]
// },
