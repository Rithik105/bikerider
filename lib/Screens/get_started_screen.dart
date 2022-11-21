import 'dart:io';

import 'package:flutter/Material.dart';

import 'package:bikerider/custom/widgets/button.dart';

// ignore: must_be_immutable
class GetStartedScreen extends StatelessWidget {
  GetStartedScreen({super.key, required this.storeImage});
  File storeImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black54,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/chooseavatar/BGBUBBLE.JPEG",
                  fit: BoxFit.fill,
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.35,
                  top: 80,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.transparent,
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(500),
                            child: Image.file(
                              storeImage,
                              fit: BoxFit.fitWidth,
                              height: 500,
                              width: 500,
                            )),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: SizedBox(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  "assets/images/chooseavatar/tick.png",
                                )))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(children: [
            const Text(
              "Awesome",
              style: TextStyle(fontSize: 25, color: Color(0xff4F504F)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Lets move on and make some",
                style: TextStyle(fontSize: 18, color: Color(0xff4F504F))),
            const Text(" crazy trips.",
                style: TextStyle(fontSize: 18, color: Color(0xff4F504F))),
            const SizedBox(
              height: 30,
            ),
            LargeSubmitButton(
                text: "LETS GET STARTED",
                ontap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/HomeScreen");
                })
          ]),
        ]),
      ),
    );
  }
}
