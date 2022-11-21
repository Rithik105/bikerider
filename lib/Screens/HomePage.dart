import 'package:bikerider/custom/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'GarageCard.dart';
import 'Intermediate/activityInter.dart';
import 'Intermediate/profileinter.dart';
import 'ServiceRecods/add_bike.dart';
import 'TripCard.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchCardController = TextEditingController();
  // List<BikeListModel> bikeList = [];
  int bottomIndex = 0;
  int previousIndex = 0;
  final _pageOptions = [
    TripCard(),
    GarageCard(),
    ActivityInter(),
    ProfileInter()

    // ActivitiesCard(),
    // ActivityPage(),
    // MyProfilePage(),
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
              // previousIndex = index == 4 ? previousIndex : bottomIndex;

              if (index != 4) {
                bottomIndex = index;
              }
            });
            if (index == 4) {
              print('Call Bottom Sheet');
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_bike_rounded),
              title: const Text('Enter a bike'),
              onTap: () async {
                print('API call');
                // AddBikeHttp.addBikeList().then(
                //   (value) {
                //     print(value);
                //     bikeList.clear();
                //     for (var e in value) {
                //       bikeList.add(BikeListModel.fromJson(e));
                //     }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBike(
                        // bikeList: bikeList,
                        ),
                  ),
                  //     );
                  //   },
                );
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.videocam),
            //   title: const Text('Video'),
            //   onTap: () {
            //     //  Navigator.pop(context);
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.share),
            //   title: const Text('Share'),
            //   onTap: () {
            //     // Navigator.pop(context);
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.file_copy_rounded),
            //   title: const Text('Files'),
            //   onTap: () {
            //     // Navigator.pop(context);
            //   },
            // ),
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
