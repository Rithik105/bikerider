import 'package:bikerider/Providers/VisibiltyProvider.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Models/create_trip_modal.dart';
import '../../Models/milestone.dart';
import '../../Screens/search_location.dart';
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
    return "E-Mail or Password Required";
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

String getLabel(
    {required TextFieldType textFieldType, required String? label}) {
  String returnValue = '';
  if (label == null) {
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
  } else {
    return label;
  }
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
                    labelText:
                        getLabel(textFieldType: textFieldType, label: null),
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

class CustomSmallTextFormField extends StatefulWidget {
  const CustomSmallTextFormField({
    Key? key,
    required this.textFieldType,
    this.label,
    required this.controller,
    this.width,
    this.enable = true,
    this.locationType = MilestoneType.from,
    this.milestoneModal,
    // required this.validate,
    // this.callBack,
    // this.suffixIcon = true,
  }) : super(key: key);
  final TextFieldType textFieldType;
  final String? label;
  final TextEditingController controller;
  final double? width;
  final bool enable;
  // final bool suffixIcon;
  final MilestoneType locationType;
  final MilestoneModal? milestoneModal;
  // final Function? callBack;
  // final Function validate;
  @override
  State<CustomSmallTextFormField> createState() =>
      _CustomSmallTextFormFieldState();
}

class _CustomSmallTextFormFieldState extends State<CustomSmallTextFormField> {
  bool visibilityController = true;
  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      width: widget.width ?? 150,
      child: Container(
        // color: Colors.green,
        margin: widget.textFieldType == TextFieldType.date
            ? const EdgeInsets.symmetric(horizontal: 5)
            : null,
        child: GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();
            if (widget.textFieldType == TextFieldType.date) {
              pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2100),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Colors.orangeAccent,
                        onPrimary: Colors.white,
                        onSurface: Colors.black,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          primary: Colors.red, // button text color
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              print(pickedDate);
              setState(() {
                widget.controller.text =
                    DateFormat('dd-MM-yyyy').format(pickedDate!).toString();
                if (widget.controller.text.isNotEmpty) {
                  widget.label == 'Start Date'
                      ? CreateTripModal.startDate = widget.controller.text
                      : CreateTripModal.endDate = widget.controller.text;
                }
              });
            }
            if (widget.textFieldType == TextFieldType.clock) {
              pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                    hour: DateTime.now().hour, minute: DateTime.now().minute),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light(
                        // change the border color
                        primary: Colors.orange,
                        // change the text color
                        onSurface: Colors.orange,
                      ),
                      // button colors
                      buttonTheme: const ButtonThemeData(
                        colorScheme: ColorScheme.light(
                          primary: Colors.black,
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              // print(pickedTime!.format(context));
              // setState(() {
              //   // widget.controller.text =
              //   //     '${pickedTime!.hour % 12 == 0 ? 12 : pickedTime!.hour % 12}:${pickedTime?.minute} ${pickedTime?.period.toString().substring(10).toUpperCase()}';
              //   widget.controller.text = pickedTime!.format(context);
              // });
              if (pickedTime!.hour.toString().length == 1) {
                widget.controller.text =
                    '0${pickedTime!.hour % 12 == 0 ? 12 : pickedTime!.hour % 12}:${pickedTime?.minute} ${pickedTime?.period.toString().substring(10).toUpperCase()}';
              } else {
                widget.controller.text = pickedTime!.format(context);
              }
              if (widget.controller.text.isNotEmpty) {
                CreateTripModal.startTime = widget.controller.text;
              }
            }
            if (widget.textFieldType == TextFieldType.location) {
              print(widget.milestoneModal?.milestoneId);
              print('Go to location Screen');
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchDestination(
                    controller: widget.controller,
                    type: widget.locationType,
                    locationDetails: widget.milestoneModal,
                    // callBack: (LocationDetails temp) {
                    //   widget.locationType == MilestoneType.from
                    //       ? widget.milestoneModal?.from = temp
                    //       : widget.milestoneModal?.to = temp;
                    // },
                  ),
                ),
              );
              // widget.callBack!(widget.locationType == MilestoneType.from
              //     ? widget.milestoneModal!.from
              //     : widget.milestoneModal!.to);
            }
          },
          child: TextFormField(
            autofocus: false,
            // initialValue: widget.controller.text,
            controller: widget.controller,
            // enabled: widget.enable,
            enabled: widget.enable,
            cursorColor: Colors.orangeAccent,
            keyboardType: widget.textFieldType == TextFieldType.mobile
                ? TextInputType.number
                : TextInputType.text,
            validator: (value) {
              if (widget.textFieldType == TextFieldType.custom) {
                return value!.isEmpty ? 'Enter a value' : null;
              }

              if (widget.textFieldType == TextFieldType.date) {
                return value!.isEmpty ? 'Select a date' : null;
              }

              if (widget.textFieldType == TextFieldType.clock) {
                return value!.isEmpty ? 'Select a time' : null;
              }
              if (widget.textFieldType == TextFieldType.location) {
                return value!.isEmpty ? 'Select a location' : null;
              }
              return getValidator(
                  textFieldType: widget.textFieldType, data: value);
            },
            textInputAction: widget.textFieldType == TextFieldType.password
                ? TextInputAction.done
                : TextInputAction.next,
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: const Color(0xFF4F504F),
            ),
            obscureText: widget.textFieldType == TextFieldType.password
                ? visibilityController
                : false,
            obscuringCharacter: 'x',
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              // hintText: 'Mobile',
              // prefixIcon: Container(
              //   // color: Colors.red,
              //   child: Image.asset(
              //     getPreffixIcon(textFieldType: widget.textFieldType),
              //     scale: 2.5,
              //   ),
              // ),
              labelText: getLabel(
                  textFieldType: widget.textFieldType, label: widget.label),
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

              // focusedBorder: const OutlineInputBorder(
              //   borderSide: BorderSide.none,
              // ),
              suffixIcon: widget.textFieldType == TextFieldType.date
                  ? Image.asset(
                      'assets/images/create_trip/date.png',
                      scale: 2.5,
                    )
                  : widget.textFieldType == TextFieldType.clock
                      ? Image.asset(
                          'assets/images/create_trip/clock.png',
                          scale: 2.5,
                        )
                      : null,

              counterText: '',
            ),
            maxLength: widget.textFieldType == TextFieldType.mobile ? 10 : null,
          ),
        ),
      ),
    );
  }
}

class SearchTextFormField extends StatefulWidget {
  const SearchTextFormField({Key? key}) : super(key: key);

  @override
  State<SearchTextFormField> createState() => _SearchTextFormFieldState();
}

class _SearchTextFormFieldState extends State<SearchTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        enabled: true,
        // controller: destinationController,
        onChanged: (value) {},
        decoration: InputDecoration(
          // suffixIcon: Image.asset("assets/cancel.png"),

          suffixIcon: IconButton(
            onPressed: () {
              // destinationController.clear();
              // setState(() {
              //   suggestion = [];
              // });
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black45,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: "Where to?",
          labelStyle: GoogleFonts.roboto(
            color: const Color.fromRGBO(166, 166, 166, 0.87),
            fontSize: 14,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(194, 188, 188, 0.5),
            ),
          ),
        ),
      ),
    );
  }
}
