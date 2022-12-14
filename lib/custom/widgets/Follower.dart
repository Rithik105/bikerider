import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Screens/home_screen.dart';

class Followers extends StatelessWidget {
  Widget rides, following, followers;

  Followers(
      {Key? key,
      required this.followers,
      required this.following,
      required this.rides})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        width: MediaQuery.of(context).size.width - 20,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(
                0,
                4,
              ),
              blurRadius: 6.0,
              spreadRadius: 4.0,
            ), //BoxShadow
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Rides", style: kProfileTitleTextStyle),
                SizedBox(
                  height: 2,
                ),
                rides
              ],
            ),
            Container(
              height: 60,
              width: 1.5,
              color: Color(0x2f979797),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Followers",
                  style: kProfileTitleTextStyle,
                ),
                SizedBox(
                  height: 2,
                ),
                followers
                // Text(
                //   "16",
                //   style: kProfileNumberText,
                // )
              ],
            ),
            Container(
              height: 60,
              width: 1.5,
              color: Color(0x2f979797),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Following",
                  style: kProfileTitleTextStyle,
                ),
                SizedBox(
                  height: 2,
                ),
                following
                // Text("5", style: kProfileNumberText),
              ],
            ),
          ],
        ));
  }
}
