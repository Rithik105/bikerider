import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Models/get_trip_model.dart';
import 'package:bikerider/Screens/HomePage.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:bikerider/custom/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Models/create_trip_modal.dart';
import '../Providers/invite_provider.dart';
import '../Utility/enums.dart';
import '../custom/widgets/CustomCard.dart';
import '../custom/widgets/ShowToast.dart';
import '../custom/widgets/button.dart';
import 'ChatScreen.dart';
import 'google_maps_preview.dart';
import 'google_maps_preview_go.dart';
import 'invite_people.dart';
import 'milestone_card.dart';

class TripSummaryGo extends StatefulWidget {
  GetTripModel getTripModel;
  TripSummaryGo({
    required this.getTripModel,
    Key? key,
  }) : super(key: key);

  // final List points = widget.getTripModel.distance!.points;

  @override
  State<TripSummaryGo> createState() => _TripSummaryGoState();
}

class _TripSummaryGoState extends State<TripSummaryGo> {
  double checkEmpty() {
    if (widget.getTripModel.milestones.length == 0) {
      if (widget.getTripModel.recommendations.length == 0) {
        if (widget.getTripModel.riders.length == 0) {
          return 70;
        } else
          return 90;
      } else
        return 105;
    } else if (widget.getTripModel.recommendations.length == 0) {
      return 0;
    } else {
      return 0;
    }
  }

  String checkRecommendations() {
    if (widget.getTripModel.recommendations.length == 0) {
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
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        UserSecureStorage.getToken().then((value) {
                          UserHttp.getNumber(value!).then((value1) {
                            UserHttp.getChats(widget.getTripModel.id!, value)
                                .then((value2) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ChatScreen(
                                  token: value,
                                  chatList: value2,
                                  number: value1["mobile"],
                                  groupId: widget.getTripModel.id!,
                                );
                              }));
                            });
                          });
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: checkEmpty()),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: kLargeMapButtonDecoration,
                          child: Center(
                            child: Text(
                              "GO",
                              style: GoogleFonts.roboto(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
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
