import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Screens/GarageCard.dart';
import 'package:bikerider/Screens/Intermediate/activityInter.dart';
import 'package:bikerider/Screens/Intermediate/profileinter.dart';
import 'package:bikerider/Screens/Intermediate/trip_intermediate_card.dart';
import 'package:bikerider/Screens/ServiceRecods/add_bike.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:bikerider/custom/constants.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchCardController = TextEditingController();

  int bottomIndex = 0;
  int previousIndex = 0;
  final _pageOptions = [
    TripintermediateCard(),
    GarageCard(),
    ActivityInter(),
    ProfileInter()
  ];
  void _setLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("loggedIn", false);
    print("loog ${prefs.getBool("loggedIn").toString()}");
  }

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
              if (index != 4) {
                bottomIndex = index;
              }
            });
            if (index == 4) {
              bottomSheetCall(context);
            }
          },
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          selectedIconTheme: const IconThemeData(color: Colors.white),
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
        ),
      ),
    );
  }

  Future<dynamic> bottomSheetCall(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Navigator.pop(context);
                showToast(msg: 'Please wait while we log you out');
                UserSecureStorage.getToken().then((value1) {
                  UserHttp.userLogOut(value1!).then((value2) {
                    print('response' + value2.toString());
                    UserSecureStorage.clear();
                    showToast(msg: value2["message"]);
                    _setLogin();

                    Navigator.pushNamedAndRemoveUntil(context, "/LoginScreen",
                        ModalRoute.withName("/LoginScreen"));
                    // Future.delayed(Duration(milliseconds: 150)).then((value) =>
                    //     Navigator.pushReplacementNamed(
                    //         context, "/LoginScreen"));
                    // showToast(msg: 'Logged out successfully');
                  });
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_bike_rounded),
              title: const Text('Enter a bike'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBike(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

TextStyle kProfileNumberText = GoogleFonts.roboto(
    color: const Color(0xffEE8431), fontSize: 25, fontWeight: FontWeight.w600);

TextStyle kProfileTitleTextStyle = GoogleFonts.roboto(
    color: const Color(0x79000000), fontSize: 16, fontWeight: FontWeight.w600);
