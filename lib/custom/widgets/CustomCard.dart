import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Models/get_trip_model.dart';
import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:bikerider/custom/widgets/text_form_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Models/create_trip_modal.dart';
import '../../Models/milestone.dart';
import '../../Utility/enums.dart';

class CustomCard extends StatefulWidget {
  String startDate, id, tripName;
  Function ontap;
  CustomCard(
      {required this.startDate,
      required this.tripName,
      required this.ontap,
      required this.id});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 155,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              "https://images.unsplash.com/photo-1490730141103-6cac27aaab94?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80",
            ),
            fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(
              0,
              0,
            ),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ), //BoxShadow
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.tripName,
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat('dd MMM')
                      .format(DateTime.parse(widget.startDate))
                      .toString(),
                  style: GoogleFonts.roboto(color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 1)),
                  child: Text(
                    "Upcoming",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              UserHttp.deleteTrip(widget.id).then((value) {
                showToast(msg: "Trip Successfully Deleted");
                BlocProvider.of<BikeCubit>(context).getTrips();
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              height: 45,
              child: Image.asset(
                "assets/images/homePage/cancel.png",
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MileStoneLarge extends StatefulWidget {
  MileStoneLarge({
    Key? key,
    required this.milestone,
    required this.removeCard,
    // required this.fromLocation,
    // required this.toLocation,
  }) : super(key: key);

  // final TextEditingController controller;
  // final TextEditingController fromLocation;
  // final TextEditingController toLocation;
  MilestoneModal milestone;
  Function removeCard;
  @override
  State<MileStoneLarge> createState() => _MileStoneLargeState();
}

class _MileStoneLargeState extends State<MileStoneLarge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(
                0,
                0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFBE7d9),
                    Colors.white,
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Milestone ${widget.milestone.milestoneId}',
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF91867d),
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        splashRadius: 1,
                        onPressed: () {
                          print('Delete Card');
                          print('Call Back function is to be triggered');
                          widget.removeCard(widget.milestone.milestoneId);

                          //Write a Call back here.
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black45,
                          size: 25,
                        ),
                        // icon: Image.asset('assets/images/create_trip/close.png'),
                      )
                    ],
                  ),
                  Text(
                    'This is to make a break journey in between your trip',
                    style: GoogleFonts.robotoFlex(
                      color: Colors.redAccent,
                      fontSize: 12.5,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SearchDestination(
                      //       controller: widget.milestone.fromController,
                      //       type: MilestoneType.from,
                      //       locationDetails: widget.milestone.from,
                      //       callBack: (LocationDetails temp) {
                      //         widget.milestone.from = temp;
                      //       },
                      //     ),
                      //   ),
                      // );
                    },
                    child: CustomSmallTextFormField(
                      textFieldType: TextFieldType.location,
                      controller: widget.milestone.fromController,
                      label: 'From',
                      width: MediaQuery.of(context).size.width * 0.75,
                      locationType: MilestoneType.from,
                      enable: false,
                      milestoneModal: widget.milestone,
                      // callBack: (LocationDetails temp) {
                      //   print('callBack');
                      //
                      //   widget.milestone.from = temp;
                      // },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    child: widget.milestone.milestoneId == 1
                        ? Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(
                                    0,
                                    2,
                                  ),
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                print('getLocation');
                                // // widget.milestone.fromController.text =
                                // await getCurrentLocationData();
                                setState(() {});
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/create_trip/gps.png',
                                    scale: 2,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.milestone.fromController.text,
                                        style: GoogleFonts.robotoFlex(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        'Current Location',
                                        style: GoogleFonts.robotoFlex(
                                          color: Colors.black.withOpacity(0.3),
                                          fontSize: 12.5,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('1212121');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SearchDestination(
                      //       controller: widget.milestone.toController,
                      //       type: MilestoneType.to,
                      //       locationDetails: widget.milestone.to,
                      //       callBack: (LocationDetails temp) {
                      //         widget.milestone.to = temp;
                      //       },
                      //     ),
                      //   ),
                      // );
                    },
                    child: Container(
                      child: CustomSmallTextFormField(
                        enable: false,
                        textFieldType: TextFieldType.location,
                        controller: widget.milestone.toController,
                        label: 'To',
                        // width: 325,
                        width: MediaQuery.of(context).size.width * 0.75,
                        locationType: MilestoneType.to,
                        milestoneModal: widget.milestone,
                        // callBack: (LocationDetails temp) {
                        //   widget.milestone.to = temp;
                        // },
                        // enable: false,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TripSummaryCard extends StatelessWidget {
  const TripSummaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      width: MediaQuery.of(context).size.width - 20,
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(
              0,
              0,
            ),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ), //BoxShadow
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/trip_summary/motorcycle.png",
            scale: 2.5,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            CreateTripModal.tripName!,
            style: GoogleFonts.roboto(
                color: const Color(0x99000000),
                fontSize: 27,
                fontWeight: FontWeight.w600),
          ),
          // Text(
          //   "Scramble Goa",
          //   style: GoogleFonts.roboto(
          //       color: const Color(0x99000000),
          //       fontSize: 27,
          //       fontWeight: FontWeight.w600),
          // ),
          const SizedBox(
            height: 15,
          ),
          Text(
            CreateTripModal.fromDetails!.place,
            style: GoogleFonts.roboto(
              color: const Color(0xaa000000),
              fontSize: 19,
            ),
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          // Text(
          //   "12-15 Nov, 2017",
          //   style: GoogleFonts.roboto(color: Color(0xaa000000), fontSize: 19),
          // ),
          const SizedBox(
            height: 15,
          ),
          Text(
            CreateTripModal.startTime!,
            style: GoogleFonts.roboto(
              color: const Color(0xaa000000),
              fontSize: 16,
            ),
          ),
          // Text(
          //   "08:00 am",
          //   style: GoogleFonts.roboto(
          //     color: const Color(0xaa000000),
          //     fontSize: 16,
          //   ),
          // ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 90,
                child: Text(
                  CreateTripModal.fromDetails!.place,
                  style: GoogleFonts.roboto(
                    color: const Color(0xaa000000),
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              // Text(
              //   "Udupi",
              //   style: GoogleFonts.roboto(
              //     color: Color(0xaa000000),
              //     fontSize: 16,
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 100,
                height: 2,
                color: const Color(0x2f000000),
              ),
              SizedBox(
                width: 90,
                child: Text(
                  CreateTripModal.toDetails!.place,
                  style: GoogleFonts.roboto(
                    color: const Color(0xbb000000),
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              )
              // Text(
              //   "Goa",
              //   style: GoogleFonts.roboto(
              //     color: const Color(0xbb000000),
              //     fontSize: 16,
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}

class TripSummaryGoCard extends StatelessWidget {
  GetTripModel getTripModel;
  TripSummaryGoCard({Key? key, required this.getTripModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      width: MediaQuery.of(context).size.width - 20,
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(
              0,
              0,
            ),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ), //BoxShadow
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/trip_summary/motorcycle.png",
            scale: 2.5,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            getTripModel.tripName!,
            style: GoogleFonts.roboto(
                color: const Color(0x99000000),
                fontSize: 27,
                fontWeight: FontWeight.w600),
          ),
          // Text(
          //   "Scramble Goa",
          //   style: GoogleFonts.roboto(
          //       color: const Color(0x99000000),
          //       fontSize: 27,
          //       fontWeight: FontWeight.w600),
          // ),
          const SizedBox(
            height: 15,
          ),
          Text(
            getTripModel.source!.place,
            style: GoogleFonts.roboto(
              color: const Color(0xaa000000),
              fontSize: 19,
            ),
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          // Text(
          //   "12-15 Nov, 2017",
          //   style: GoogleFonts.roboto(color: Color(0xaa000000), fontSize: 19),
          // ),
          const SizedBox(
            height: 15,
          ),
          Text(
            getTripModel.startTime!,
            style: GoogleFonts.roboto(
              color: const Color(0xaa000000),
              fontSize: 16,
            ),
          ),
          // Text(
          //   "08:00 am",
          //   style: GoogleFonts.roboto(
          //     color: const Color(0xaa000000),
          //     fontSize: 16,
          //   ),
          // ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 90,
                child: Text(
                  getTripModel.source!.place,
                  style: GoogleFonts.roboto(
                    color: const Color(0xaa000000),
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              // Text(
              //   "Udupi",
              //   style: GoogleFonts.roboto(
              //     color: Color(0xaa000000),
              //     fontSize: 16,
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 100,
                height: 2,
                color: const Color(0x2f000000),
              ),
              SizedBox(
                width: 90,
                child: Text(
                  getTripModel.destination!.place,
                  style: GoogleFonts.roboto(
                    color: const Color(0xbb000000),
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              )
              // Text(
              //   "Goa",
              //   style: GoogleFonts.roboto(
              //     color: const Color(0xbb000000),
              //     fontSize: 16,
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}
