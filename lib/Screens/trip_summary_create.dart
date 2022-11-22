import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Models/create_trip_modal.dart';
import 'package:bikerider/Providers/invite_provider.dart';
import 'package:bikerider/Screens/google_maps_preview.dart';
import 'package:bikerider/Screens/home_screen.dart';
import 'package:bikerider/Screens/milestone_card.dart';
import 'package:bikerider/Utility/enums.dart';
import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:bikerider/custom/constants.dart';
import 'package:bikerider/custom/widgets/CustomCard.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:bikerider/custom/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TripSummaryCreateScreen extends StatefulWidget {
  const TripSummaryCreateScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TripSummaryCreateScreen> createState() =>
      _TripSummaryCreateScreenState();
}

class _TripSummaryCreateScreenState extends State<TripSummaryCreateScreen> {
  double checkEmpty() {
    if (CreateTripModal.milestone.isEmpty) {
      if (CreateTripModal.recommendations.isEmpty) {
        if (CreateTripModal.contacts.isEmpty) {
          return 40;
        }
        return 70;
      } else {
        return 45;
      }
    } else if (CreateTripModal.recommendations.isEmpty) {
      return 0;
    } else {
      return 0;
    }
  }

  String checkRecommendations() {
    if (CreateTripModal.recommendations.isEmpty) {
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
        actions: [
          GestureDetector(
            onTap: () {
              // CreateTripModal.printRecommendations();
              Navigator.pop(context);
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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: const [
                            SizedBox(
                              width: double.infinity,
                              height: 250,
                              child: MapCard(),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                          ],
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
                    CreateTripModal.milestone.length == 1
                        ? TimeLine(
                            details: CreateTripModal.milestone.first,
                            first: true,
                            last: true,
                          )
                        : Container(),
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
                                CircularButton(
                                  type: CircularButtonType.invite,
                                  callBack: () {
                                    Navigator.pushNamed(context, '/InvitePage');
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Provider.of<InviteProvider>(context,
                                            listen: true)
                                        .selectedContact
                                        .isEmpty
                                    ? Text(
                                        'Invite other riders',
                                        style: GoogleFonts.robotoFlex(
                                          color: const Color(0xFF4F504F),
                                          fontSize: 20,
                                        ),
                                      )
                                    : SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              ...Provider.of<InviteProvider>(
                                                      context,
                                                      listen: true)
                                                  .selectedContact
                                                  .map(
                                                    (e) => Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 5,
                                                      ),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.grey,
                                                        child: Image.asset(
                                                          'assets/images/create_trip/rider.png',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            ],
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
                        UserHttp.createTrip(CreateTripModal().toJson())
                            .then((value) {
                          showToast(msg: 'Trip created successfully');
                          Future.delayed(const Duration(milliseconds: 100))
                              .then((value) => Navigator.pop(context));
                          Future.delayed(const Duration(milliseconds: 150))
                              .then((value) => Navigator.pop(context));
                          Future.delayed(const Duration(milliseconds: 200))
                              .then((value) => Navigator.pop(context));

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => BikeCubit()..getTrips(),
                                child: const HomeScreen(),
                              ),
                            ),
                          );
                          Provider.of<InviteProvider>(context, listen: false)
                              .selectedContact
                              .clear();
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
                              "CREATE",
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
