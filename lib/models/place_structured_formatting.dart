class PlaceStructuredFormatting {
  final String mainText;
  final String secondaryText;

  PlaceStructuredFormatting({
    this.mainText = '',
    this.secondaryText = '',
  });

  factory PlaceStructuredFormatting.fromJson(Map<String, dynamic> json) {
    return PlaceStructuredFormatting(
      mainText: json['main_text'],
      secondaryText: json['secondary_text'],
    );
  }
}