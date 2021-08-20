import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:parks_bark/models/park.dart';

class RatedParksService {
  Future<List<Park>> getAllRatedParks() async {
    final String url = 'http://localhost:3000/parks';

    final response = await http.get(Uri.parse(url));
    final responseDataJson = convert.jsonDecode(response.body);
    final jsonResults = responseDataJson as List;

    return jsonResults.map((entry) => Park.fromJson(entry)).toList();
  }
}
