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
    print(json);
    return ParkRating(
      cleanliness: json['cleanliness'],
      noise: json['noise'],
      size: json['size'],
      location: json['location'],
      activityEquipment: json['activityEquipment'],
      notes: json['notes'],
    );
  }
}
