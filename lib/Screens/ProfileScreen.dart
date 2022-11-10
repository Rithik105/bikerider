import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom/widgets/Follower.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 420,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.bottomRight,
                  image: const AssetImage('assets/images/homePage/rider.png'),
                  scale: 1.9,
                  opacity: 0.1,
                ),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xffED7E2C),
                      Color(0xffF7B557),
                    ]),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 75,
                      backgroundColor: Color.fromRGBO(233, 176, 129, 1),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.transparent,
                        backgroundImage: const AssetImage(
                            "assets/images/homePage/woman.png"),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text("Ashlesh MD",
                        style: GoogleFonts.roboto(
                            color: const Color(0xffffffff),
                            fontSize: 25,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 15,
                    ),
                    Text("Chase your dreams",
                        style: GoogleFonts.roboto(
                            color: const Color(0xffffffff),
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 15),
                    Container(
                      width: 100,
                      height: 30,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white, width: 1)),
                      child: Center(
                        child: Text(
                          "Follow",
                          style: GoogleFonts.roboto(
                              color: const Color(0xffffffff),
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: 20,
            )
          ],
        ),
        Positioned(
            right: 25,
            top: 30,
            child: Image.asset(
              "assets/images/homePage/edit_pencil.png",
              scale: 2.2,
            )),
        Positioned(
          top: 380,
          left: 10,
          child: Container(
            child: Followers(),
          ),
        ),
      ],
    );
  }
}
