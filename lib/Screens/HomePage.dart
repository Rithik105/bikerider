import 'package:bikerider/Screens/ActivitiesCard.dart';
import 'package:bikerider/custom/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/BikeCubit.dart';
import 'GarageCard.dart';
import 'ProfileScreen.dart';
import 'TripCard.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchCardController = TextEditingController();

  int bottomIndex = 0;
  final _pageOptions = [
    BlocProvider(
      create: (context) => BikeCubit()..getTrips(),
      child: TripCard(),
    ),
    GarageCard(),
    // ActivitiesCard(),
    ProfileHeader()
    // ActivityPage(),
    // MyProfilePage(),
    // More()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[bottomIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
          height: 65,
          width: double.infinity,
          decoration: kBottomNavigationBar,
          child: BottomNavigationBar(
            selectedItemColor: Colors.white,
            currentIndex: bottomIndex,
            onTap: (index) {
              setState(() {
                bottomIndex = index;
              });
              print(bottomIndex);
            },
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(color: Colors.white),
            items: [
              BottomNavigationBarItem(
                label: 'Trips',
                icon: bottomIndex == 0
                    ? Image.asset(
                        "assets/images/homePage/bottom_navigation/bike.png",
                        color: Colors.white,
                        width: 40,
                      )
                    : Image.asset(
                        "assets/images/homePage/bottom_navigation/bike.png",
                        color: Colors.white.withOpacity(0.4),
                        width: 40,
                      ),
              ),
              BottomNavigationBarItem(
                label: 'My Garage',
                icon: bottomIndex == 1
                    ? Image.asset(
                        "assets/images/homePage/bottom_navigation/wrench.png",
                        color: Colors.white,
                        width: 30,
                      )
                    : Image.asset(
                        "assets/images/homePage/bottom_navigation/wrench.png",
                        color: Colors.white.withOpacity(0.4),
                        width: 30,
                      ),
              ),
              BottomNavigationBarItem(
                label: 'Activities',
                icon: bottomIndex == 2
                    ? Image.asset(
                        "assets/images/homePage/bottom_navigation/list.png",
                        color: Colors.white,
                        width: 30)
                    : Image.asset(
                        "assets/images/homePage/bottom_navigation/list.png",
                        color: Colors.white.withOpacity(0.4),
                        width: 30),
              ),
              BottomNavigationBarItem(
                label: 'My Profile',
                icon: bottomIndex == 3
                    ? Image.asset(
                        "assets/images/homePage/bottom_navigation/user.png",
                        width: 25)
                    : Image.asset(
                        "assets/images/homePage/bottom_navigation/user.png",
                        width: 25,
                        color: Colors.white.withOpacity(0.4),
                      ),
              ),
              BottomNavigationBarItem(
                label: 'More',
                icon: bottomIndex == 4
                    ? Image.asset(
                        "assets/images/homePage/bottom_navigation/more.png",
                        width: 30,
                        color: Colors.white,
                      )
                    : Image.asset(
                        "assets/images/homePage/bottom_navigation/more.png",
                        width: 30,
                      ),
              ),
            ],
          )),
    );
  }
}

TextStyle kProfileNumberText = GoogleFonts.roboto(
    color: Color(0xffEE8431), fontSize: 25, fontWeight: FontWeight.w600);

TextStyle kProfileTitleTextStyle = GoogleFonts.roboto(
    color: Color(0x79000000), fontSize: 16, fontWeight: FontWeight.w600);
