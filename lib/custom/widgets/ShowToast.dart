import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast({required String msg}) {
  print("toast");
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black.withOpacity(0.75),
    textColor: Colors.white,
  );
}
