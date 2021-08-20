class ParkRating {
  final int cleanliness;
  final int noise;
  final int size;
  final int location;
  final int activityEquipment;
  final String notes;

  ParkRating({
    this.cleanliness = 0,
    this.noise = 0,
    this.size = 0,
    this.location = 0,
    this.activityEquipment = 0,
    this.notes = '',
  });

  factory ParkRating.fromJson(Map<String, dynamic> json) {
    int _roundRating(num value) {
      return value is double
        ? value.round()
        : value.toInt();
    }

    return ParkRating(
      cleanliness: _roundRating(json['cleanliness']),
      noise: _roundRating(json['noise']),
      size: _roundRating(json['size']),
      location: _roundRating(json['location']),
      activityEquipment: _roundRating(json['activityEquipment']),
      notes: json['notes'],
    );
  }
  // #region
  // ParkRating.fromJson(Map<String, dynamic> json)
  //   : cleanliness = _roundRating(json['cleanliness']),
  //     noise = json['noise'],
  //     size = json['size'],
  //     location = json['location'],
  //     activityEquipment = json['activityEquipment'],
  //     notes = json['notes'];
  // #endregion

  Map<String, dynamic> toJson() => {
    "cleanliness": cleanliness,
    "noise": noise,
    "size": size,
    "location": location,
    "activityEquipment": activityEquipment,
    "notes": notes,
  };

  int _roundRating(num value) {
    return value is double
      ? value.round()
      : value.toInt();
  }
}
