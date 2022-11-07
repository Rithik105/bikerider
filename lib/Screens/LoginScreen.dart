import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Models/UserModel.dart';
import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utility/enums.dart';
import '../custom/widgets/button.dart';
import '../custom/widgets/text_form_fields.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController _numberOrEmail = TextEditingController();
  TextEditingController _password = TextEditingController();

  void _setBool() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("firstLogin", false);
    print(prefs.get("firstLogin"));
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       body: Center(
//         child: GestureDetector(
//             onTap: () {
//               _setBool();
//               Navigator.pushNamed(context, "/HomeScreen");
//             },
//             child: Container(
//               child: Text("LoginScreen"),
//             )),
//       ),
//     );
//   }
// }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> numberKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/login/background.png',
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 55,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/login/appicon.png',
                        scale: 2.5,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: numberKey,
                      child: CustomTextFormField(
                        controller: _numberOrEmail,
                        textFieldType: TextFieldType.numberOrEmail,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextFormField(
                      controller: _password,
                      textFieldType: TextFieldType.password,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (numberKey.currentState!.validate()) {
                              if (EmailOrPhone.email) {
                                print("enter number");
                                Fluttertoast.showToast(
                                  msg: "Enter a mobile number",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.75),
                                  textColor: Colors.white,
                                );
                              } else {
                                BlocProvider.of<BikeCubit>(context).timer(40);
                                Navigator.pushNamed(context, "/OtpScreen",
                                    arguments: {
                                      "mobile": _numberOrEmail,
                                      "nextScreen": "/ForgotScreen",
                                      "arguments": {
                                        "mobile": _numberOrEmail.text
                                      }
                                    });
                              }
                            }
                          },
                          child: Text(
                            'Forgot Password',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: const Color(0xFFEF8B40),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    LargeSubmitButton(
                      text: 'LOGIN',
                      ontap: () {
                        if (numberKey.currentState!.validate()) {
                          if (EmailOrPhone.email) {
                            UserHttp.loginUserEmail(User(
                                    email: _numberOrEmail.text,
                                    password: _password.text))
                                .then((value) {
                              if (value["message"] == "Signin Success !!") {
                                Navigator.pushNamed(context, "/HomeScreen");
                                showToast(msg: "Login Successful");
                              } else {
                                showToast(msg: value["message"]);
                              }
                            });
                          } else {
                            UserHttp.loginUserNumber(User(
                                    email: _numberOrEmail.text,
                                    password: _password.text))
                                .then((value) {
                              if (value["message"] == "Signin Success !!") {
                                Navigator.pushNamed(context, "/HomeScreen");
                                showToast(msg: "Login Successful");
                              } else {
                                showToast(msg: value["message"]);
                              }
                            });
                          }
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('FaceBook login');
                          },
                          child: Image.asset(
                            'assets/images/login/fbicon.png',
                            scale: 2.5,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Google login');
                          },
                          child: Image.asset(
                            'assets/images/login/gicon.png',
                            scale: 2.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Register login');
                        Navigator.pushNamed(context, "/RegisterScreen");
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don’t have an account? ',
                          style: GoogleFonts.roboto(
                              color: const Color(0xFFADAFB1), fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Register',
                              style: GoogleFonts.roboto(
                                color: const Color(0xFFF49D5C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
