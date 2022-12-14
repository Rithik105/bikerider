import 'package:bikerider/Screens/tripSummaryComplete.dart';
import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:bikerider/custom/widgets/CustomCard.dart';
import 'package:bikerider/custom/widgets/button.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utility/Secure_storeage.dart';

class TripCard extends StatefulWidget {
  TripCard({Key? key}) : super(key: key);

  @override
  State<TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  final TextEditingController searchCardController = TextEditingController();
  String? myMobile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserSecureStorage.getDetails(key: 'mobile').then(
      (value) {
        myMobile = value;
        print('myMobile' + myMobile.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BikeCubit, BikeState>(builder: (context, state) {
      if (state is BikeFetchingState) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.orange,
          ),
        );
      } else if (state is BikeNoTripResultState) {
        return Column(
          children: [
            Material(
              elevation: 2.0,
              shadowColor: const Color.fromRGBO(194, 188, 188, 0.5),
              child: TextField(
                onSubmitted: (value) {
                  BlocProvider.of<BikeCubit>(context).searchTrip(value);
                },
                controller: searchCardController,
                decoration: InputDecoration(
                  labelText: "Search a trip",
                  labelStyle: GoogleFonts.roboto(
                      color: const Color.fromRGBO(166, 166, 166, 0.87),
                      fontSize: 14),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(194, 188, 188, 0.5))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 4.0)),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 30,
                    color: Color(0xff989898),
                  ),
                ),
              ),
            ).paddingAll(20, 20, 60, 20),
            Text("Search result empty",
                style: GoogleFonts.robotoFlex(
                    fontSize: 15, color: const Color(0xff4F504F)))
          ],
        );
      } else if (state is BikeNonEmptyTripState) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Column(
            children: [
              Material(
                elevation: 2.0,
                shadowColor: const Color.fromRGBO(194, 188, 188, 0.5),
                child: TextField(
                  onSubmitted: (value) {
                    BlocProvider.of<BikeCubit>(context).searchTrip(value);
                  },
                  controller: searchCardController,
                  decoration: InputDecoration(
                    labelText: "Search a trip",
                    labelStyle: GoogleFonts.roboto(
                        color: const Color.fromRGBO(166, 166, 166, 0.87),
                        fontSize: 14),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(194, 188, 188, 0.5))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 4.0)),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30,
                      color: Color(0xff989898),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<BikeCubit>(context).getTrips();
                },
                child: Container(
                  padding:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? EdgeInsets.only(bottom: 0)
                          : EdgeInsets.only(bottom: 90),
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: state.getTripModel.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (state.getTripModel[index].tripStatus ==
                                'upcoming') {
                              Navigator.pushNamed(context, '/TripSummaryGo',
                                  arguments: {
                                    "getTripModel": state.getTripModel[index]
                                  });
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TripSummaryComplete(
                                    getTripModel: state.getTripModel[index],
                                  ),
                                ),
                              );
                            }
                          },
                          child: CustomCard(
                            mobile: state.getTripModel[index].mobile,
                            myMobile: state.myMobile,
                            tripStatus: state.getTripModel[index].tripStatus,
                            id: state.getTripModel[index].id!,
                            tripName: state.getTripModel[index].tripName!,
                            startDate: state.getTripModel[index].startDate!,
                            url: state.getTripModel[index].url,
                            ontap: () {},
                          ),
                        );
                      }),
                ),
              ),
            ],
          ).paddingAll(20, 20, 60, 20)),
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            focusElevation: 0,
            disabledElevation: 0,
            splashColor: Colors.transparent,
            onPressed: () {
              Navigator.pushNamed(context, "/CreateTrip");
            },
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            child: Image.asset(
              "assets/images/homePage/add_tripIcon.png",
              width: double.infinity,
            ),
          ),
        );
      } else {
        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<BikeCubit>(context).getTrips();
              },
              child: ListView(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset("assets/images/homePage/empty_card.png"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome Aboard",
                        style: GoogleFonts.robotoFlex(
                            fontSize: 28, color: const Color(0xff4F504F)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "You do not have any trips at this moment",
                          style: GoogleFonts.robotoFlex(
                              fontSize: 20, color: const Color(0xff4F504F)),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: LargeSubmitButton(
                              text: "CREATE A TRIP",
                              ontap: () {
                                Navigator.pushNamed(context, "/CreateTrip");
                              }))
                    ],
                  ).paddingAll(40, 40, 40, 40)
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
