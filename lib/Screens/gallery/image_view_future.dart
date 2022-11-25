import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:bikerider/Http/photoHttp.dart';
import 'package:bikerider/Screens/gallery/gallery_model.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../../bloc/BikeCubit.dart';
import '../MyProfileScreen.dart';
import 'comment_card.dart';
import 'galary_constants.dart';

class ImageViewFuture extends StatefulWidget {
  // ImageDetails imageDetails;
  String token;
  String id;

  ImageViewFuture({
    // required this.imageDetails,
    required this.token,
    required this.id,
  });

  @override
  State<ImageViewFuture> createState() => _ImageViewFutureState();
}

class _ImageViewFutureState extends State<ImageViewFuture> {
  ImageDetails? imageDetails;
  bool view = false;
  bool _isDisabled = false;
  final ScrollController _controller = ScrollController();

  void imageDownload() async {
    String? url = imageDetails!.photos?.imageUrl;
    print('here');
    await GallerySaver.saveImage(url!);
  }

  // _scrollListener() {
  //   if (_controller.offset >= _controller.position.maxScrollExtent &&
  //       !_controller.position.outOfRange) {
  //     showToast(msg: "reach the bottom");
  //   }
  //   if (_controller.offset <= _controller.position.minScrollExtent &&
  //       !_controller.position.outOfRange) {
  //     showToast(msg: "reach the top");
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller.addListener(_scrollListener);
    PhotosHttp.getPhotoDetails(widget.id, widget.token).then((value2) {
      // ImageDetails temp = value2;
      // print(value);
      imageDetails = value2;
      setState(() {
        view = true;
      });
    });
    commentNode.addListener(() {
      if (commentNode.hasFocus) {
        _controller.animateTo(_controller.position.maxScrollExtent,
            duration: const Duration(milliseconds: 250),
            curve: Curves.fastOutSlowIn);
        print('..');
      }
    });
  }

  FocusNode commentNode = FocusNode();
  final TextEditingController _messageController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            'Gallery',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0x58000000),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                onPressed: () async {
                  showToast(msg: "Downloading....");
                  imageDownload();
                },
                icon: const Icon(
                  Icons.download_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(
              Icons.share,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: !view
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                // color: Colors.white,
                child: Stack(
                  children: [
                    Container(
                      // height: MediaQuery.of(context).size.height - 125,
                      child: SingleChildScrollView(
                        controller: _controller,
                        child: Column(
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.6,
                              ),
                              child: Container(
                                color: Colors.grey.shade200,
                                // height: 400,
                                child: Image.network(
                                  imageDetails!.photos?.imageUrl as String,
                                  // fit: BoxFit.contain,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Container(
                              // /alignment: Alignment.bottomRight,
                              margin: const EdgeInsets.only(top: 10),
                              width: double.infinity,
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      commentNode.unfocus();
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ...imageDetails!
                                                      .photos!.likedBy!
                                                      .map(
                                                    (e) {
                                                      return ListTile(
                                                        leading: CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                            e.likedProfilePic
                                                                .toString(),
                                                          ),
                                                        ),
                                                        title: Text(e.likedName
                                                            .toString()),
                                                        onTap: () {
                                                          print(e.likedNumber);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  BlocProvider(
                                                                create: (context) =>
                                                                    BikeCubit()
                                                                      ..getProfile(
                                                                          e.likedNumber!),
                                                                child:
                                                                    const ProfileHeader(),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 20,
                                      height: 20,
                                      child: Text(
                                          "${imageDetails!.photos?.likeCount}"),
                                    ),
                                  ),
                                  IgnorePointer(
                                    ignoring: _isDisabled,
                                    child: IconButton(
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {
                                          _isDisabled = true;
                                          setState(() {});

                                          showToast(msg: "Loading....");
                                          PhotosHttp.addLike(
                                                  imageDetails!.photos!.imageId
                                                      .toString(),
                                                  widget.token)
                                              .then((value) {
                                            PhotosHttp.getPhotoDetails(
                                                    imageDetails!
                                                        .photos!.imageId!,
                                                    widget.token)
                                                .then((value) {
                                              imageDetails = value;
                                              _isDisabled = false;

                                              setState(() {});
                                            });
                                            // if (widget.imageDetails.liked) {
                                            //   setState(() {
                                            //     widget.imageDetails.photos!
                                            //         .likeCount--;
                                            //     widget.imageDetails.liked =
                                            //         false;
                                            //   });
                                            // } else {
                                            //   setState(() {
                                            //     widget.imageDetails.photos!
                                            //         .likeCount++;
                                            //     widget.imageDetails.liked =
                                            //         true;
                                            //   });
                                            // }
                                          });
                                        },
                                        icon: imageDetails!.liked
                                            ? kLikedIconStyle
                                            : kDefaultIconStyle),
                                  ),
                                  const SizedBox(
                                    width: 0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      commentNode.unfocus();
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ...imageDetails!
                                                      .distinctComment
                                                      .map(
                                                    (e) {
                                                      return ListTile(
                                                        leading: CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(e
                                                                  .profilePic
                                                                  .toString()),
                                                        ),
                                                        title: Text(
                                                            e.name.toString()),
                                                        onTap: () {
                                                          // print(e.likedNumber);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  BlocProvider(
                                                                create: (context) =>
                                                                    BikeCubit()
                                                                      ..getProfile(
                                                                          e.number!),
                                                                child:
                                                                    const ProfileHeader(),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      alignment: Alignment.center,
                                      child: Text(
                                          "${imageDetails!.photos?.commentCount}"),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 0,
                                  ),
                                  IconButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {
                                      _controller.animateTo(
                                          _controller.position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 100),
                                          curve: Curves.fastOutSlowIn);
                                      // commentNode.requestFocus();
                                      Future.delayed(
                                        const Duration(milliseconds: 50),
                                      ).then((value) {
                                        commentNode.requestFocus();
                                      });
                                      Future.delayed(
                                        const Duration(milliseconds: 800),
                                      ).then((value) {
                                        print('works');
                                        _controller.animateTo(
                                          _controller.position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 100),
                                          curve: Curves.fastOutSlowIn,
                                        );
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.insert_comment_outlined,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                            ),
                            ...imageDetails!.photos!.commentData!.map(
                              (e) {
                                return CommentCard(
                                  comment: e.commented!,
                                  name: e.commentedBy!,
                                  profilePic: e.commentUserPic.toString(),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              offset: const Offset(
                                0,
                                0,
                              ),
                              blurRadius: 5.0,
                              spreadRadius: 2.0,
                            ), //BoxShadow
                          ],
                        ),
                        margin: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        // height: 50,
                        // width: 350,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.emoji_emotions_outlined,
                              color: Color(0xff7F7F7F),
                              size: 32,
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 3),
                                child: AutoSizeTextField(
                                  onTap: () {},
                                  autofocus: false,
                                  focusNode: commentNode,
                                  controller: _messageController,
                                  style: const TextStyle(fontSize: 16),
                                  minFontSize: 15,
                                  minLines: 1,
                                  maxLines: 10,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_messageController.text.isNotEmpty) {
                                    UserSecureStorage.getToken().then((value) {
                                      PhotosHttp.addComment(
                                              imageDetails!.photos!.imageId
                                                  .toString(),
                                              _messageController.text
                                                  .toString(),
                                              value!)
                                          .then(
                                        (value) {
                                          PhotosHttp.getPhotoDetails(
                                                  widget.id, widget.token)
                                              .then((value2) {
                                            // ImageDetails temp = value2;
                                            // print(value);
                                            imageDetails = value2;
                                            setState(() {
                                              view = true;
                                            });
                                          });
                                          _messageController.clear();
                                          commentNode.unfocus();
                                        },
                                      );
                                    });
                                    // _controller.position.
                                  }
                                });
                              },
                              child: const CircleAvatar(
                                backgroundColor: Color(
                                  0xffED7F2C,
                                ),
                                radius: 22,
                                child: Center(
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
