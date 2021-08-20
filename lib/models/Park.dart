import 'package:parks_bark/models/park_rating.dart';
import 'package:parks_bark/models/place_result.dart';

class Park {
  final String id;
  final String description;
  final ParkRating? rating;

  Park({
    this.id = '',
    this.description = '',
    this.rating,
  });

  factory Park.fromJson(Map<String, dynamic> json) {
    return Park(
      id: json['id'],
      description: json['id'],
      rating: ParkRating.fromJson(json['rating']),
    );
  }
}
