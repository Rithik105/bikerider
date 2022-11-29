import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Http/BookService.dart';
import '../../Models/book_service_model.dart';
import '../../Models/prefill_model.dart';
import '../../custom/constants.dart';
import 'WorkstationSuggestion.dart';

class BookServiceScreen extends StatefulWidget {
  const BookServiceScreen({Key? key, required this.prefill}) : super(key: key);
  final PrefillModel prefill;
  @override
  State<BookServiceScreen> createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  String serviceType = 'General Service';
  String myError = "You will have only two attempts to change your number";
  TextEditingController vehicleTypeTextfield = TextEditingController();
  String vehicleType = 'Classic 350-black';
  bool textFieldDropdown = false;
  bool submit = false;
  bool isEdit = false;
  bool comments = false;
  bool visibility = false;
  int? attempts;

  List<String> categories = [
    "Free service",
    "General service",
    "Breakdown assistance"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textFieldDropdown = widget.prefill.prefill.length > 1 ? true : false;
    attempts = widget.prefill.attemptsLeft!;
    if (!textFieldDropdown) {
      vehicleTypeTextfield.text = widget.prefill.prefill[0].vehicleName!;
      vehicleNumberController.text = widget.prefill.prefill[0].vehicleNumber!;
      vehicleType = vehicleTypeTextfield.text;
    }
    print(widget.prefill.mobile!);
    mobileNumberController.text = widget.prefill.mobile!;
    // vehicleNumberController.addListener(() {
    //   setState(() {
    //     vehicleNumber = vehicleNumberController.text.isNotEmpty;
    //     submit = vehicleNumber && comments;
    //   });
    // });

    commentsController.addListener(() {
      setState(() {
        comments = commentsController.text.isNotEmpty;
        submit = comments;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFFED863A),
        title: Text(
          'Book a Service',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 22.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(
                child: TextField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  enabled: isEdit,
                  controller: mobileNumberController,
                  decoration: InputDecoration(
                    labelText: 'Mobile number',
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    labelStyle: GoogleFonts.robotoFlex(
                        color: const Color(0xff9F9F9F), fontSize: 18),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  attempts! > 0 ? visibility = true : visibility = false;
                  if ((widget.prefill.attemptsLeft)! > 0 && (attempts!) > 0) {
                    // print(isEdit);
                    // isEdit = true;
                    // setState(() {});
                    // print(isEdit);
                    if (isEdit) {
                      if (mobileNumberController.text !=
                              widget.prefill.mobile &&
                          mobileNumberController.text.length == 10) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content: Text(
                              'Are you sure to change the mobile number?',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  BookServiceHttp.updatePhoneNumber(
                                          mobileNumberController.text)
                                      .then((value) {
                                    if (value["message"] ==
                                        "Mobile Number updated Successfully!") {
                                      UserSecureStorage.setToken(
                                          value["accessToken"]);
                                      visibility = false;
                                      attempts = value["attempts_left"];
                                      isEdit = false;
                                      UserSecureStorage.setDetails(
                                          key: "mobile",
                                          value: mobileNumberController.text);

                                      showToast(
                                          msg:
                                              "Phone number changed successfully");

                                      setState(() {});
                                    } else {
                                      showToast(
                                          msg: "Phone number already exists");
                                    }
                                  });

                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Yes',
                                  style: GoogleFonts.robotoFlex(
                                    color: Colors.orangeAccent,
                                    fontSize: 21,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    mobileNumberController.text =
                                        widget.prefill.mobile!;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'No',
                                  style: GoogleFonts.robotoFlex(
                                    color: Colors.orangeAccent,
                                    fontSize: 21,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      isEdit = false;
                      visibility = false;
                      setState(() {});
                    } else
                    // if (!isEdit)
                    {
                      isEdit = true;
                      visibility = true;
                      setState(() {});
                    }
                  } else {
                    isEdit = false;
                    visibility = false;
                    print("less than zero");
                    showToast(
                        msg:
                            "You have exceeded the attempts to change the number");
                    // mobileNumberController.text = "";
                  }
                },
                child: Icon(
                  isEdit ? Icons.done : Icons.edit,
                  color: const Color(0xffA6A4A3),
                ),
              ),
            ]),

            !visibility
                ? SizedBox()
                : Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: attempts == 1
                              ? Text(
                                  "You will have only ${attempts} attempt to change your number",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                )
                              : Text(
                                  "You will have only ${attempts} attempts to change your number",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                        ),
                        Text(
                          "The new number will be your login id",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
            textFieldDropdown
                ? DropdownButtonFormField(
                    icon: Image.asset(
                        "assets/images/book_service/drop_down.png",
                        width: 10),
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      labelText: 'Select vehicle',
                      labelStyle: GoogleFonts.roboto(
                          color: const Color(0xff9F9F9F), fontSize: 18),
                    ),
                    items: [
                      ...widget.prefill.prefill.map(
                        (VehicleDetails item) => DropdownMenuItem<String>(
                          value: item.vehicleName,
                          child: Text(
                            item.vehicleName!,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ],
                    // value: vehicleType,
                    onChanged: (value) {
                      vehicleType = value!;
                      setState(() {
                        vehicleNumberController.text = widget.prefill.prefill
                            .where((element) => element.vehicleName == value)
                            .toList()[0]
                            .vehicleNumber!;
                        // vehicleType = value as String;
                        // vehicleNumberController.text=value;
                        print("vehicle type${vehicleType}");
                        print("vehicle no ${vehicleNumberController.text}");
                      });
                    },
                    itemHeight: 50,
                  )
                : TextField(
                    enabled: false,
                    controller: vehicleTypeTextfield,
                    decoration: InputDecoration(
                      labelText: 'Vehicle type',
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      labelStyle: GoogleFonts.robotoFlex(
                          color: Color(0xff9F9F9F), fontSize: 18),
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              enabled: false,
              controller: vehicleNumberController,
              decoration: InputDecoration(
                labelText: 'Vehicle number',
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                labelStyle: GoogleFonts.robotoFlex(
                    color: Color(0xff9F9F9F), fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              icon: Image.asset("assets/images/book_service/drop_down.png",
                  width: 10),
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                labelText: 'Service Type',
                labelStyle: GoogleFonts.roboto(
                    color: const Color(0xff9F9F9F), fontSize: 18),
              ),
              items: categories
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black87),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  serviceType = value as String;
                  print("service type ${serviceType}");
                });
              },
              itemHeight: 50,
            ),
            // DropDownTextField(
            //   clearOption: true,
            //   // enableSearch: true,
            //   clearIconProperty: IconProperty(color: Colors.grey),
            //   searchDecoration: const InputDecoration(hintText: "Service type"),
            //   validator: (value) {
            //     if (value == null) {
            //       return "Required field";
            //     } else {
            //       return null;
            //     }
            //   },
            //   dropDownItemCount: 3,
            //   dropDownList: const [
            //     DropDownValueModel(name: 'Free Service', value: "Free Service"),
            //     DropDownValueModel(
            //         name: 'General Service', value: "General Service"),
            //     DropDownValueModel(
            //         name: 'Breakdown assistance',
            //         value: "Breakdown assistance"),
            //   ],
            //   onChanged: (val) {
            //     _serviceType = (val as DropDownValueModel).value;
            //   },
            // ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Comments",
              style: GoogleFonts.robotoFlex(
                  color: Color(0xff4F504F), fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: commentsController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ),

            const SizedBox(
              height: 50,
            ),
            // ValueListenableBuilder<TextEditingValue>(
            //   valueListenable: _sectorController,
            //   builder: (context, value, child) {
            //     return ElevatedButton(
            //       onPressed: value.text.isNotEmpty ? () {} : null,
            //     child: Text(
            //         'Submit',
            //         style: TextStyle(fontSize: 24,color: Colors.orange),
            //       ),
            //     );
            //   },
            // ),

            Container(
              height: 45,
              width: double.infinity,
              decoration: submit
                  ? kLargeSubmitButtonDecoration
                  : kLargeSubmitButtonDecorationDisabled,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(0)),
                onPressed: submit ? () => submitData() : null,
                child: Text(
                  "FIND A DEALER",
                  style: kLargeSubmitButtonTextDecoration,
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ).paddingAll(40, 40, 20, 0),
    );
  }

  submitData() {
    BookServiceModel.mobileNumber = mobileNumberController.text;
    BookServiceModel.vehicleType = vehicleType;
    BookServiceModel.vehicleNumber = vehicleNumberController.text;
    BookServiceModel.serviceType = serviceType;
    BookServiceModel.comments = commentsController.text;
    print(BookServiceModel.vehicleNumber);
    print(BookServiceModel.serviceType);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WorkstationSuggestion()));
  }
}
