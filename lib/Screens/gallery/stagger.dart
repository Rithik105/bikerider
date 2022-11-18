// import 'package:bikerider/Utility/Secure_storeage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'Image_view.dart';
// import 'gallery_model.dart';
// import '../../Http/photoHttp.dart';

// class Stagger extends StatefulWidget {
//   List<dynamic> photos;
//   Stagger({required this.photos});

//   @override
//   State<Stagger> createState() => _StaggerState();
// }

// class _StaggerState extends State<Stagger> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(12),
//       child: MasonryGridView.builder(
//         itemCount: widget.photos.length,
//         crossAxisSpacing: 8,
//         mainAxisSpacing: 8,
//         gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//         ),
//         itemBuilder: (context, index) {
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(10.0),
//             child: GestureDetector(
//                 onTap: () {
//                   UserSecureStorage.getToken().then((value) {
//                     PhotosHttp.getPhotoDetails(
//                             widget.photos[index]["_id"], value!)
//                         .then((value) {
//                       ImageDetails temp = ImageDetails.fromJson(value);
//                       print(value);
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ImageView(imageDetails: temp),
//                         ),
//                       );
//                     });
//                   });
//                 },
//                 child: Image.network("${widget.photos[index]["imageUrl"]}")),
//           );
//         },
//       ),
//     );
//   }
// }
// //
// // Widget masanorylayout(BuildContext context) {
// //   return MasonryGridView.builder(
// //     crossAxisSpacing: 8,
// //     mainAxisSpacing: 8,
// //     gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
// //       crossAxisCount: 2,
// //     ),
// //     itemBuilder: (context, index) {
// //       return ClipRRect(
// //         borderRadius: BorderRadius.circular(10.0),
// //         child: GestureDetector(
// //             onTap: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (context) => ImageView()),
// //               );
// //             },
// //             child:
// //                 Image.network("https://source.unsplash.com/random/sig=$index")),
// //       );
// //     },
// //   );
// // }

// // Widget customGrid(BuildContext context) {
// //   return GridView.custom(
// //     // itemCount: 10,
// //     gridDelegate: SliverWovenGridDelegate.count(
// //       crossAxisCount: 2,
// //       mainAxisSpacing: 0,
// //       crossAxisSpacing: 0,
// //       pattern: [
// //         WovenGridTile(1),
// //         WovenGridTile(
// //           5 / 9,
// //           crossAxisRatio: 1,
// //           alignment: AlignmentDirectional.centerEnd,
// //         ),
// //       ],
// //     ),
// //     childrenDelegate: SliverChildBuilderDelegate(
// //       (context, index) => ClipRRect(
// //         borderRadius: BorderRadius.circular(10.0),
// //         child: Image.network("https://source.unsplash.com/random/sig=$index"),
// //       ),
// //     ),
// //   );
// // }
