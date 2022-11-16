import 'package:bikerider/Http/AddBikeHttp.dart';
import 'package:bikerider/Models/add_bike_model.dart';
import 'package:bikerider/Screens/GarageCard.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../custom/constants.dart';
import '../../custom/widgets/button.dart';

class AddBike extends StatefulWidget {
  const AddBike({Key? key}) : super(key: key);

  @override
  State<AddBike> createState() => _AddBikeState();
}

class _AddBikeState extends State<AddBike> {
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController frameController = TextEditingController();
  TextEditingController batteryController = TextEditingController();
  TextEditingController regController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController dealerCodeController = TextEditingController();
  List<AddBike> bikeList = [];
  AddBike addbike = new AddBike();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffed863a),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        title: Text(
          'Add Bike Details',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 150,
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
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              controller: engineController,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffB4B3B3),
                                  ),
                                ),
                              ),
                              //style: kDetailsTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
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
                            child: TextField(
                              controller: frameController,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffB4B3B3),
                                  ),
                                ),
                              ),
                              //  style: kDetailsTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 150,
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
                            child: TextField(
                              controller: batteryController,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffB4B3B3),
                                  ),
                                ),
                              ),
                              // style: kDetailsTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 150,
                            child: Text(
                              "Reg No.",

                              style: kGeneralTextStyle,
                            ),),
                        Text(':'),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: 200,
                            height: 40,
                            child: TextField(
                              controller: regController,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffB4B3B3),
                                  ),
                                ),
                              ),
                              // style: kDetailsTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 150,
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
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              controller: modelController,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffB4B3B3),
                                  ),
                                ),
                              ),
                              // style: kDetailsTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       SizedBox(
                            width: 150,
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
                            child: TextField(
                              controller: dealerCodeController,
                              textInputAction: TextInputAction.next,
                              //style: kDetailsTextStyle,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffB4B3B3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                         SizedBox(
                            width: 150,
                            child: Text(
                              "Vehicle Type",
                              style: kGeneralTextStyle,
                            )),
                        Text(':'),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: 200,
                            height: 40,
                            child: TextField(
                              controller: vehicleTypeController,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffB4B3B3),
                                  ),
                                ),
                              ),
                              // style: kDetailsTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: 150,
                            child: Text(
                              "vehicle number",
                                style: kGeneralTextStyle,
                            )),
                        Text(':'),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: 200,
                            height: 40,
                            child: TextField(
                              controller: vehicleNoController,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffB4B3B3),
                                  ),
                                ),
                              ),
                              // style: kDetailsTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                         SizedBox(
                            width: 150,
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
                            child: TextField(
                              controller: colorController,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffB4B3B3),
                                  ),
                                ),
                              ),
                              //style: kDetailsTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
                width: double.infinity,
                child: LargeSubmitButton(
                    text: "Done",
                    ontap: () {
                      //AddBikeModel(vehicleNumber: vehicleNoController.text, vehicleType: vehicleTypeController.text, engineNumber: engineController.text, batteryMake: batteryController.text, frameNumber: frameController.text, registerNumber: regController.text, model: modelController.text, color: colorController.text, dealerCode: dealerCodeController.text);

                      AddBikeHttp.addBikeDetails(AddBikeModel(
                              vehicleNumber: vehicleNoController.text,
                              vehicleType: vehicleTypeController.text,
                              engineNumber: engineController.text,
                              batteryMake: batteryController.text,
                              frameNumber: frameController.text,
                              registerNumber: regController.text,
                              model: modelController.text,
                              color: colorController.text,
                              dealerCode: dealerCodeController.text)
                          .toJson());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GarageCard()));
                    }))
          ],
        ).paddingAll(30, 30, 0, 30),
      ),
    );
  }
}
