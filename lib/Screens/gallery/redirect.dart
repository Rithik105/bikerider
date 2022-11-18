// import 'package:flutter/material.dart';
// import 'package:galary/services.dart';
// import 'package:galary/stagger.dart';

// class Redirect extends StatelessWidget {
//   const Redirect({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ElevatedButton(
//           onPressed: () {
//             GetPhotos.getPhotos().then((value) => {
//                   //  print(value),
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Stagger(
//                         photos: value,
//                       ),
//                     ),
//                   ),
//                 });
//           },
//           child: Center(child: Text("go"))),
//     );
//   }
// }
