import 'package:bikerider/Screens/MyProfileScreen.dart';
import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowingList extends StatefulWidget {
  FollowingList({super.key, required this.followingList});
  List followingList;

  @override
  State<FollowingList> createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: widget.followingList == []
          ? Container()
          : ListView.builder(
              itemCount: widget.followingList.length,
              itemBuilder: (context, index) {
                print(widget.followingList);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.followingList[index]["followingImage"] ??
                          "https://www.pngitem.com/pimgs/m/146-1468843_profile-icon-orange-png-transparent-png.png",
                    ),
                  ),
                  title: Text(widget.followingList[index]["followingName"]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => BikeCubit()
                            ..getProfile(
                                widget.followingList[index]["followingPhone"]),
                          child: const ProfileHeader(),
                        ),
                      ),
                    );
                  },
                );
              }),
    );
  }
}
