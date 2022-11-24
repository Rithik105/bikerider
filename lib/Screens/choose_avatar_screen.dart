import 'dart:io';

import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Providers/Data.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';

// ignore: must_be_immutable
class ChooseAvatarScreen extends StatelessWidget {
  File? storeImage;
  String name;
  ChooseAvatarScreen({Key? key, required this.name}) : super(key: key);

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/user.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: source, preferredCameraDevice: CameraDevice.front);
      if (image == null) {
        return;
      } else {
        final tempImage = File(image.path);

        storeImage = tempImage;
        return tempImage;
      }
      // ignore: empty_catches
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: GestureDetector(
              child: const Text(
                'Skip',
                style: TextStyle(
                    color: Color(0xfff2944E),
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () async {
                await getImageFileFromAssets("images/user.png").then((value) {
                  Navigator.pushNamed(context, "/GetStartedScreen",
                      arguments: {"storeImage": value});
                });
              },
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Image.asset(
                    "assets/images/chooseavatar/default_profile.png",
                    scale: 2.4,
                  ),
                  onTap: () {
                    pickImage(ImageSource.camera).then((storeImage) {
                      if (storeImage == null) {
                        getImageFileFromAssets("images/user.png").then((value) {
                          Navigator.pushNamed(context, "/GetStartedScreen",
                              arguments: {"storeImage": value});
                        });
                      } else {
                        UserSecureStorage.getToken().then((value) {
                          UserImageHttp.submitSubscription(
                                  token: value!, file: storeImage)
                              .then((value) {
                            Navigator.pushNamed(context, "/GetStartedScreen",
                                arguments: {"storeImage": storeImage});
                          });
                        });
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Hey $name !!",
                  style:
                      const TextStyle(fontSize: 25, color: Color(0xff4F504F)),
                ),
                const Text("to make it more cool selct",
                    style: TextStyle(fontSize: 18, color: Color(0xff4F504F))),
                const Text("your avatar.",
                    style: TextStyle(fontSize: 18, color: Color(0xff4F504F))),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: SizedBox(
                width: 400,
                height: 175,
                child: Column(
                  children: [
                    Container(
                        width: 400,
                        height: 1,
                        color: const Color.fromRGBO(0, 0, 0, 0.1)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Consumer<UserData>(builder:
                            (BuildContext context, value1, Widget? child) {
                          return GestureDetector(
                            child: Column(
                              children: [
                                Image.asset(
                                    "assets/images/chooseavatar/galary.png"),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Gallery",
                                  style: TextStyle(
                                      color: Color(0xfff2944E), fontSize: 16),
                                )
                              ],
                            ),
                            onTap: () {
                              pickImage(ImageSource.gallery).then((storeImage) {
                                if (storeImage == null) {
                                  getImageFileFromAssets("images/user.png")
                                      .then((value) {
                                    Navigator.pushNamed(
                                        context, "/GetStartedScreen",
                                        arguments: {"storeImage": value});
                                  });
                                } else {
                                  UserSecureStorage.getToken().then((value) {
                                    UserSecureStorage.getToken().then((value) {
                                      UserImageHttp.submitSubscription(
                                              token: value!, file: storeImage)
                                          .then((value) {
                                        Navigator.pushNamed(
                                            context, "/GetStartedScreen",
                                            arguments: {
                                              "storeImage": storeImage
                                            });
                                      });
                                    });
                                  });
                                }
                              });
                            },
                          );
                        }),
                        Container(
                          width: 1,
                          height: 174,
                          color: const Color.fromRGBO(0, 0, 0, 0.1),
                        ),
                        Consumer<UserData>(builder:
                            (BuildContext context, value, Widget? child) {
                          return GestureDetector(
                            child: Column(
                              children: [
                                Image.asset(
                                    "assets/images/chooseavatar/camara.png"),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Take photo",
                                  style: TextStyle(
                                      color: Color(0xfff2944E), fontSize: 16),
                                )
                              ],
                            ),
                            onTap: () {
                              pickImage(ImageSource.camera).then((storeImage) {
                                if (storeImage == null) {
                                  getImageFileFromAssets("images/user.png")
                                      .then((value) {
                                    Navigator.pushNamed(
                                        context, "/GetStartedScreen",
                                        arguments: {"storeImage": value});
                                  });
                                } else {
                                  UserSecureStorage.getToken().then((value) {
                                    UserImageHttp.submitSubscription(
                                            token: value!, file: storeImage)
                                        .then((value) {
                                      Navigator.pushNamed(
                                          context, "/GetStartedScreen",
                                          arguments: {
                                            "storeImage": storeImage
                                          });
                                    });
                                  });
                                }
                              });
                            },
                          );
                        })
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// Image.file(File(storeImage!.path),scale: 3,)
