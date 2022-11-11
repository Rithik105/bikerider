import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Providers/Data.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import "package:http/http.dart" as http;

import '../Models/UserModel.dart';

class ChooseAvatarScreen extends StatelessWidget {
  @override
  File? storeImage;
  ChooseAvatarScreen({Key? key}) : super(key: key);

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20, top: 10),
            child: GestureDetector(
              child: const Text(
                'Skip',
                style: TextStyle(
                    color: Color(0xfff2944E),
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {},
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/chooseavatar/default_profile.png",
                      scale: 2.4,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Hey Ashlesh!!",
                      style: TextStyle(fontSize: 25, color: Color(0xff4F504F)),
                    ),
                    const Text("to make it more cool selct",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff4F504F))),
                    const Text("your avatar.",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff4F504F))),
                  ],
                )),
            Positioned(
                bottom: 0,
                child: Container(
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
                              child: Container(
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
                                          color: const Color(0xfff2944E),
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                pickImage(ImageSource.gallery)
                                    .then((storeImage) {
                                  print(storeImage.toString());
                                  if (storeImage == null) {
                                    print("null");
                                    Navigator.pushNamed(
                                        context, "/GetStartedScreen",
                                        arguments: {"storeImage": storeImage});
                                  } else {
                                    UserSecureStorage.getToken().then((value) {
                                      print(value);
                                      UserImageHttp.submitSubscription(
                                              file: storeImage)
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
                          }),
                          Container(
                            width: 1,
                            height: 174,
                            color: const Color.fromRGBO(0, 0, 0, 0.1),
                          ),
                          Consumer<UserData>(builder:
                              (BuildContext context, value, Widget? child) {
                            return GestureDetector(
                              child: Container(
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
                                          color: Color(0xfff2944E),
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                pickImage(ImageSource.camera)
                                    .then((storeImage) {
                                  print(storeImage.toString());
                                  if (storeImage == null) {
                                    print("null");
                                    Navigator.pushNamed(
                                        context, "/GetStartedScreen",
                                        arguments: {"storeImage": storeImage});
                                  } else {
                                    UserSecureStorage.getToken().then((value) {
                                      print(value);
                                      UserImageHttp.submitSubscription(
                                              file: storeImage)
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
      ),
    );
  }
}

// Image.file(File(storeImage!.path),scale: 3,)