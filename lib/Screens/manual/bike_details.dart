import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'manual_constants.dart';
import 'manual_model.dart';

class BikeDetails extends StatefulWidget {
  BikeDetailsModel bikeDetails;
  BikeDetails({required this.bikeDetails});

  @override
  State<BikeDetails> createState() => _BikeDetailsState();
}

class _BikeDetailsState extends State<BikeDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            //height: MediaQuery.of(context).size.height * 0.55,
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
                            "Engine",
                            style: kGeneralTextStyle,
                          )),
                      Text(':'),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: 200,
                          height: 40,
                          child: Text(
                            "${widget.bikeDetails.engineController.text}",
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
                          "Frame No",
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
                            "${widget.bikeDetails.frameController.text}",
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
                            "Battery make",
                            style: kGeneralTextStyle,
                          )),
                      Text(':'),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: 200,
                          height: 40,
                          child: Text(
                            "${widget.bikeDetails.batteryController.text}",
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
                            "Reg No.",
                            style: kGeneralTextStyle,
                          )),
                      Text(':'),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: 200,
                          height: 40,
                          child: Text(
                            "${widget.bikeDetails.regNoController.text}",
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
                            "Model",
                            style: kGeneralTextStyle,
                          )),
                      Text(':'),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: 200,
                          height: 40,
                          child: Text(
                            "${widget.bikeDetails.modelController.text}",
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
                            "Color",
                            style: kGeneralTextStyle,
                          )),
                      Text(':'),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: 200,
                          height: 40,
                          child: Text(
                            "${widget.bikeDetails.bikeColorController.text}",
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
                            "Dealer code",
                            style: kGeneralTextStyle,
                          )),
                      Text(':'),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: 200,
                          height: 40,
                          child: Text(
                            "${widget.bikeDetails.dealerCodeController.text}",
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
      ),
    );
  }
}
