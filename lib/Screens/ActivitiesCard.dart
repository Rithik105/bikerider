import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utility/Secure_storeage.dart';
import '../custom/widgets/CustomCard.dart';

class ActivityCard extends StatefulWidget {
  ActivityCard({Key? key}) : super(key: key);

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  TextEditingController searchCardController = TextEditingController();
  String? myMobile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserSecureStorage.getDetails(key: 'mobile').then(
      (value) => myMobile = value,
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
                  BlocProvider.of<BikeCubit>(context).searchTripDetails(value);
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
                    BlocProvider.of<BikeCubit>(context)
                        .searchTripDetails(value);
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
                  BlocProvider.of<BikeCubit>(context).getTripDetails();
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
                            // data: state.getTripModel,
                            url: state.getTripModel[index].url,
                            id: state.getTripModel[index].id!,
                            tripName: state.getTripModel[index].tripName!,
                            startDate: state.getTripModel[index].startDate!,
                            mobile: state.getTripModel[index].mobile,
                            tripStatus: state.getTripModel[index].tripStatus,
                            myMobile: state.myMobile,
                            ontap: () {},
                          ),
                        );
                      }),
                ),
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
              RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<BikeCubit>(context).getTripDetails();
                  },
                  child: ListView(
                    children: [
                      Text(
                        "Welcome Aboard",
                        style: GoogleFonts.robotoFlex(
                            fontSize: 28, color: const Color(0xff4F504F)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Text(
                          "You are not a part of any trips at this moment",
                          style: GoogleFonts.robotoFlex(
                              fontSize: 20, color: const Color(0xff4F504F)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   "this moment",
                      //   style: GoogleFonts.robotoFlex(
                      //       fontSize: 20, color: const Color(0xff4F504F)),
                      // ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ).paddingAll(40, 40, 40, 40))
            ],
          ),
        );
      }
    });
  }
}
