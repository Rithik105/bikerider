import 'package:bikerider/Providers/VisibiltyProvider.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Utility/enums.dart';

class EmailOrPhone {
  static bool email = true;
}

mobileValadition(value) {
  if (value == null || value.isEmpty) {
    return "Mobile-Number Required";
  } else if (!RegExp(r'^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$').hasMatch(value)) {
    return "Invalid Mobile-Number";
  } else {
    return null;
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

emailValidator(value) {
  if (value == null || value.isEmpty) {
    return "E-Mail Required";
  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
    return "Invalid E-Mail";
  } else {
    return null;
  }
}

emailPhoneValidator(value) {
  if (value == null || value.isEmpty) {
    return "E-Mail Required";
  } else {
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
      if (!RegExp(r'^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$').hasMatch(value))
        return "Invalid Email or Number";
      else {
        EmailOrPhone.email = false;
        print(EmailOrPhone.email);
        return null;
      }
    } else {
      EmailOrPhone.email = true;
      print(EmailOrPhone.email);
      return null;
    }
  }
}

String getLabel({required TextFieldType textFieldType}) {
  String returnValue = '';
  switch (textFieldType) {
    case TextFieldType.numberOrEmail:
      returnValue = 'Mobile Number/Email id';
      break;
    case TextFieldType.password:
      returnValue = 'Password';
      break;
    case TextFieldType.email:
      returnValue = 'Email';
      break;
    case TextFieldType.mobile:
      returnValue = 'Registered Mobile Number';
      break;
    case TextFieldType.name:
      returnValue = 'Name';
      break;
  }
  return returnValue;
}

String getPreffixIcon({required TextFieldType textFieldType}) {
  String returnValue = '';
  switch (textFieldType) {
    case TextFieldType.numberOrEmail:
      returnValue = 'assets/images/login/person.png';
      break;
    case TextFieldType.password:
      returnValue = 'assets/images/login/lock.png';
      break;
    case TextFieldType.email:
      returnValue = 'assets/images/register/email.png';
      break;
    case TextFieldType.mobile:
      returnValue = 'assets/images/register/phone_call.png';
      break;
    case TextFieldType.name:
      returnValue = 'assets/images/login/person.png';
      break;
  }
  return returnValue;
}

getValidator({required TextFieldType textFieldType, String? data}) {
  String? returnValue = '';
  switch (textFieldType) {
    case TextFieldType.numberOrEmail:
      returnValue = emailPhoneValidator(data);
      break;
    case TextFieldType.password:
      returnValue = passwordValadition(data);
      break;
    case TextFieldType.email:
      returnValue = emailValidator(data);
      break;
    case TextFieldType.mobile:
      returnValue = mobileValadition(data);
      break;
    case TextFieldType.name:
      returnValue =
          data!.length < 2 ? 'Minimum of 3 characters required' : null;
      break;
  }
  return returnValue;
}

class CustomTextFormField extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  CustomTextFormField(
      {Key? key, required this.textFieldType, required this.controller})
      : super(key: key);
  final TextFieldType textFieldType;

  bool visibilityController = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Container(
            child: Consumer<VisibilityProvider>(
              builder: (BuildContext context, provider, child) {
                return TextFormField(
                  controller: controller,
                  cursorColor: Colors.orangeAccent,
                  keyboardType: textFieldType == TextFieldType.mobile
                      ? TextInputType.number
                      : TextInputType.text,
                  validator: (value) {
                    return getValidator(
                        textFieldType: textFieldType, data: value);
                  },
                  textInputAction: textFieldType == TextFieldType.password
                      ? TextInputAction.done
                      : TextInputAction.next,
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: const Color(0xFF4F504F),
                  ),
                  obscureText: textFieldType == TextFieldType.password
                      ? provider.visibility
                      : false,
                  obscuringCharacter: 'x',
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    // hintText: 'Mobile',
                    prefixIcon: Container(
                      // color: Colors.red,
                      child: Image.asset(
                        getPreffixIcon(textFieldType: textFieldType),
                        scale: 2.5,
                      ),
                    ),
                    labelText: getLabel(textFieldType: textFieldType),
                    labelStyle: GoogleFonts.roboto(
                      color: const Color(0xFF4F504F).withOpacity(0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    floatingLabelStyle: GoogleFonts.roboto(
                      color: const Color(0xFFBDBDBD),
                      fontSize: 22.5,
                    ),
                    border: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorStyle: GoogleFonts.roboto(
                      color: Colors.orangeAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),

                    suffixIcon: textFieldType == TextFieldType.password
                        ? IconButton(
                            splashRadius: 15,
                            onPressed: () {
                              Provider.of<VisibilityProvider>(context,
                                      listen: false)
                                  .checkVisibility();
                            },
                            icon: Icon(
                              visibilityController
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          )
                        : null,
                    counterText: '',
                  ),
                  maxLength: textFieldType == TextFieldType.mobile ? 10 : null,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MyTextFormField extends StatelessWidget {
  TextEditingController textController = TextEditingController();
  FormFieldValidator<String> callBack;
  String myHintText;
  bool obscure;
  double _padding = 15.0;

  MyTextFormField(
      {required this.textController,
      required this.callBack,
      required this.myHintText,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      validator: callBack,
      obscureText: obscure,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        errorStyle: GoogleFonts.roboto(color: Colors.orange),
        hintText: myHintText,
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        hintStyle: TextStyle(color: Color(0xff4F504F), fontSize: 16),
        border: UnderlineInputBorder(),
      ),
    ).paddingAll(10, 10, 10, 10);
  }
}
