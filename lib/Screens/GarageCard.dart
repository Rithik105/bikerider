import 'package:bikerider/Models/bike_list_model.dart';
import 'package:bikerider/Screens/BookService/BookServiceScreen.dart';
import 'package:bikerider/Screens/ServiceRecods/add_bike.dart';
import 'package:bikerider/Screens/ServiceRecods/service_records.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Http/AddBikeHttp.dart';
import '../Http/BookService.dart';
import '../Models/service_records_model.dart';
import 'manual/manual_model.dart';
import 'manual/select_vehicle.dart';
import 'manual/services.dart';

class GarageCard extends StatefulWidget {
  GarageCard({Key? key}) : super(key: key);

  @override
  State<GarageCard> createState() => _GarageCardState();
}

class _GarageCardState extends State<GarageCard> {
  List<bool> CircularIndicator = [false, false, false, false, false];
  List<bool> DisableSelection = [false, false, false, false, false];
  void disableAll(int index) {
    print('disabled');
    for (int i = 0; i < DisableSelection.length; i++) {
      DisableSelection[i] = true;
    }

    CircularIndicator[index] = true;
    setState(() {});
  }

  void enableAll(int index) {
    print('enabled');
    for (int i = 0; i < DisableSelection.length; i++) {
      DisableSelection[i] = false;
    }
    CircularIndicator[index] = false;
    setState(() {});
  }

  List<BikeDetailsModel> bikes = [];
  PersonalDetailsModel? personalDetails;
  List<BikeListModel> bikeList = [];
  List<ServiceRecordModel> sortedAllList = [];

  // List<ServiceRecordModel> sortedFutureList = [];
  List<String> sortedDates = [];
  String diffInDays = "";
  double top = 0.03;

  @override
  void initState() {
    // TODO: implement initState
    BookServiceHttp.getSortedServiceList().then(
      (value) {
        print(value);
        // sortedList.clear();
        for (var e in value["serviceDetails"]) {
          //sortedList.clear();
          sortedAllList.add(ServiceRecordModel.fetchSortedServices(e));
        }
        sortFunction(sortedAllList);
      },
    );
    super.initState();
  }

