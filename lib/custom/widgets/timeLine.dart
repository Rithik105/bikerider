import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Models/ActivityModel.dart';

class ProfileTimeline extends StatelessWidget {
  ProfileTimeline({
    Key? key,
    // required this.details,
    this.first = false,
    this.last = false,
    this.center = false,
    required this.data,
  }) : super(key: key);
  // final ActivityModel details;
  bool first;
  bool last;
  bool center;
  final ActivityModel data;

  @override
  Widget build(BuildContext context) {
    // print('Data Id:${data.id}');
    return Container(
      margin: EdgeInsets.only(left: center || data.id == 0 ? 10 : 14),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                // color: Colors.blue,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        first
                            ? Container(
                                width: 1,
                                height: 75,
                                color: Colors.transparent,
                              )
                            : Container(
                                width: 1,
                                height: 75,
                                color: const Color(0xFFED7E2B),
                              ),
                        Container(
                          // color: Colors.red,
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              boxShadow: center || data.id == 0
                                  ? [
                                      const BoxShadow(
                                        color: Color(0xffED7E2B),
                                        offset: Offset(
                                          0,
                                          0,
                                        ),
                                        blurRadius: 5.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ]
                                  : [],
                              color: const Color(0xffD7762D),
                              borderRadius: center || data.id == 0
                                  ? BorderRadius.circular(30)
                                  : null,
                            ),
                            child: center || data.id == 0
                                ? const Icon(
                                    Icons.gps_not_fixed_outlined,
                                    color: Color(0xffED7E2B),
                                    size: 8,
                                  )
                                : null,
                          ),
                        ),
                        last
                            ? Container(
                                width: 1,
                                height: 75,
                                color: Colors.transparent,
                              )
                            : Container(
                                width: 1,
                                height: 75,
                                color: const Color(0xffED7E2B),
                              ),
                      ],
                    ),
                    Text(
                      center || data.id == 0
                          ? DateFormat('yyyy').format(data.startDate!)
                          : '          ',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            // color: Colors.red,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
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
              child: ProfileTimelineCard(
                tripName: data.tripName!,
                startDate: data.startDate!,
                endDate: data.endDate!,
                url: data.url ??
                    'https://images.unsplash.com/photo-1490730141103-6cac27aaab94?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80',
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileTimelineCard extends StatefulWidget {
  DateTime startDate, endDate;
  String tripName, url;
  ProfileTimelineCard({
    required this.startDate,
    required this.endDate,
    required this.tripName,
    required this.url,
  });

  @override
  State<ProfileTimelineCard> createState() => _ProfileTimelineCardState();
}

class _ProfileTimelineCardState extends State<ProfileTimelineCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      // margin: const EdgeInsets.only(bottom: 10),
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            widget.url,
          ),
        ),
        color: Colors.grey,
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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    widget.tripName,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${DateFormat('dd').format(widget.startDate).toString()}-',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                    Text(
                      DateFormat('dd MMMM').format(widget.endDate).toString(),
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
