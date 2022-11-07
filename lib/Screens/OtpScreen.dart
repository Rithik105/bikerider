import 'dart:async';

import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Models/UserModel.dart';
import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpPage extends StatefulWidget {
  String nextScreen;
  Map arguments;
  String? secretKey;

  TextEditingController mobile = TextEditingController();
  OtpPage(
      {Key? key,
      required this.mobile,
      required this.nextScreen,
      required this.arguments})
      : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String? secret;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserHttp.getsecret().then((value) {
      widget.secretKey = value;
      UserHttp.sendOtp(value, widget.mobile.text).then((value) {
        showToast(msg: value.toString());
        print("Hi");
      });
    });
  }

  OtpFieldController _otpController = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 80,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xff575656),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                  width: 300,
                  child: Image.asset("assets/images/reset/otp.png")),
            ),
            SizedBox(
              height: 40,
            ),
            const Text(
              "We have sent an OTP to",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff777777),
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "+91-${widget.mobile.text}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff777777),
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 250,
              height: 120,
              child: OTPTextField(
                onChanged: (String? pin) {
                  if (pin?.length == 4) {}
                },
                controller: _otpController,
                length: 4,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 40,
                style:
                    GoogleFonts.roboto(fontSize: 30, color: Color(0xff4EB5F4)),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  UserHttp.verifyOtp(widget.secretKey!, pin).then((value) {
                    print(value);
                  });
                  Navigator.pushNamed(context, widget.nextScreen,
                      arguments: widget.arguments);
                },
              ),
            ),
            const SizedBox(height: 30),
            BlocBuilder<BikeCubit, BikeState>(
              builder: (context, state) {
                if (state is BikeTimerState) {
                  return Column(children: [
                    Text(
                      "Re-send Again",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Color(0xffF7931E),
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "${state.time.toString()} seconds left",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Color.fromRGBO(174, 168, 168, 0.87),
                        fontSize: 18,
                      ),
                    ),
                  ]);
                } else {
                  return Column(children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<BikeCubit>(context).timer(40);
                      },
                      child: Text(
                        "Re-send Again",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Color(0xffF7931E),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Color.fromRGBO(174, 168, 168, 0.87),
                        fontSize: 18,
                      ),
                    ),
                  ]);
                }
              },
            )
          ],
        ).paddingAll(30, 20, 20, 20),
      ),
    );
  }
}
