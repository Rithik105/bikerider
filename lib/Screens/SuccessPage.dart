import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom/widgets/button.dart';

class SuccessPage extends StatefulWidget {
  SuccessPage({super.key, required this.title, required this.nextScreen});
  String title, nextScreen;

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Color(0xff575656),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                width: 300,
                child: Center(
                    child: Image.asset("assets/images/reset/success.png"))),
            const Text(
              "Success!!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff4F504F),
                fontSize: 22,
              ),
            ).paddingAll(0, 0, 40, 20),
            SizedBox(
                width: 215,
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    height: 1.5,
                    color: Color(0xff5F5D5D),
                    fontSize: 16,
                  ),
                )),
            SizedBox(
              height: 25,
            ),
            SizedBox(
                width: double.infinity,
                child: LargeSubmitButton(
                    text: "Done",
                    ontap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, widget.nextScreen, (route) => false);
                    })).paddingAll(20, 20, 0, 0)
          ],
        ).paddingAll(20, 20, 50, 0),
      ),
    );
  }
}