  sortFunction(List<ServiceRecordModel> sortedList) {
    sortedDates = [];
    for (var e in sortedList) {
      // print(e.slotDate);
      if (DateTime.parse(e.slotDate!).isAfter(
        DateTime.now(),
      )) {
        sortedDates.add(e.slotDate!);
        sortedDates.sort();
        //  sortedDates.sort((a, b){ //sorting in descending order
        //     return DateTime.parse(a).compareTo(DateTime.parse(b));
        // });
      }
    }
    print("ascending");
    print(sortedDates);
    if (sortedDates.isEmpty) {
      print('No service booked');
      diffInDays = "No services booked";
      setState(() {});
      return;
    } else {
      DateTime temp = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 18);
      print('EndDate: $temp');
      Duration diff = DateTime.parse(sortedDates[0]).difference(temp);
      print(diff.inHours);
      // print(diff);
      if (diff.inHours < 6) {
        print('Today is the');
        diffInDays = "Today is your";
      } else if (diff.inDays == 0) {
        print('Tommorow');
        diffInDays = "Tommorow is your";
      } else {
        print(diff.inDays);
        diffInDays = diff.inDays.toString() + " Days";
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // diffInDays!>0?  Text("service"):
              Text(
                "$diffInDays",
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffE08B4D)),
              ),
              // diffInDays!>0? Text("service"):
              Text(
                sortedDates.isEmpty ? '' : "Next Service due",
                style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffE08B4D)),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/homePage/garage_images/indicator.png",
                  ),
                ),
              ),
              Column(
                children: [
                  IgnorePointer(
                    ignoring: DisableSelection[0],
                    child: InkWell(
                      // splashColor: Colors.white,
                      onTap: () {
                        disableAll(0);
                        BookServiceHttp.prefillDetails().then(
                          (value) {
                            enableAll(0);
                            if (value.prefill.isEmpty) {
                              showToast(msg: 'Please add Bike details');
                              print('Please add your bike');
                              AddBikeHttp.addBikeList().then(
                                (value) {
                                  bikeList.clear();
                                  for (var e in value) {
                                    bikeList.add(BikeListModel.fromJson(e));
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddBike(
                                          // bikeList: bikeList,
                                          ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              enableAll(0);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookServiceScreen(prefill: value),
                                ),
                              );
                            }
                          },
                        );
                      },
                      child: Ink(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20,
                              top: (MediaQuery.of(context).size.height * top),
                              bottom: MediaQuery.of(context).size.height * top),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/homePage/garage_images/book_service.png",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Book a Service",
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff515251),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1),
                                  ),
                                ],
                              ),
                              CircularIndicator[0]
                                  ? const Padding(
                                      padding: EdgeInsets.only(right: 15.0),
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color(0xff979797),
                    thickness: 0.5,
                    height: 0,
                  ),
                  IgnorePointer(
                    ignoring: DisableSelection[1],
                    child: InkWell(
                      // splashColor: Colors.white,
                      onTap: () {
                        disableAll(1);
                        BookServiceHttp.prefillDetails().then(
                          (value) {
                            enableAll(1);
                            print(value.prefill);
                            if (value.prefill.isEmpty) {
                              showToast(msg: "Add a bike");
                              print('Please add your bike');
                              AddBikeHttp.addBikeList().then(
                                (value) {
                                  bikeList.clear();
                                  for (var e in value) {
                                    bikeList.add(BikeListModel.fromJson(e));
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddBike(
                                          // bikeList: bikeList,
                                          ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              enableAll(1);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ServiceRecords(prefillDetails: value),
                                ),
                              );
                            }
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20,
                            top: MediaQuery.of(context).size.height * top,
                            bottom: MediaQuery.of(context).size.height * top),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                    "assets/images/homePage/garage_images/service_records.png",
                                    width: 30),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Service Records",
                                  style: GoogleFonts.robotoFlex(
                                      color: Color(0xff515251),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1),
                                )
                              ],
                            ),
                            CircularIndicator[1]
                                ? const Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color(0xff979797),
                    thickness: 0.8,
                    height: 0,
                  ),
                  IgnorePointer(
                    ignoring: DisableSelection[2],
                    child: InkWell(
                      // splashColor: Colors.white,
                      onTap: () {
                        disableAll(2);
                        GetOwnerDetails.getOwner().then(
                          (value) {
                            try {
                              personalDetails =
                                  PersonalDetailsModel.fromJson(value[0]);
                              GetBikeDetails.getBikes().then(
                                (value) {
                                  bikes = [];
                                  value.forEach(
                                    (e) {
                                      bikes.add(BikeDetailsModel.fromJson(e));
                                    },
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SelectBike(
                                          bikeCategories: bikes,
                                          personalDetails: personalDetails!),
                                    ),
                                  );
                                  enableAll(2);
                                },
                              );
                              enableAll(2);
                            } catch (e) {
                              showToast(msg: 'No bike found');
                              enableAll(2);
                            }
                          },
                        );
                      },
                      child: Ink(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20,
                              top: MediaQuery.of(context).size.height * top,
                              bottom: MediaQuery.of(context).size.height * top),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                      "assets/images/homePage/garage_images/owners_manual.png",
                                      width: 30),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Owners Manual",
                                    style: GoogleFonts.robotoFlex(
                                        color: Color(0xff515251),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1),
                                  )
                                ],
                              ),
                              CircularIndicator[2]
                                  ? const Padding(
                                      padding: EdgeInsets.only(right: 15.0),
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color(0xff979797),
                    thickness: 0.5,
                    height: 0,
                  ),
                  IgnorePointer(
                    ignoring: DisableSelection[3],
                    child: InkWell(
                      // splashColor: Colors.white,
                      onTap: () {
                        disableAll(3);
                        print('test');
                        Navigator.pushNamed(context, "/ToolKitScreen");
                        enableAll(3);
                      },
                      child: Ink(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20,
                              top: MediaQuery.of(context).size.height * top,
                              bottom: MediaQuery.of(context).size.height * top),
                          // color: Colors.red,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                      "assets/images/homePage/garage_images/tool_kit.png",
                                      width: 30),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Tool Kit",
                                    style: GoogleFonts.robotoFlex(
                                        color: const Color(0xff515251),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1),
                                  )
                                ],
                              ),
                              CircularIndicator[3]
                                  ? const Padding(
                                      padding: EdgeInsets.only(right: 15.0),
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color(0xff979797),
                    thickness: 0.5,
                    height: 0,
                  ),
                  IgnorePointer(
                    ignoring: DisableSelection[4],
                    child: InkWell(
                      // splashColor: Colors.white,
                      onTap: () {
                        print('test');
                        Navigator.pushNamed(context, "/AccessoriesScreen");
                      },
                      child: Ink(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20,
                              top: MediaQuery.of(context).size.height * top,
                              bottom: MediaQuery.of(context).size.height * top),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Image.asset(
                                  "assets/images/homePage/garage_images/accessories.png",
                                  width: 30),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Accessories",
                                style: GoogleFonts.robotoFlex(
                                  color: const Color(0xff515251),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color(0xff979797),
                    thickness: 0.5,
                    height: 0,
                  ),
                ],
              )
            ],
          ),
        ]),
      ),
    ));
  }
}
