// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/milestone.dart';

// import '../model/milestone_record.dart';

class TimeLine extends StatelessWidget {
  int index = 0;
  TimeLine(
      {Key? key, required this.details, this.first = false, this.last = false})
      : super(key: key);
  MilestoneModal details;
  bool first;
  bool last;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        children: [
          Column(
            children: [
              Column(
                children: [
                  first
                      ? Container(
                          width: 1,
                          height: 60,
                          color: Colors.transparent,
                        )
                      : Container(
                          width: 1,
                          height: 60,
                          color: const Color(0xffED7E2B),
                        ),
                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xffED7E2B),
                          offset: Offset(
                            0,
                            0,
                          ),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                      color: const Color(0xffD7762D),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.gps_not_fixed_outlined,
                      color: Color(0xffED7E2B),
                      size: 8,
                    ),
                  ),
                  last
                      ? Container(
                          width: 1,
                          height: 80,
                          color: Colors.transparent,
                        )
                      : Container(
                          width: 1,
                          height: 80,
                          color: const Color(0xffED7E2B),
                        ),
                ],
              ),
            ],
          ),
          Container(
            // color: Colors.red,
            // height: 250,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
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
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 40
                        : 30,
                    width: MediaQuery.of(context).size.width * 0.75,
                    // width: double.infinity,
                    // width: MediaQuery.of(context).size.width*0.8,
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
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              'Milestone ${details.milestoneId}',
                              style: GoogleFonts.roboto(
                                color: const Color(0xffED7E2B),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                // color: Colors.blue,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Text(
                                  details.from!.place,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color:
                                        const Color.fromRGBO(58, 57, 57, 0.87),
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 2,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // color: Colors.red,
                                      width: double.maxFinite,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            details.milDistance ??
                                                details.distance!.distance,
                                            style: GoogleFonts.roboto(
                                              color: const Color(0xff979797),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            ' - ',
                                            style: GoogleFonts.roboto(
                                              color: const Color(0xff979797),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            details.milDuration ??
                                                details.distance!.duration,
                                            style: GoogleFonts.roboto(
                                              color: const Color(0xff979797),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // width: MediaQuery.of(context).size.width *
                                      //     0.22,
                                      width: double.maxFinite,
                                      height: 1,
                                      color: const Color(0xff979797),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // color: Colors.red,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Text(
                                  details.to!.place,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color:
                                        const Color.fromRGBO(58, 57, 57, 0.87),
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
