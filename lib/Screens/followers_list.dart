// import 'package:bikerider/bloc/BikeCubit.dart';
// import 'package:flutter/Material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class FollowerList extends StatefulWidget {
//   FollowerList({super.key,required this.followersList});
//   List followersList;

//   @override
//   State<FollowerList> createState() => _FollowerListState();
// }

// class _FollowerListState extends State<FollowerList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: ListView.builder(itemCount: widget.followersList.length, itemBuilder: (context,index){
//       return ListTile(leading: CircleAvatar(backgroundImage:
//                                                         NetworkImage(
//                                                      widget.followersList["imageUrl"],
//                                                     ),
//                                                   ),
//                                                   title: Text(
//                                                     widget.followersList["imageUrl"]),
//                                                   onTap: () {
//                                                     Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             BlocProvider(
//                                                           create: (context) =>
//                                                               BikeCubit()
//                                                                 ..getProfile(widget.followersList[]),
//                                                           child:
//                                                               ProfileHeader(),
//                                                         ),
//                                                       ),
//                                                     );
//                                                   },
//                                                 );
//     }),)
//   }
// }