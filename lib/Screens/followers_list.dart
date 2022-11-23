import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FollowerList extends StatefulWidget {
  FollowerList({super.key,required this.followersList});
  List followersList;

  @override
  State<FollowerList> createState() => _FollowerListState();
}

class _FollowerListState extends State<FollowerList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(itemCount: widget.followersList.length, itemBuilder: (context,index){
      return ListTile(leading: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      e.likedProfilePic
                                                          .toString(),
                                                    ),
                                                  ),
                                                  title: Text(
                                                      e.likedName.toString()),
                                                  onTap: () {
                                                    print(e.likedNumber);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            BlocProvider(
                                                          create: (context) =>
                                                              BikeCubit()
                                                                ..getProfile(e
                                                                    .likedNumber!),
                                                          child:
                                                              ProfileHeader(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
    }),)
  }
}