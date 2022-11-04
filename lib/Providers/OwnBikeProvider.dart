import 'package:flutter/cupertino.dart';

class OwnBike extends ChangeNotifier {
  bool owns = true;
  void dosentOwn() {
    owns = false;
    notifyListeners();
  }
}
