import 'package:bikerider/Screens/ServiceRecods/service_record_card.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Http/BookService.dart';
import '../../Models/prefill_model.dart';
import '../../Models/service_records_model.dart';

class ServiceRecords extends StatefulWidget {
  const ServiceRecords({Key? key, required this.prefillDetails})
      : super(key: key);
  final PrefillModel prefillDetails;

  @override
  State<ServiceRecords> createState() => _ServiceRecordsState();
}

class _ServiceRecordsState extends State<ServiceRecords> {
  bool initialValue = false;
  String serviceType = 'General Service';
  TextEditingController vehicleTypeTextfield = TextEditingController();
  String vehicleType = 'Classic 350-black';
  bool textFieldDropdown = false;
  List<String> categories = [
    "Free service",
    "General service",
    "Breakdown assistance"
  ];
  List<ServiceRecordModel> serviceRecordList = [];
  List<DropdownMenuItem>? item;
  callBack() {
    serviceRecordList.clear();
    BookServiceHttp.getBookingDetails(vehicleType, serviceType).then((value) {
      // serviceRecordList=[];
      var test = value["serviceDetails"];
      for (var e in test) {
        print("value of e is ${e}");
        serviceRecordList.add(ServiceRecordModel.fromJson(e));
        print(serviceRecordList.length);
        //  print(serviceRecordList.toString());
      }
      //   serviceRecordList.add(value);
      print(serviceRecordList);
      setState(() {});
    });
  }

  // List<DropdownMenuItem> addService() {
  //   item = categories
  //       .map(
  //         (item) => DropdownMenuItem<String>(
  //           value: item,
  //           child: Text(
  //             item,
  //             style: const TextStyle(fontSize: 18, color: Colors.black87),
  //           ),
  //         ),
  //       )
  //       .toList();
  //   return item!;
  // }
  //
  // List<DropdownMenuItem>? removeService() {
  //   item = null;
  //   return item;
  // }

  // Map<String,dynamic> serviceRecordList={};

  void initState() {
    // TODO: implement initState
    super.initState();
    textFieldDropdown = widget.prefillDetails.prefill.length > 1 ? true : false;
    if (!textFieldDropdown) {
      vehicleTypeTextfield.text = widget.prefillDetails.prefill[0].vehicleName!;
      vehicleType = vehicleTypeTextfield.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFFED863A),
        title: Text(
          'Service Records',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              textFieldDropdown
                  ? DropdownButtonFormField(
                      icon: Image.asset(
                          "assets/images/book_service/drop_down.png",
                          width: 10),
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        labelText: 'Select vehicle',
                        labelStyle: GoogleFonts.roboto(
                            color: const Color(0xff9F9F9F), fontSize: 18),
                      ),
                      items: [
                        ...widget.prefillDetails.prefill.map(
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
                        // removeService();
                        // setState(() {});
                        // addService();
                        // print(value);
                        vehicleType = value!;
                        setState(() {});
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
              DropdownButtonFormField(
                // value: initialValue,
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
                items: item,
                onChanged: (value) {
                  setState(() {
                    serviceType = value as String;
                  });
                  serviceRecordList = [];
                  //API call
                  BookServiceHttp.getBookingDetails(vehicleType, serviceType)
                      .then((value) {
                    // serviceRecordList=[];
                    var test = value["serviceDetails"];
                    for (var e in test) {
                      print("value of e is ${e}");
                      serviceRecordList.add(ServiceRecordModel.fromJson(e));
                      print(serviceRecordList.length);
                      //  print(serviceRecordList.toString());
                    }
                    //   serviceRecordList.add(value);
                    print(serviceRecordList);
                    setState(() {});
                  });
                },
                itemHeight: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              ...serviceRecordList.map(
                (e) {
                  print(e);
                  return ServiceRecordsCard(
                    serviceRecordList: e,
                    callBack: callBack,
                  );
                },
              ),
            ],
          ),
        ),
      ).paddingAll(10, 10, 0, 20),
    );
  }
}
