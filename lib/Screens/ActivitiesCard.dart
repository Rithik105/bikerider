import 'package:bikerider/Models/get_trip_model.dart';
import 'package:bikerider/Screens/trip_summary_go.dart';
import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom/widgets/CustomCard.dart';
import '../custom/widgets/button.dart';
import 'create_trip.dart';

class ActivityCard extends StatelessWidget {
  ActivityCard({Key? key}) : super(key: key);

  TextEditingController searchCardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BikeCubit, BikeState>(builder: (context, state) {
      if (state is BikeFetchingState) {
        return Center(
          child: const CircularProgressIndicator(
            color: Colors.orange,
          ),
        );
      } else if (state is BikeNonEmptyTripState) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Column(
            children: [
              Material(
                elevation: 2.0,
                shadowColor: Color.fromRGBO(194, 188, 188, 0.5),
                child: TextField(
                  controller: searchCardController,
                  decoration: InputDecoration(
                    labelText: "Search a trip",
                    labelStyle: GoogleFonts.roboto(
                        color: Color.fromRGBO(166, 166, 166, 0.87),
                        fontSize: 14),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(194, 188, 188, 0.5))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Colors.white, width: 4.0)),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: Color(0xff989898),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: state.getTripModel.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      print(state.getTripModel[index].tripName!);
                      return GestureDetector(
                        onTap: () {
                          print(
                              'milestone length${state.getTripModel[index].milestones.length}');
                          print(state.getTripModel[index].milestones);

                          print(index);
                          print(state.getTripModel[index].source);
                          Navigator.pushNamed(context, '/TripSummaryGo',
                              arguments: {
                                "getTripModel": state.getTripModel[index]
                              });
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: ((context) => TripSummaryGo(
                          //             getTripModel:
                          //                 state.getTripModel[index]))));
                        },
                        child: CustomCard(
                          url: state.getTripModel[index].url!,
                          id: state.getTripModel[index].id!,
                          tripName: state.getTripModel[index].tripName!,
                          startDate: state.getTripModel[index].startDate!,
                          ontap: () {},
                        ),
                      );
                    }),
              ),
            ],
          ).paddingAll(20, 20, 60, 20)),
        );
      } else {
        return SafeArea(
          child: Column(
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
                        fontSize: 28, color: Color(0xff4F504F)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "You are not a part of any trips at",
                    style: GoogleFonts.robotoFlex(
                        fontSize: 20, color: Color(0xff4F504F)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "this moment",
                    style: GoogleFonts.robotoFlex(
                        fontSize: 20, color: Color(0xff4F504F)),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ).paddingAll(40, 40, 40, 40)
            ],
          ),
        );
      }
    });
  }
}
