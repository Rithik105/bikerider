import 'package:flutter/material.dart';

class VisibilityProvider extends ChangeNotifier {
  bool visibility = true;
  void checkVisibility() {
    visibility = !visibility;
    notifyListeners();
  }
}
