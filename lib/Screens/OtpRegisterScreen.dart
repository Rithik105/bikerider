import 'dart:async';

import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Models/UserModel.dart';
import 'package:bikerider/Providers/Data.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:bikerider/Utility/enums.dart';
import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class OtpRegisterScreen extends StatefulWidget {
  User user;
  OtpRegisterScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<OtpRegisterScreen> createState() => _OtpRegisterScreenState();
}

class _OtpRegisterScreenState extends State<OtpRegisterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hi");
    UserHttp.sendOtp(widget.user.mobile!).then((value) {
      showToast(msg: value.toString());
      print("Hi");
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
              "+91-${widget.user.mobile}",
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
                  //   UserHttp.verifyOtp(pin).then((value) {
                  // if (pin == value["otp"])

                  UserHttp.verifyOtp(pin).then((value) {
                    if (value["message"] == false) {
                      UserHttp.registerUser(User(
                              email: widget.user.email,
                              name: widget.user.name,
                              password: widget.user.password,
                              mobile: widget.user.mobile))
                          .then((value1) {
                        if (value1["message"] == "successfully registered..") {
                          UserHttp.loginUserEmail(widget.user).then((value2) {
                            print("login");
                            print(value2["token"]);
                            // print(value1["message"]);
                            // print(value1['token']);
                            if (value2["message"] == "Signin Success !!") {
                              print(value1.toString());
                              Provider.of<UserData>(context, listen: false)
                                  .setUserData(widget.user);
                              UserSecureStorage.setToken(value2["token"]);
                              // UserSecureStorage.setDetails(
                              //     key: "name", value: value["userName"]);
                              // UserSecureStorage.setDetails(
                              //     key: "mobile", value: value["mobile"]);
                              // UserSecureStorage.setDetails(
                              //     key: "email", value: value["email"]);
                              // UserSecureStorage.setDetails(
                              //     key: "profileImage",
                              //     value: value["profileImage"]);

                              Navigator.pushNamed(
                                  context, "/ChooseAvatarScreen",
                                  arguments: {"name": widget.user.name});

                              showToast(msg: "Registered succefully");
                            }
                          });
                        } else {
                          showToast(msg: value1["message"]);
                        }
                      });
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
                      child: GestureDetector(
                        onTap: () {
                          UserHttp.sendOtp(widget.user.mobile!);
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
