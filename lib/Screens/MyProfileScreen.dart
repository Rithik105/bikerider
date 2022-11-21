import 'package:bikerider/Models/timeLineModel.dart';
import 'package:bikerider/Screens/milestone_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Http/UserHttp.dart';
import '../bloc/BikeCubit.dart';
import '../custom/widgets/Follower.dart';
import '../custom/widgets/timeLine.dart';
import 'home_screen.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getTimeline().then((value) => print('ProfileHeader GetTimeLine:$value'));
  }

  @override
  Widget build(BuildContext context) {
    print('builds again');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      BlocBuilder<BikeCubit, BikeState>(
                        builder: (context, state) {
                          if (state is BikeFetchingState) {
                            return Container(
                              height: 420,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.bottomRight,
                                  image: AssetImage(
                                      'assets/images/homePage/rider.png'),
                                  scale: 1.9,
                                  opacity: 0.1,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xffED7E2C),
                                    Color(0xffF7B557),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 60),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircleAvatar(
                                      radius: 75,
                                      backgroundColor:
                                          Color.fromRGBO(233, 176, 129, 1),
                                      child: CircleAvatar(
                                        radius: 70,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: AssetImage(
                                            "assets/images/user.png"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text("..",
                                        style: GoogleFonts.roboto(
                                            color: const Color(0xffffffff),
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text("....",
                                        style: GoogleFonts.roboto(
                                            color: const Color(0xffffffff),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 15),
                                    // Container(
                                    //   width: 100,
                                    //   height: 30,
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 6, vertical: 3),
                                    //   decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(15),
                                    //       border: Border.all(
                                    //           color: Colors.white, width: 1)),
                                    //   child: Center(
                                    //     child: Text(
                                    //       "Follow",
                                    //       style: GoogleFonts.roboto(
                                    //           color: const Color(0xffffffff),
                                    //           fontSize: 17,
                                    //           fontWeight: FontWeight.w500),
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if (state is BikeOtherProfileFetchedState) {
                            return Container(
                              height: 420,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.bottomRight,
                                  image: AssetImage(
                                      'assets/images/homePage/rider.png'),
                                  scale: 1.9,
                                  opacity: 0.1,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xffED7E2C),
                                    Color(0xffF7B557),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 60),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 75,
                                      backgroundColor: const Color.fromRGBO(
                                          233, 176, 129, 1),
                                      child: CircleAvatar(
                                        radius: 70,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                            state.profile["userDetails"]
                                                ["profileImage"]),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                        state.profile["userDetails"]
                                            ["userName"],
                                        style: GoogleFonts.roboto(
                                            color: const Color(0xffffffff),
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                        state.profile["userDetails"]
                                            ["aboutUser"],
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Colors.white, width: 1)),
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
                            );
                          } else if (state is BikeMineProfileFetchedState) {
                            return Container(
                              height: 420,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.bottomRight,
                                  image: AssetImage(
                                      'assets/images/homePage/rider.png'),
                                  scale: 1.9,
                                  opacity: 0.1,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xffED7E2C),
                                    Color(0xffF7B557),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 60),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 75,
                                      backgroundColor: const Color.fromRGBO(
                                          233, 176, 129, 1),
                                      child: CircleAvatar(
                                        radius: 70,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                            state.profile["userDetails"]
                                                ["profileImage"]),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                        state.profile["userDetails"]
                                            ["userName"],
                                        style: GoogleFonts.roboto(
                                            color: const Color(0xffffffff),
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                        state.profile["userDetails"]
                                            ["aboutUser"],
                                        style: GoogleFonts.roboto(
                                            color: const Color(0xffffffff),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 15),
                                    // Container(
                                    //   width: 100,
                                    //   height: 30,
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 6, vertical: 3),
                                    //   decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(15),
                                    //       border: Border.all(
                                    //           color: Colors.white, width: 1)),
                                    //   child: Center(
                                    //     child: Text(
                                    //       "Follow",
                                    //       style: GoogleFonts.roboto(
                                    //           color: const Color(0xffffffff),
                                    //           fontSize: 17,
                                    //           fontWeight: FontWeight.w500),
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              height: 420,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.bottomRight,
                                  image: AssetImage(
                                      'assets/images/homePage/rider.png'),
                                  scale: 1.9,
                                  opacity: 0.1,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xffED7E2C),
                                    Color(0xffF7B557),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 60),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircleAvatar(
                                      radius: 75,
                                      backgroundColor:
                                          Color.fromRGBO(233, 176, 129, 1),
                                      child: CircleAvatar(
                                        radius: 70,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: AssetImage(
                                            "assets/images/user.png"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text("..",
                                        style: GoogleFonts.roboto(
                                            color: const Color(0xffffffff),
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text("....",
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Colors.white, width: 1)),
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
                            );
                          }
                        },
                      ),
                      Container(
                        height: 50,
                        width: 20,
                      )
                    ],
                  ),
                  BlocBuilder<BikeCubit, BikeState>(
                    builder: (context, state) {
                      if (state is BikeMineProfileFetchedState) {
                        return Positioned(
                          right: 25,
                          top: 30,
                          child: Image.asset(
                            "assets/images/homePage/edit_pencil.png",
                            scale: 2.2,
                          ),
                        );
                      } else {
                        return Positioned(right: 25, top: 30, child: Text(""));
                      }
                    },
                  ),
                  BlocBuilder<BikeCubit, BikeState>(
                    builder: (context, state) {
                      if (state is BikeMineProfileFetchedState) {
                        return Positioned(
                          top: 380,
                          left: 10,
                          child: Container(
                            child: Followers(
                              rides: Text(
                                state.profile["tripCount"].toString(),
                                style: kProfileNumberText,
                              ),
                              followers: Text(
                                  state.profile['userDetails']["followingCount"]
                                      .toString(),
                                  style: kProfileNumberText),
                              following: Text(
                                state.profile['userDetails']["followersCount"]
                                    .toString(),
                                style: kProfileNumberText,
                              ),
                            ),
                          ),
                        );
                      } else if (state is BikeOtherProfileFetchedState) {
                        return Positioned(
                          top: 380,
                          left: 10,
                          child: Container(
                            child: Followers(
                              rides: Text(
                                state.profile["tripCount"].toString(),
                                style: kProfileNumberText,
                              ),
                              followers: Text(
                                  state.profile['userDetails']["followingCount"]
                                      .toString(),
                                  style: kProfileNumberText),
                              following: Text(
                                state.profile['userDetails']["followersCount"]
                                    .toString(),
                                style: kProfileNumberText,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Positioned(
                          top: 380,
                          left: 10,
                          child: Container(
                            child: Followers(
                              rides: const Text(""),
                              followers: const Text(""),
                              following: const Text(""),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'My Activities',
                  style: GoogleFonts.robotoFlex(
                    color: const Color(0xFF616161),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<BikeCubit, BikeState>(
                builder: (context, state) {
                  if (state is BikeMineProfileFetchedState) {
                    return FutureBuilder(
                      // future: getMyActivities(),
                      future: UserHttp.getTimeline(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          // print(snapshot.data);
                          TimeLineModel? data = snapshot.data;
                          print('length ${data}');
                          return Container(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ...data!.tripList.asMap().entries.map(
                                    (e) {
                                      print(e.value.id);
                                      if (e.key == 0) {
                                        return ProfileTimeline(
                                          center: true,
                                          first: true,
                                          data: e.value,
                                        );
                                      } else {
                                        return Container(
                                          child: ProfileTimeline(
                                            first: false,
                                            data: e.value,
                                            center: false,
                                          ),
                                        );
                                      }
                                    },
                                  ).toList(),
                                ],
                              ),
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  } else
                    return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
