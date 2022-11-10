// import 'package:bikerider/custom/widgets/button.dart';
// import 'package:flutter/Material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class GetStartedScreen extends StatelessWidget {
//   GetStartedScreen({super.key, required this.storeImage});
//   File storeImage;

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           Container(
//             padding: EdgeInsets.only(right: 20, top: 10),
//             child: GestureDetector(
//               child: const Text(
//                 '',
//                 style: TextStyle(
//                     color: Color(0xfff2944E),
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500),
//               ),
//               onTap: () {},
//             ),
//           )
//         ],
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Container(
//         child: Stack(
//           children: [
//             Positioned(
//                 top: 50,
//                 left: 0,
//                 right: 0,
//                 child: (Image.file(
//                   storeImage,
//                   fit: BoxFit.contain,
//                   scale: 2.4,
//                 ))),
//             Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       "assets/images/chooseavatar/profile01.png",
//                       scale: 2.4,
//                     ),
//                     Container(
//                       color: Colors.white,
//                       height: 0,
//                     ),
//                     Container(
//                       width: 400,
//                       height: 300,
//                       color: Colors.white,
//                       child: Column(children: [
//                         const Text(
//                           "Awesome",
//                           style:
//                               TextStyle(fontSize: 25, color: Color(0xff4F504F)),
//                         ),
//                         const Text("Lets move on and make some",
//                             style: TextStyle(
//                                 fontSize: 18, color: Color(0xff4F504F))),
//                         const Text(" crazy trips.",
//                             style: TextStyle(
//                                 fontSize: 18, color: Color(0xff4F504F))),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         LargeSubmitButton(
//                             text: "LETS GET STARTED",
//                             ontap: () {
//                               Navigator.pushNamed(context, "/HomePage");
//                             })
//                       ]),
//                     )
//                   ],
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
// Image.file(File(storeImage!.path),scale: 3,)

import 'package:bikerider/custom/widgets/button.dart';
import 'package:flutter/Material.dart';
import 'dart:io';

class MyWidget extends StatelessWidget {
  MyWidget({super.key, required this.storeImage});
  File storeImage;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GetStartedScreen extends StatelessWidget {
  GetStartedScreen({super.key, required this.storeImage});
  File storeImage;

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
            SizedBox(
              height: 10,
            ),
            const Text("Lets move on and make some",
                style: TextStyle(fontSize: 18, color: Color(0xff4F504F))),
            const Text(" crazy trips.",
                style: TextStyle(fontSize: 18, color: Color(0xff4F504F))),
            SizedBox(
              height: 30,
            ),
            LargeSubmitButton(
                text: "LETS GET STARTED",
                ontap: () {
                  Navigator.pushNamed(context, "/HomeScreen");
                })
          ]),
        ]),
      ),
    );
  }
}
