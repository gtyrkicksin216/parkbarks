import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ParkImage with ChangeNotifier {
  XFile? currentImage;
  File? currentImageAsFile;
  // Image? currentImageAsFile;

  void setImage(XFile img) {
    currentImageAsFile = File(img.path);
    // currentImageAsFile = Image.file(File(img.path));
    currentImage = img;
    notifyListeners();
  }

  void unsetImage() {
    currentImageAsFile = null;
    currentImage = null;
    notifyListeners();
  }

  XFile? getImage() {
    return currentImage;
  }
}
