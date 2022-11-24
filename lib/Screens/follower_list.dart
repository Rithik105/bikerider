import 'package:bikerider/Screens/MyProfileScreen.dart';
import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowerList extends StatefulWidget {
  FollowerList({super.key, required this.followerList});
  List followerList;

  @override
  State<FollowerList> createState() => _FollowerListState();
}

class _FollowerListState extends State<FollowerList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: widget.followerList == []
          ? Container()
          : ListView.builder(
              itemCount: widget.followerList.length,
              itemBuilder: (context, index) {
                print(widget.followerList);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.followerList[index]["followerImage"] ??
                          "https://www.pngitem.com/pimgs/m/146-1468843_profile-icon-orange-png-transparent-png.png",
                    ),
                  ),
                  title: Text(widget.followerList[index]["followerName"]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => BikeCubit()
                            ..getProfile(
                                widget.followerList[index]["followerPhone"]),
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
