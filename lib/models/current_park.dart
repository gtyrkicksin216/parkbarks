import 'package:flutter/material.dart';
import 'package:parks_bark/models/park.dart';

class CurrentPark with ChangeNotifier {
  Park? currentPark;

  void setCurrentPark(Park park) {
    currentPark = park;
    notifyListeners();
  }

  void unsetCurrentPark() {
    currentPark = null;
  }
}
