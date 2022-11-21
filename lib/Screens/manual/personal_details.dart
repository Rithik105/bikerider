import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'manual_constants.dart';
import 'manual_model.dart';

class PersonalDetails extends StatefulWidget {
  PersonalDetailsModel personalDetails;
  PersonalDetails({required this.personalDetails});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: MediaQuery.of(context).size.height * 0.52,
          width: double.infinity,
          margin: EdgeInsets.only(top: 30, bottom: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: const Offset(
                  0,
                  0,
                ),
                blurRadius: 5.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Licence No",
                        style: kGeneralTextStyle,
                      ),
                    ),
                    Text(':'),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 200,
                        height: 40,
                        child: Text(
                          "${widget.personalDetails.licenceNumberController.text}",
                          style: kDetailsTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Name",
                        style: kGeneralTextStyle,
                      ),
                    ),
                    Text(':'),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 200,
                        height: 40,
                        child: Text(
                          "${widget.personalDetails.nameController.text}",
                          style: kDetailsTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text("Door no", style: kGeneralTextStyle),
                    ),
                    Text(':'),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 200,
                        height: 40,
                        child: Text(
                          "${widget.personalDetails.doorNoController.text}",
                          style: kDetailsTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "City",
                        style: kGeneralTextStyle,
                      ),
                    ),
                    Text(':'),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 200,
                        height: 40,
                        child: Text(
                          "${widget.personalDetails.cityController.text}",
                          style: kDetailsTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          "State",
                          style: kGeneralTextStyle,
                        )),
                    Text(':'),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 200,
                        height: 40,
                        child: Text(
                          "${widget.personalDetails.stateController.text}",
                          style: kDetailsTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          "Pincode",
                          style: kGeneralTextStyle,
                        )),
                    Text(':'),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 200,
                        height: 40,
                        child: Text(
                          "${widget.personalDetails.pincodeController.text}",
                          style: kDetailsTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Mobile",
                        style: kGeneralTextStyle,
                      ),
                    ),
                    Text(':'),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 200,
                        height: 40,
                        child: Text(
                          "${widget.personalDetails.mobileController.text}",
                          style: kDetailsTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          "Email",
                          style: kGeneralTextStyle,
                        )),
                    Text(':'),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 200,
                        height: 40,
                        child: Text(
                          "${widget.personalDetails.emailController.text}",
                          style: kDetailsTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
