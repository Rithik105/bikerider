import 'package:bikerider/Models/bike_list_model.dart';
import 'package:bikerider/Screens/BookService/BookServiceScreen.dart';
import 'package:bikerider/Screens/ServiceRecods/add_bike.dart';
import 'package:bikerider/Screens/ServiceRecods/service_records.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Http/AddBikeHttp.dart';
import '../Models/service_records_model.dart';
import 'manual/manual_model.dart';
import 'manual/select_vehicle.dart';
import 'manual/servieces.dart';

import '../Http/BookService.dart';

class GarageCard extends StatefulWidget {
  GarageCard({Key? key}) : super(key: key);

  @override
  State<GarageCard> createState() => _GarageCardState();
}

class _GarageCardState extends State<GarageCard> {
  List<BikeDetailsModel> bikes = [];
  PersonalDetailsModel? personalDetails;
  List<BikeListModel> bikeList = [];
  List<ServiceRecordModel> sortedAllList = [];

  // List<ServiceRecordModel> sortedFutureList = [];
  List<String> sortedDates = [];
  String diffInDays = "";

  @override
  void initState() {
    // TODO: implement initState
    BookServiceHttp.getSortedServiceList().then((value) {
      print(value);
      // sortedList.clear();
      for (var e in value["serviceDetails"]) {
        //sortedList.clear();
        sortedAllList.add(ServiceRecordModel.fetchSortedServices(e));
      }
      sortFunction(sortedAllList);
    },);
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
      print('No seervice booked');
      diffInDays = "No service booked";
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                  "Next Service due",
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffE08B4D)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/homePage/garage_images/indicator.png",
              ),
            ).paddingAll(20, 20, 0, 0),
            GestureDetector(
              onTap: () {
                BookServiceHttp.prefillDetails().then(
                  (value) {
                    if (value.prefill.isEmpty) {
                      showToast(msg: 'Please add Bike details');
                      print('Please add your bike');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddBike(
                            bikeList: [],
                          ),
                        ),
                      );
                    } else {
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
              child: Row(
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
                        color: Color(0xff515251),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  ),
                ],
              ),
            ).paddingAll(20, 20, 0, 0),
            const Divider(
              color: Color(0xff979797),
              thickness: 0.5,
            ),
            GestureDetector(
              onTap: () {
                BookServiceHttp.prefillDetails().then(
                  (value) {
                    if (value.prefill.isEmpty) {
                      showToast(msg: "Please Add a bike");
                      print('Please add your bike');
                      AddBikeHttp.addBikeList().then(
                        (value) {
                          bikeList.clear();
                          for (var e in value) {
                            print("value of e ${e}");
                            bikeList.add(BikeListModel.fromJson(e),);
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddBike(
                                bikeList: bikeList,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
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
              child: Row(
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
                  ),
                ],
              ),
            ).paddingAll(20, 20, 0, 0),
            const Divider(
              color: Color(0xff979797),
              thickness: 0.5,
            ),
            GestureDetector(
              onTap: () {
                GetOwnerDetails.getOwner().then(
                  (value) {
                    personalDetails = PersonalDetailsModel.fromJson(value[0]);
                    GetBikeDetails.getBikes().then(
                      (value) {
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
                      },
                    );
                  },
                );
              },
              child: Row(
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
                  ),
                ],
              ),
            ).paddingAll(20, 20, 0, 0),
            const Divider(
              color: Color(0xff979797),
              thickness: 0.5,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
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
                        color: Color(0xff515251),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  ),
                ],
              ),
            ).paddingAll(20, 20, 0, 0),
            const Divider(
              color: Color(0xff979797),
              thickness: 0.5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/AccessoriesScreen");
              },
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
                        color: Color(0xff515251),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  ),
                ],
              ),
            ).paddingAll(20, 20, 0, 0),
          ],
        ).paddingAll(0, 0, 40, 0));
  }
}
