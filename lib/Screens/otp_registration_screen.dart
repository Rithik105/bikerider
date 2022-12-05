import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Models/UserModel.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class OtpRegisterScreen extends StatefulWidget {
  User user;
  bool own;
  OtpRegisterScreen({Key? key, required this.user, required this.own})
      : super(key: key);

  @override
  State<OtpRegisterScreen> createState() => _OtpRegisterScreenState();
}

class _OtpRegisterScreenState extends State<OtpRegisterScreen> {
  @override
  void initState() {
    super.initState();
    UserHttp.sendOtp(widget.user.mobile!);
  }

  void _setNoTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("firstLogin", false);
  }

  void _setLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("loggedIn", true);
  }

  final OtpFieldController _otpController = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leadingWidth: 80,
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
              "+91-${widget.user.mobile}",
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
                    print(value.toString() + 'OTP Validation');
                    if (value["message"] == false) {
                      showToast(msg: "OTP Verified");
                      UserHttp.registerUser(
                              User(
                                  email: widget.user.email,
                                  name: widget.user.name,
                                  password: widget.user.password,
                                  mobile: widget.user.mobile),
                              widget.own)
                          .then((value1) {
                        if (value1["message"] == "successfully registered..") {
                          UserHttp.loginUserEmail(widget.user).then((value2) {
                            if (value2["message"] == "Signin Success !!") {
                              UserSecureStorage.setToken(value2["token"]);
                              UserSecureStorage.setDetails(
                                  key: "name", value: value2["userName"]);
                              UserSecureStorage.setDetails(
                                  key: "mobile", value: value2["mobile"]);
                              UserSecureStorage.setDetails(
                                  key: "email", value: value2["email"]);
                              UserSecureStorage.setDetails(
                                  key: "haveBike",
                                  value: value2["haveBike"].toString());
                              _setLogin();
                              _setNoTutorial();
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
                    } else {
                      showToast(msg: "Incorrect OTP");
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
                          UserHttp.sendOtp(widget.user.mobile!);
                        },
                        child: Text(
                          "Re-send Again",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: const Color(0xffF7931E),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
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
