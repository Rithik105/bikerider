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
                    height: 30,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 70,
                                child: Text(
                                  details.from!.place,
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color:
                                        const Color.fromRGBO(58, 57, 57, 0.87),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      details.milDistance ??
                                          details.distance!.distance,
                                      style: GoogleFonts.roboto(
                                          color: const Color(0xff979797),
                                          fontSize: 15),
                                    ),
                                    Container(
                                      width: 120,
                                      height: 1,
                                      color: const Color(0xff979797),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 70,
                                child: Text(
                                  details.to!.place,
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color:
                                        const Color.fromRGBO(58, 57, 57, 0.87),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
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
