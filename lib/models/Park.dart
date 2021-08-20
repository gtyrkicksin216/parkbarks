import 'package:parks_bark/models/park_rating.dart';

class Park {
  final String id;
  final String name;
  final String description;
  final ParkRating? rating;

  Park({
    this.id = '',
    this.name = '',
    this.description = '',
    this.rating,
  });

  Park.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      description = json['description'],
      rating = ParkRating.fromJson(json['rating']);

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "rating": rating,
  };
}
