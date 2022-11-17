import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToolKit extends StatelessWidget {
  String toolName, toolImage, toolDescription;
  ToolKit(
      {Key? key,
      required this.toolDescription,
      required this.toolImage,
      required this.toolName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width - 20,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(
              0,
              0,
            ),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ), //BoxShadow
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            toolImage,
            scale: 2.5,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            toolName,
            style: GoogleFonts.roboto(
                color: Color(0x99000000),
                fontSize: 16,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
