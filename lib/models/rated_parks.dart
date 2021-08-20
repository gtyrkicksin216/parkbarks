import 'package:flutter/material.dart';
import 'package:parks_bark/models/park.dart';
import 'package:parks_bark/services/rated_parks_service.dart';

class RatedParks with ChangeNotifier {
  Future<List<Park>>? ratedParks;
  List<Park>? ratedParksList;

  void updateRatedParks() {
    ratedParks = RatedParksService().getAllRatedParks();
    notifyListeners();
  }

  void setParks(List<Park>? parks) {
    ratedParksList = parks;
    notifyListeners();
  }
}
