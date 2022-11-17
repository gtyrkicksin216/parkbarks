import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:parks_bark/models/place_result.dart';

class PlaceService {
  Future<List<PlaceResult>> getAutocomplete(String search) async {
    final String androidKey = '::REPLACE_WITH_KEY::';
    final String iosKey = '::REPLACE_WITH_KEY::';
    final String apiKey = Platform.isAndroid ? androidKey : iosKey;
    final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=$apiKey&input=$search%20Dog%20Park';

    final response = await http.get(Uri.parse(url));
    final responseDataJson = convert.jsonDecode(response.body);
    final jsonResults = responseDataJson['predictions'] as List;

    return jsonResults.map((place) => PlaceResult.fromJson(place)).toList();
  }
}
