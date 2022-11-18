import 'package:flutter/material.dart';
class CustomClips extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    double x = 0;
    double y = size.height;
    // double increment = size.width / 80;
    double increment = 5;
    while (x < size.width) {
      x += increment;
      y = (y == size.height) ? size.height - 8 : size.height;
      //print(y);
      path.lineTo(x, y);
    }
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}