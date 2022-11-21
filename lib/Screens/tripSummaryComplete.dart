import 'package:bikerider/Models/get_trip_model.dart';
import 'package:bikerider/Screens/gallery/galleryPreviewScreen.dart';
import 'package:bikerider/custom/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom/widgets/CustomCard.dart';
import '../custom/widgets/ShowToast.dart';
import '../custom/widgets/button.dart';
import 'gallery/stagger.dart';
import 'google_maps_preview_go.dart';
import 'map_trip_start.dart';
import 'milestone_card.dart';

class TripSummaryComplete extends StatefulWidget {
  GetTripModel getTripModel;
  TripSummaryComplete({
    required this.getTripModel,
    Key? key,
  }) : super(key: key);

  // final List points = widget.getTripModel.distance!.points;

  @override
  State<TripSummaryComplete> createState() => _TripSummaryCompleteState();
}

class _TripSummaryCompleteState extends State<TripSummaryComplete> {
  double checkEmpty() {
    if (widget.getTripModel.milestones.isEmpty) {
      if (widget.getTripModel.recommendations.isEmpty) {
        if (widget.getTripModel.riders.isEmpty) {
          return 70;
        } else
          return 90;
      } else
        return 105;
    } else if (widget.getTripModel.recommendations.isEmpty) {
      return 0;
    } else {
      return 0;
    }
  }

  String checkRecommendations() {
    if (widget.getTripModel.recommendations.isEmpty) {
      return "No Recommendations";
    } else {
      return "Recommendation";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFED7E2B).withOpacity(0.8),
        centerTitle: true,
        title: Text(
          'Trip Summary',
          style: GoogleFonts.robotoFlex(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: widget.getTripModel.setDetails().onError((error, stackTrace) {
          Navigator.pop(context);
          showToast(msg: 'Route cannot be found');
          return false;
        }),
        // future: Future.delayed(
        //   const Duration(milliseconds: 0),
        // ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done &&
                widget.getTripModel.distance!.points.isNotEmpty) {
              print(
                  'Points length: ${widget.getTripModel.distance!.points.length}');
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          // color: Colors.greenAccent,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 250,
                                // color: Colors.red,
                                // child: const Center(
                                //   child: Text('HI'),
                                // ),
                                child: MapCardGo(
                                  getTripModel: widget.getTripModel,
                                  //points: widget.points,
                                ),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 20,
                          right: 20,
                          bottom: 0,
                          child: TripSummaryGoCard(
                              getTripModel: widget.getTripModel),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    //If only one present
                    widget.getTripModel.milestones.length == 1
                        ? TimeLine(
                            details: widget.getTripModel.milestones[0],
                            first: true,
                            last: true,
                          )
                        : Container(),

                    //If only two present
                    widget.getTripModel.milestones.length == 2
                        ? TimeLine(
                            details: widget.getTripModel.milestones.first,
                            first: true,
                          )
                        : Container(),
                    widget.getTripModel.milestones.length == 2
                        ? TimeLine(
                            details: widget.getTripModel.milestones.last,
                            last: true,
                          )
                        : Container(),
                    widget.getTripModel.milestones.length >= 3
                        ? TimeLine(
                            details: widget.getTripModel.milestones.first,
                            first: true,
                          )
                        : Container(),
                    widget.getTripModel.milestones.length >= 3
                        ? Column(
                            children: [
                              ...widget.getTripModel.milestones
                                  .sublist(1,
                                      widget.getTripModel.milestones.length - 1)
                                  .map(
                                    (e) => TimeLine(details: e),
                                  ),
                            ],
                          )
                        : Container(),
                    widget.getTripModel.milestones.length >= 3
                        ? TimeLine(
                            details: widget.getTripModel.milestones.last,
                            last: true,
                          )
                        : Container(),
                    //Milestone card ends here
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      width: double.infinity,
                      // color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            checkRecommendations(),
                            style: GoogleFonts.roboto(
                              color: const Color(0xFF4F504F),
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...widget.getTripModel.recommendations.map(
                                  (e) => TextCircularButton(
                                      label: e, disable: true, callBack: () {}),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                ...widget.getTripModel.riders.map(
                                  (e) => Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      child: Image.asset(
                                        'assets/images/create_trip/rider.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GalleryPreviewScreen(
                              getTripModel: widget.getTripModel)
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        },
      ),
    );
  }
}
