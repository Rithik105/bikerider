import 'package:bikerider/Screens/BookServiceScreen.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GarageCard extends StatefulWidget {
  GarageCard({Key? key}) : super(key: key);

  @override
  State<GarageCard> createState() => _GarageCardState();
}

class _GarageCardState extends State<GarageCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "15 Days",
                  style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffE08B4D)),
                ),
                Text(
                  "Next Service due",
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffE08B4D)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/homePage/garage_images/indicator.png",
              ),
            ).paddingAll(20, 20, 0, 0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookServiceScreen()));
              },
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/homePage/garage_images/book_service.png",
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Book a Service",
                    style: GoogleFonts.roboto(
                        color: Color(0xff515251),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  )
                ],
              ),
            ).paddingAll(20, 20, 0, 0),
            Divider(
              color: Color(0xff979797),
              thickness: 0.5,
            ),
            GestureDetector(
              child: Row(
                children: [
                  Image.asset(
                      "assets/images/homePage/garage_images/service_records.png",
                      width: 30),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Service Records",
                    style: GoogleFonts.robotoFlex(
                        color: Color(0xff515251),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  )
                ],
              ),
            ).paddingAll(20, 20, 0, 0),
            Divider(
              color: Color(0xff979797),
              thickness: 0.5,
            ),
            GestureDetector(
              child: Row(
                children: [
                  Image.asset(
                      "assets/images/homePage/garage_images/owners_manual.png",
                      width: 30),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Owners Manual",
                    style: GoogleFonts.robotoFlex(
                        color: Color(0xff515251),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  )
                ],
              ),
            ).paddingAll(20, 20, 0, 0),
            Divider(
              color: Color(0xff979797),
              thickness: 0.5,
            ),
            GestureDetector(
              child: Row(
                children: [
                  Image.asset(
                      "assets/images/homePage/garage_images/tool_kit.png",
                      width: 30),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Tool Kit",
                    style: GoogleFonts.robotoFlex(
                        color: Color(0xff515251),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  )
                ],
              ),
            ).paddingAll(20, 20, 0, 0),
            Divider(
              color: Color(0xff979797),
              thickness: 0.5,
            ),
            GestureDetector(
              child: Row(
                children: [
                  Image.asset(
                      "assets/images/homePage/garage_images/accessories.png",
                      width: 30),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Accessories",
                    style: GoogleFonts.robotoFlex(
                        color: Color(0xff515251),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  )
                ],
              ),
            ).paddingAll(20, 20, 0, 0),
          ],
        ).paddingAll(0, 0, 40, 0));
  }
}
