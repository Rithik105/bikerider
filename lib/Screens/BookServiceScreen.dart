import 'package:bikerider/custom/widgets/padding.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom/constants.dart';

class BookServiceScreen extends StatefulWidget {
  const BookServiceScreen({Key? key}) : super(key: key);
  @override
  State<BookServiceScreen> createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  final vehicleTypeController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  final commentsController = TextEditingController();
  String? _sectorController;
  bool submit = false;
  bool vehicleType = false;
  bool vehicleNumber = false;
  bool comments = false;
  List<String> categories = [
    "Free service",
    "General service",
    "Breakdown assistance"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vehicleTypeController.addListener(() {
      setState(() {
        vehicleType = vehicleTypeController.text.isNotEmpty;
        submit = vehicleType && vehicleNumber && comments;
      });
    });
    vehicleNumberController.addListener(() {
      setState(() {
        vehicleNumber = vehicleNumberController.text.isNotEmpty;
        submit = vehicleType && vehicleNumber && comments;
      });
    });

    commentsController.addListener(() {
      setState(() {
        comments = commentsController.text.isNotEmpty;
        submit = vehicleType && vehicleNumber && comments;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    vehicleTypeController.dispose();
    vehicleNumberController.dispose();
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
          onPressed: () {},
        ),
        backgroundColor: const Color(0xFFED863A),
        centerTitle: true,
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
            TextField(
              decoration: InputDecoration(
                labelText: 'Mobile number',
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                labelStyle: GoogleFonts.robotoFlex(
                    color: Color(0xff9F9F9F), fontSize: 18),
                suffixIcon: const Icon(
                  Icons.edit,
                  color: Color(0xffA6A4A3),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: vehicleTypeController,
              decoration: InputDecoration(
                labelText: 'Vehicle type',
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                labelStyle: GoogleFonts.robotoFlex(
                    color: Color(0xff9F9F9F), fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: vehicleNumberController,
              decoration: InputDecoration(
                labelText: 'Vehicle number',
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                labelStyle: GoogleFonts.robotoFlex(
                    color: Color(0xff9F9F9F), fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            DropDownTextField(
              controller: _sectorController,
              clearOption: true,
              enableSearch: true,
              clearIconProperty: IconProperty(color: Colors.grey),
              searchDecoration: const InputDecoration(hintText: "Service type"),
              validator: (value) {
                if (value == null) {
                  return "Required field";
                } else {
                  return null;
                }
              },
              dropDownItemCount: 3,
              dropDownList: const [
                DropDownValueModel(name: 'Free service', value: "value1"),
                DropDownValueModel(name: 'General service', value: "value2"),
                DropDownValueModel(
                    name: 'Breakdown assistance', value: "value3"),
              ],
              onChanged: (val) {},
            ),
            // SizedBox(width: double.infinity,
            //   child: DropdownButton2(
            //     icon: Image.asset("assets/drop_down.png",width: 10),
            //     hint: Text(
            //       'Service type',
            //       style: TextStyle(
            //         fontSize: 14,
            //         color: Colors.black26,
            //       ),
            //     ),
            //     items: categories
            //         .map(
            //           (item) => DropdownMenuItem<String>(
            //         value: item,
            //         child: Text(
            //           item,
            //           style: const TextStyle(
            //               fontSize: 18, color: Colors.black54),
            //         ),
            //       ),
            //     )
            //         .toList(),
            //     value: _sectorController,
            //     onChanged: (value) {
            //       setState(() {
            //         _sectorController = value as String;
            //       });
            //     },
            //     buttonHeight: 60,
            //     buttonWidth: 200,
            //     itemHeight: 40,
            //   ),
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
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
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
          ],
        ),
      ).paddingAll(40, 40, 20, 30),
    );
  }
}

submitData() {
  // Do something here
}
