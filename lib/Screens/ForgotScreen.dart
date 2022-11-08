import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/Material.dart';

import '../custom/widgets/button.dart';
import '../custom/widgets/text_form_fields.dart';
import 'SuccessPage.dart';

class ForgotScreen extends StatefulWidget {
  ForgotScreen({Key? key, required this.mobile}) : super(key: key);
  String mobile;

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final formKey = GlobalKey<FormState>();

  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
          children: [
            SizedBox(
                width: 300,
                child: Center(
                    child: Image.asset("assets/images/reset/reset_page.png"))),
            const Center(
                child: Text(
              "Reset Password",
              style: TextStyle(
                color: Color(0xff575656),
                fontSize: 20,
              ),
            )).paddingAll(30, 0, 40, 20),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextFormField(
                      textController: _newPasswordController,
                      obscure: true,
                      myHintText: 'New Password',
                      callBack: (password) {
                        return passwordValadition(password);
                      }),
                  MyTextFormField(
                      textController: _confirmPasswordController,
                      obscure: true,
                      myHintText: 'Confirm Password',
                      callBack: (password) {
                        if (password == null || password.isEmpty) {
                          return "Password required";
                        } else {
                          return _newPasswordController.text == password
                              ? null
                              : 'Password mismatch';
                        }
                      }),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: LargeSubmitButton(
                          text: "Reset",
                          ontap: () {
                            if (formKey.currentState!.validate()) {
                              // UserHttp.changePassword(widget.mobile,
                              //         _newPasswordController.text)
                              //     .then((value) {
                              // if (value["message"] ==
                              //     "password updated successfully!!") {
                              Navigator.pushNamed(context, "/SuccessScreen",
                                  arguments: {
                                    "title":
                                        "Your Password has been successfully changed.",
                                    "nextScreen": "/LoginScreen"
                                  });
                              showToast(msg: "message");
                              // }
                              //   });
                            }
                          })).paddingAll(10, 10, 0, 0)
                ],
              ),
            ),
          ],
        ).paddingAll(20, 20, 50, 0),
      ),
    );
  }
}

passwordValadition(value) {
  if (value == null || value.isEmpty) {
    return "Password required";
  } else if (!RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(value)) {
    return "Enter a strong password";
  } else {
    return null;
  }
}
