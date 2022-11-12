import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Screens/HomePage.dart';
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
import 'google_maps_preview.dart';
import 'invite_people.dart';
import 'milestone_card.dart';

class TripSummaryCreate extends StatefulWidget {
  TripSummaryCreate({
    Key? key,
  }) : super(key: key);

  // final List points = CreateTripModal.distance!.points;

  @override
  State<TripSummaryCreate> createState() => _TripSummaryCreateState();
}

class _TripSummaryCreateState extends State<TripSummaryCreate> {
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
        actions: [
          GestureDetector(
            onTap: () {
              CreateTripModal.printRecommendations();
              // Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 25.0),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ],
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: CreateTripModal.setDetails().onError((error, stackTrace) {
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
                CreateTripModal.distance!.points.isNotEmpty) {
              print(
                  'Points length: ${CreateTripModal.distance!.points.length}');
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
                                child: const MapCard(
                                    // points: widget.points,
                                    ),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                        const Positioned(
                          left: 20,
                          right: 20,
                          bottom: 0,
                          child: TripSummaryCard(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    //If only one present
                    CreateTripModal.milestone.length == 1
                        ? TimeLine(
                            details: CreateTripModal.milestone.first,
                            first: true,
                            last: true,
                          )
                        : Container(),

                    //If only two present
                    CreateTripModal.milestone.length == 2
                        ? TimeLine(
                            details: CreateTripModal.milestone.first,
                            first: true,
                          )
                        : Container(),
                    CreateTripModal.milestone.length == 2
                        ? TimeLine(
                            details: CreateTripModal.milestone.last,
                            last: true,
                          )
                        : Container(),
                    CreateTripModal.milestone.length >= 3
                        ? TimeLine(
                            details: CreateTripModal.milestone.first,
                            first: true,
                          )
                        : Container(),
                    CreateTripModal.milestone.length >= 3
                        ? Column(
                            children: [
                              ...CreateTripModal.milestone
                                  .sublist(
                                      1, CreateTripModal.milestone.length - 1)
                                  .map(
                                    (e) => TimeLine(details: e),
                                  ),
                            ],
                          )
                        : Container(),
                    CreateTripModal.milestone.length >= 3
                        ? TimeLine(
                            details: CreateTripModal.milestone.last,
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
                            'Recommendation',
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
                                ...CreateTripModal.recommendations.map(
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
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 10,
                                    right: 5,
                                    left: 5,
                                  ),
                                  child: CircularButton(
                                    type: CircularButtonType.invite,
                                    callBack: () {
                                      debugPrint('Add a invite button pressed');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const InvitePage(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ...Provider.of<InviteProvider>(context,
                                        listen: true)
                                    .selectedContact
                                    .map(
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
                        CreateTripModal.printMilestones();
                        print("called");
                        UserHttp.createTrip(CreateTripModal().toJson());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: kLargeMapButtonDecoration,
                        child: Center(
                          child: Text(
                            "CREATE",
                            style: GoogleFonts.roboto(color: Colors.white),
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
