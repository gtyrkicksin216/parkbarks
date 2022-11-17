import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:parks_bark/models/park.dart';

class RatedParksService {
  final String endpointUrl = Platform.isIOS
    ? 'http://localhost:3000/parks'
    : 'http://10.0.2.2:3000/parks';
  /*
    NOTE: Test this out for iOS. Android uses 10.0.2.2 as 'localhost'.
    May or may not work on iOS device. If this doesn't work for iOS simply add platform
    specific vars for local testing. This shouldn't have any effect when running the application
    pointed at an actual endpoint.
  */
  // final String endpointUrl = 'http://10.0.2.2:3000/parks';
  final http.Client client = http.Client();

  Future<List<Park>> getAllRatedParks() async {
    final response = await client.get(Uri.parse(endpointUrl));
    final responseDataJson = convert.jsonDecode(response.body);
    final jsonResults = responseDataJson as List;

    return jsonResults.map((entry) => Park.fromJson(entry)).toList();
  }

  Future<Park?> getParkByPlaceId(String placeId) async {
    final response = await client.get(Uri.parse('$endpointUrl/$placeId'));
    if (response.statusCode == 200) {
      final responseDataJson = convert.jsonDecode(response.body);

      return Park.fromJson(responseDataJson);
    } else {
      return null;
    }
  }

  Future<http.Response> submitRating(Park park) async {
    final requestBody = convert.jsonEncode(park);
    return client.post(
      Uri.parse(endpointUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: requestBody
    );
  }
}
