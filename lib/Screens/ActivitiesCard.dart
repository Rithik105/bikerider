import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Providers/Data.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../custom/widgets/CustomCard.dart';
import '../custom/widgets/button.dart';

class ActivitiesCard extends StatefulWidget {
  ActivitiesCard({Key? key}) : super(key: key);

  @override
  State<ActivitiesCard> createState() => _ActivitiesCardState();
}

class _ActivitiesCardState extends State<ActivitiesCard> {
  List trips = [];
  TextEditingController searchCardController = TextEditingController();
  var _isInIt = true;

  @override
  void didChangeDependencies() {
    if (_isInIt) {
      UserHttp.getTrips(Provider.of<UserData>(context, listen: false).token!)
          .then((value) {
        setState(() {
          trips = value;
          _isInIt = false;
          print(trips);
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return trips == []
        ? Scaffold(
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
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: trips.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return CustomCard(
                          text: "Ankitha",
                          ontap: () {},
                        );
                      }),
                ),
              ],
            ).paddingAll(20, 20, 60, 20)),
            floatingActionButton: FloatingActionButton(
              elevation: 0,
              focusElevation: 0,
              disabledElevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {},
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              child: Image.asset(
                "assets/images/homePage/add_tripIcon.png",
                width: double.infinity,
              ),
            ),
          )
        : SafeArea(
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
                      "You do not have any trips at",
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
                    SizedBox(
                        width: double.infinity,
                        child: LargeSubmitButton(
                            text: "CREATE A TRIP", ontap: () {}))
                  ],
                ).paddingAll(40, 40, 40, 40)
              ],
            ),
          );
  }
}
