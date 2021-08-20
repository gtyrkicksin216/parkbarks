class PlaceStructuredFormatting {
  final String mainText;
  final String secondaryText;

  PlaceStructuredFormatting({
    this.mainText = '',
    this.secondaryText = '',
  });

  PlaceStructuredFormatting.fromJson(Map<String, dynamic> json)
    : mainText = json['main_text'],
      secondaryText = json['secondary_text'];

  Map<String, dynamic> toJson() => {
    "mainText": mainText,
    "secondaryText": secondaryText,
  };
}