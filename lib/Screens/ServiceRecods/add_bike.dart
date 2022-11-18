import 'package:bikerider/Http/AddBikeHttp.dart';
import 'package:bikerider/Models/add_bike_model.dart';
import 'package:bikerider/Models/bike_list_model.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../custom/constants.dart';
import '../../custom/widgets/button.dart';

class AddBike extends StatefulWidget {
  AddBike({Key? key, required this.bikeList}) : super(key: key);
  final List<BikeListModel> bikeList;

  @override
  State<AddBike> createState() => _AddBikeState();
}

class _AddBikeState extends State<AddBike> {
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController frameController = TextEditingController();
  TextEditingController batteryController = TextEditingController();
  TextEditingController regController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController dealerCodeController = TextEditingController();
  String vehicleType = "Royal Enfield Himalayan";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('InitState');
  }

  @override
  void dispose() {
    vehicleNoController.dispose();
    engineController.dispose();
    frameController.dispose();
    batteryController.dispose();
    regController.dispose();
    modelController.dispose();
    colorController.dispose();
    dealerCodeController.dispose();
    super.dispose();
    print('Dispose');
  }

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
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Vehicle Type",
                        style: kGeneralTextStyle,
                      ),
                    ),
                    const Text(':'),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 175,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        icon: Image.asset(
                            "assets/images/book_service/drop_down.png",
                            width: 10),
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        items: [
                          ...widget.bikeList
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.bikeType,
                                  child: Text(
                                    e.bikeType,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                        onChanged: (value) {
                          print(widget.bikeList.length);
                          print(value.runtimeType);
                          vehicleType = value!;
                          // setState(() {
                          //   vehicleType = value!;
                          //   print("service type ${vehicleType}");
                          // });
                          //vehicleType = value as String;
                        },
                        itemHeight: 60,
                      ),
                      // TextField(
                      //   controller: vehicleTypeController,
                      //   textInputAction: TextInputAction.next,
                      //   decoration: const InputDecoration(
                      //     focusedBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: Color(0xffB4B3B3),
                      //       ),
                      //     ),
                      //   ),
                      //   // style: kDetailsTextStyle,
                      // ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          "Engine",
                          style: kGeneralTextStyle,
                        )),
                    Text(':'),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 150,
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
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Frame No",
                        style: kGeneralTextStyle,
                      ),
                    ),
                    Text(':'),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 150,
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
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          "Battery make",
                          style: kGeneralTextStyle,
                        )),
                    Text(':'),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 150,
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
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Reg No.",
                        style: kGeneralTextStyle,
                      ),
                    ),
                    Text(':'),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 150,
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
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          "Model",
                          style: kGeneralTextStyle,
                        )),
                    Text(':'),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 150,
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
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          "Dealer code",
                          style: kGeneralTextStyle,
                        )),
                    Text(':'),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 150,
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
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          "vehicle number",
                          style: kGeneralTextStyle,
                        )),
                    Text(':'),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 150,
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
                const SizedBox(
                  height: 5,
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
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 150,
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
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: LargeSubmitButton(
                text: "Submit",
                ontap: () {
                  //AddBikeModel(vehicleNumber: vehicleNoController.text, vehicleType: vehicleTypeController.text, engineNumber: engineController.text, batteryMake: batteryController.text, frameNumber: frameController.text, registerNumber: regController.text, model: modelController.text, color: colorController.text, dealerCode: dealerCodeController.text);

                  AddBikeHttp.addBikeDetails(AddBikeModel(
                          vehicleNumber: vehicleNoController.text,
                          vehicleType: vehicleType,
                          engineNumber: engineController.text,
                          batteryMake: batteryController.text,
                          frameNumber: frameController.text,
                          registerNumber: regController.text,
                          model: modelController.text,
                          color: colorController.text,
                          dealerCode: dealerCodeController.text)
                      .toJson());

                  Navigator.pop(context);
                },
              ),
            )
          ],
        ).paddingAll(30, 30, 30, 30),
      ),
    );
  }
}
