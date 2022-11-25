import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:bikerider/custom/widgets/button.dart';
import 'package:bikerider/custom/widgets/text_form_fields.dart';
import 'package:bikerider/Utility/enums.dart';
import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:bikerider/Models/UserModel.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();

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
                      BlocProvider.of<BikeCubit>(context).timer(40);
                      Navigator.pushNamed(context, "/OwnBikeScreen",
                          arguments: {
                            "User": User(
                                email: _email.text,
                                name: _name.text,
                                password: _password.text,
                                mobile: _phone.text),
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
