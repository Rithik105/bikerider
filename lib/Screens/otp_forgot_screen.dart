import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/bloc/BikeCubit.dart';

// ignore: must_be_immutable
class OtpForgotScreen extends StatefulWidget {
  TextEditingController mobile = TextEditingController();
  OtpForgotScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  State<OtpForgotScreen> createState() => _OtpForgotScreenState();
}

class _OtpForgotScreenState extends State<OtpForgotScreen> {
  @override
  void initState() {
    super.initState();
    UserHttp.sendOtp(widget.mobile.text);
  }

  final OtpFieldController _otpController = OtpFieldController();
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
          color: const Color(0xff575656),
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
            const SizedBox(
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
            const SizedBox(
              height: 10,
            ),
            Text(
              "+91-${widget.mobile.text}",
              textAlign: TextAlign.center,
              style: const TextStyle(
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
                style: GoogleFonts.roboto(
                    fontSize: 30, color: const Color(0xff4EB5F4)),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  UserHttp.verifyOtp(pin).then((value) {
                    if (value["message"] == true) {
                      showToast(msg: "OTP Verified");
                      Navigator.pushNamed(context, "/ForgotScreen",
                          arguments: {"mobile": widget.mobile.text});
                    } else {
                      showToast(msg: "OTP does not match");
                    }
                  });
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
                        color: const Color(0xffF7931E),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "${state.time.toString()} seconds left",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: const Color.fromRGBO(174, 168, 168, 0.87),
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
                        child: GestureDetector(
                          onTap: () {
                            _otpController.clear();
                            UserHttp.sendOtp(widget.mobile.text);
                          },
                          child: Text(
                            "Re-send Again",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: const Color(0xffF7931E),
                              fontSize: 18,
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: const Color.fromRGBO(174, 168, 168, 0.87),
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
