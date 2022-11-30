import 'dart:io';

import 'package:bikerider/Models/activityModel.dart';
import 'package:bikerider/Models/timeLineModel.dart';
import 'package:bikerider/Screens/follower_list.dart';
import 'package:bikerider/Screens/following_list.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../Http/UserHttp.dart';
// import '../Models/activityModel.dart';
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
  TextEditingController _editingController1 = TextEditingController();
  TextEditingController _editingController2 = TextEditingController();
  File? storeImage;
  bool newImage = false;
  bool _clicked = false;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: source, preferredCameraDevice: CameraDevice.front);
      if (image == null)
        return;
      else {
        final tempImage = File(image.path);

        this.storeImage = tempImage;
        return tempImage;
      }
    } on PlatformException catch (e) {
      print("failed to pick image : $e");
    }
    ;
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
                                    IgnorePointer(
                                      ignoring: _clicked,
                                      child: GestureDetector(
                                        onTap: () {
                                          _clicked = true;

                                          setState(() {});
                                          showToast(
                                              msg: state.following
                                                  ? "Unfollowing..."
                                                  : "Following..");
                                          UserSecureStorage.getToken()
                                              .then((value) {
                                            UserHttp.followUser(
                                                    state.number, value!)
                                                .then((value) {
                                              _clicked = false;
                                              setState(() {});
                                              BlocProvider.of<BikeCubit>(
                                                      context)
                                                  .getProfile(state.number);
                                            });
                                          });
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 30,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1)),
                                          child: Center(
                                            child: Text(
                                              state.following
                                                  ? "Following"
                                                  : "Follow",
                                              style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xffffffff),
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
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
                                        backgroundImage: NetworkImage(state
                                                    .profile["userDetails"]
                                                ["profileImage"] ??
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7-d5qr9WzS926jiHDPlYrCL01Eb0M8C8c4w&usqp=CAU"),
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
                          } else if (state is BikeMineProfileEditState) {
                            _editingController1.text =
                                state.profile["userDetails"]["userName"];
                            _editingController2.text =
                                state.profile["userDetails"]["aboutUser"];

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
                                      child: GestureDetector(
                                        onTap: () {
                                          pickImage(ImageSource.gallery)
                                              .then((value) {
                                            if (value == null) {
                                              newImage = false;
                                              setState(() {});
                                            } else {
                                              newImage = true;
                                              storeImage = value;
                                              setState(() {});
                                            }
                                          });
                                        },
                                        child: CircleAvatar(
                                            radius: 70,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: storeImage == null
                                                ? NetworkImage((state.profile[
                                                            "userDetails"]
                                                        ["profileImage"] ??
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7-d5qr9WzS926jiHDPlYrCL01Eb0M8C8c4w&usqp=CAU"))
                                                : FileImage(storeImage!)
                                                    as ImageProvider),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: TextField(
                                          controller: _editingController1,
                                          style: GoogleFonts.roboto(
                                              color: const Color(0xffffffff),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: TextField(
                                          controller: _editingController2,
                                          style: GoogleFonts.roboto(
                                              color: const Color(0xffffffff),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    ),
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
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<BikeCubit>(context).emit(
                                  BikeMineProfileEditState(
                                      profile: state.profile));
                            },
                            child: Image.asset(
                              "assets/images/homePage/edit_pencil.png",
                              scale: 2.2,
                            ),
                          ),
                        );
                      } else if (state is BikeMineProfileEditState) {
                        return Positioned(
                          right: 25,
                          top: 30,
                          child: IconButton(
                            icon: const Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (newImage) {
                                UserSecureStorage.getToken().then((value) {
                                  UserProfileEditHttp.editImage(
                                          file: storeImage!, token: value!)
                                      .then((value2) {
                                    UserProfileEditHttp.editInfo(
                                            name: _editingController1.text,
                                            aboutUser: _editingController2.text,
                                            token: value)
                                        .then((value3) {
                                      BlocProvider.of<BikeCubit>(context)
                                          .getMyProfile();
                                    });
                                  });
                                });
                              } else {
                                UserSecureStorage.getToken().then((value) {
                                  UserProfileEditHttp.editInfo(
                                          name: _editingController1.text,
                                          aboutUser: _editingController2.text,
                                          token: value!)
                                      .then((value) {
                                    BlocProvider.of<BikeCubit>(context)
                                        .getMyProfile();
                                  });
                                });
                              }
                            },
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
                              followers: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return FollowerList(
                                        followerList:
                                            state.profile["userDetails"]
                                                    ["followers"] ??
                                                0);
                                  }));
                                },
                                child: Text(
                                    state.profile['userDetails']
                                            ["followersCount"]
                                        .toString(),
                                    style: kProfileNumberText),
                              ),
                              following: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return FollowingList(
                                        followingList:
                                            state.profile["userDetails"]
                                                ["following"]);
                                  }));
                                },
                                child: Text(
                                  state.profile['userDetails']["followingCount"]
                                      .toString(),
                                  style: kProfileNumberText,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (state is BikeMineProfileEditState) {
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
                          print("snap data ${snapshot.data}");
                          TimeLineModel? data = snapshot.data;
// <<<<<<< phaneesh_1
                          if (data == null || data.tripList.isEmpty) {
                            print(" data is $data");
                            return Container(
                              child: Center(
                                child: Text('No Timeline Exist'),
// =======
//                           print('length ${data}');
//                           return Container(
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 children: [
//                                   ...data!.tripList.asMap().entries.map(
//                                     (e) {
//                                       print(e.value.id);
//                                       if (e.key == 0) {
//                                         return ProfileTimeline(
//                                           center: true,
//                                           first: true,
//                                           data: e.value,
//                                         );
//                                       } else {
//                                         return Container(
//                                           child: ProfileTimeline(
//                                             first: false,
//                                             data: e.value,
//                                             center: false,
//                                           ),
//                                         );
//                                       }
//                                     },
//                                   ).toList(),
//                                 ],
// >>>>>>> vishwa_1
                              ),
                            );
                          } else {
                            print('length ${data}');
                            return Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ...data.tripList.asMap().entries.map(
                                      (e) {
                                        ActivityModel temp = e.value;
                                        print(e.value.id);
                                        if (e.value.isLast) {
                                          print(e.value.isLast);
                                          return ProfileTimeline(
                                            center: true,
                                            first: data.tripList.length == 1
                                                ? true
                                                : false,
                                            last: true,
                                            data: temp,
                                          );
                                        } else if (e.key == 0) {
                                          return ProfileTimeline(
                                            center: true,
                                            first: true,
                                            data: temp,
                                          );
                                        } else {
                                          return Container(
                                            child: ProfileTimeline(
                                              first: false,
                                              data: temp,
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
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
