import 'package:flutter/material.dart';

import '../constants.dart';

class LargeSubmitButton extends StatelessWidget {
  String text;
  Function ontap;
  double? width, height;
  BoxDecoration? style;
  LargeSubmitButton(
      {required this.text,
      required this.ontap,
      this.height,
      this.width,
      this.style});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontap(),
      child: Container(
        height: height ?? 45,
        width: width ?? 282,
        decoration: style ?? kLargeSubmitButtonDecoration,
        child: Center(
          child: Text(
            text,
            style: kLargeSubmitButtonTextDecoration,
          ),
        ),
      ),
    );
  }
}
