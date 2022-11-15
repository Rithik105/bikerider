import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Models/create_trip_modal.dart';
import '../../Utility/enums.dart';
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

class TextCircularButton extends StatefulWidget {
  TextCircularButton({
    Key? key,
    required this.label,
    required this.callBack,
    this.selected = false,
    this.disable = false,
  }) : super(key: key);
  final bool disable;
  final String label;
  final Function callBack;
  bool selected;
  @override
  State<TextCircularButton> createState() => _TextCircularButtonState();
}

class _TextCircularButtonState extends State<TextCircularButton> {
  // GlobalKey
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.disable
          ? null
          : () {
              setState(() {
                widget.selected = !widget.selected;
                widget.callBack(widget.selected);
              });
              if (widget.selected) {
                print(widget.label);
                CreateTripModal.recommendations.add(widget.label);
              } else {
                if (CreateTripModal.recommendations.contains(widget.label)) {
                  CreateTripModal.recommendations.remove(widget.label);
                  print(CreateTripModal.recommendations);
                }
              }
              print('this is called ${CreateTripModal.recommendations}');
            },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: widget.selected
              ? const Color(0xFFEE7F2C).withOpacity(0.85)
              : Colors.transparent,
          border: Border.all(
            color: widget.selected
                ? Colors.transparent
                : const Color(0xFF979797).withOpacity(0.7),
            width: 1.25,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.roboto(
            color: widget.selected ? Colors.white : const Color(0xFFEE7F2C),
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class CircularButton extends StatefulWidget {
  const CircularButton({Key? key, required this.type, required this.callBack})
      : super(key: key);
  final CircularButtonType type;
  final Function callBack;

  @override
  State<CircularButton> createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   // padding: const EdgeInsets.all(15),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     shape: BoxShape.circle,
    //     // boxShadow: [
    //     //   BoxShadow(
    //     //     color: Colors.black.withOpacity(0.2),
    //     //     offset: const Offset(
    //     //       0,
    //     //       1,
    //     //     ),
    //     //     blurRadius: 5.0,
    //     //     spreadRadius: 2.0,
    //     //   ),
    //     // ]),
    //   ),
    //   child: Center(
    //     child: FloatingActionButton.large(
    //       onPressed: () {},
    //       backgroundColor: Colors.white,
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Image.asset(
    //           'assets/images/create_trip/user.png',
    //           scale: 2,
    //         ),
    //       ),
    //     ),
    //     // child: TextButton(
    //     //   onPressed: () {},
    //     //   style: TextButton.styleFrom(
    //     //     shape: const CircleBorder(),
    //     //     padding: const EdgeInsets.all(24),
    //     //     shadowColor: Colors.black,
    //     //     backgroundColor: Colors.white,
    //     //     // surfaceTintColor: Colors.white,
    //     //   ),
    //     //   child: Image.asset(
    //     //     'assets/images/create_trip/user.png',
    //     //     scale: 2,
    //     //   ),
    //     // ),
    //   ),
    // );
    return SizedBox(
      width: 45,
      height: 45,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: widget.type,
          backgroundColor: Colors.white,
          onPressed: () {
            widget.callBack();
          },
          child: widget.type == CircularButtonType.invite
              ? Image.asset(
                  'assets/images/create_trip/user.png',
                  scale: 2.5,
                )
              : Image.asset(
                  'assets/images/create_trip/milestone.png',
                  scale: 3,
                ),
        ),
      ),
    );
  }
}
