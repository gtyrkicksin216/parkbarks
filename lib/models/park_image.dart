import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ParkImage with ChangeNotifier {
  XFile? currentImage;

  void setImage(XFile img) {
    currentImage = img;
    notifyListeners();
  }

  void unsetImage() {
    currentImage = null;
    notifyListeners();
  }

  XFile? getImage() {
    return currentImage;
  }
}
