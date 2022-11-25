import 'package:bikerider/Models/UserModel.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:bikerider/custom/widgets/button.dart';
import 'package:bikerider/custom/constants.dart';

class OwnBikeScreen extends StatelessWidget {
  OwnBikeScreen({super.key, required this.user});
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60, top: 70),
              child: Image.asset("assets/images/ownbike/Illustration 4@2x.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Do you have a Royal Bike",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: const Color(0XFFED7E2B),
                  fontSize: 50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55, right: 55, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LargeSubmitButton(
                    text: "YES",
                    ontap: () {
                      Navigator.pushNamed(context, "/OtpRegisterScreen",
                          arguments: {"User": user, "OwnBike": true});
                    },
                    width: 120,
                    height: 50,
                  ),
                  LargeSubmitButton(
                    style: kNoButtonDecoration,
                    text: "NO",
                    ontap: () {
                      Navigator.pushNamed(context, "/OtpRegisterScreen",
                          arguments: {"User": user, "OwnBike": false});
                    },
                    width: 120,
                    height: 50,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 50),
                  child: Image.asset(
                    "assets/images/ownbike/Group 4@2x.png",
                    width: 90,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 71, right: 20),
                  child: Image.asset(
                    "assets/images/ownbike/Group@2x.png",
                    width: 70,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
