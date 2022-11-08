import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Models/UserModel.dart';
import 'package:bikerider/custom/widgets/text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utility/enums.dart';
import '../bloc/BikeCubit.dart';
import '../custom/widgets/ShowToast.dart';
import '../custom/widgets/button.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: GestureDetector(
//             onTap: () {
  // createAlbum(User(
  //     name: "vishwa",
  //     mobile: "9856781231",
  //     email: "vishwa69@gmail.com",
  //     password: "common daddy"));
  // Navigator.pushNamed(context, "/LoginScreen");
//             },
//             child: Container(
//               child: Text("RegisterScreen"),
//             )),
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: ,
        backgroundColor: const Color(0xFFED863A),
        centerTitle: true,
        title: Text(
          'Register',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 22.5,
          ),
        ),
      ),
      body: SizedBox(
        // color: Colors.red,
        width: double.infinity,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  controller: _name,
                  textFieldType: TextFieldType.name,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  controller: _phone,
                  textFieldType: TextFieldType.mobile,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  controller: _email,
                  textFieldType: TextFieldType.email,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  controller: _password,
                  textFieldType: TextFieldType.password,
                ),
                const SizedBox(
                  height: 30,
                ),
                LargeSubmitButton(
                  text: 'REGISTER',
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      UserHttp.registerUser(User(
                              email: _email.text,
                              name: _name.text,
                              password: _password.text,
                              mobile: _phone.text))
                          .then((value) {
                        if (value["message"] == "successfully registered..") {
                          BlocProvider.of<BikeCubit>(context).timer(40);

                          Navigator.pushNamed(context, "/OtpScreen",
                              arguments: {
                                "mobile": _phone,
                                "nextScreen": "/ChooseAvatarScreen",
                                "arguments": {}
                              });
                          showToast(msg: "Registered succefully");
                        } else {
                          showToast(msg: value["message"]);
                        }
                      });
                    }
                    ;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
