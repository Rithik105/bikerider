import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:bikerider/Http/photoHttp.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'comment_card.dart';
import 'galary_constants.dart';
import 'gallery_model.dart';

class ImageView extends StatefulWidget {
  ImageDetails imageDetails;
  ImageView({required this.imageDetails});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  void imageDownload() async {
    String? url = widget.imageDetails.photos?.imageUrl;
    print('here');
    await GallerySaver.saveImage(url!);
  }

  FocusNode commentNode = FocusNode();
  TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                //color: Colors.red,
                height: MediaQuery.of(context).size.height - 125,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        // color: Colors.red,
                        height: 400,
                        width: double.infinity,
                        child: Image.network(
                          widget.imageDetails.photos?.imageUrl as String,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        // /alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        height: 30,
                        // color: Colors.red,
                        // color: Colors.green
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
                                            ...widget
                                                .imageDetails.photos!.likedBy!
                                                .map(
                                              (e) {
                                                return ListTile(
                                                  leading: CircleAvatar(),
                                                  title: Text(
                                                      e.likedName.toString()),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Text(
                                  "${widget.imageDetails.photos?.likeCount}"),
                            ),
                            IconButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(
                                    () {
                                      UserSecureStorage.getToken()
                                          .then((value) {
                                        PhotosHttp.addLike(
                                            widget.imageDetails.photos!.imageId
                                                .toString(),
                                            value!);
                                        if (widget.imageDetails.liked) {
                                          widget
                                              .imageDetails.photos!.likeCount--;
                                          widget.imageDetails.liked = false;
                                        } else {
                                          widget
                                              .imageDetails.photos!.likeCount++;
                                          widget.imageDetails.liked = true;
                                        }
                                      });
                                    },
                                  );
                                },
                                icon: widget.imageDetails.liked
                                    ? kLikedIconStyle
                                    : kDefaultIconStyle),
                            SizedBox(
                              width: 10,
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
                                              ...widget.imageDetails.photos!
                                                  .commentData!
                                                  .map(
                                                (e) {
                                                  return ListTile(
                                                    leading: CircleAvatar(),
                                                    title: Text(e.commentedBy
                                                        .toString()),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                    "${widget.imageDetails.photos?.commentCount}")),
                            SizedBox(
                              width: 0,
                            ),
                            IconButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                commentNode.requestFocus();
                              },
                              icon: Icon(
                                Icons.insert_comment_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                      ...widget.imageDetails.photos!.commentData!.map((e) {
                        return CommentCard(
                          comment: e.commented!,
                          name: e.commentedBy!,
                          profilePic:
                              'https://images.unsplash.com/photo-1550853418-bb4348ff6a80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Z2lybCUyMHdpdGglMjBib29rfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Color(0x88000000),
                height: 75,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 190,
                      child: Text(
                        "Gallery",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: 50,
                      child: IconButton(
                        onPressed: () async {
                          imageDownload();
                        },
                        icon: Icon(
                          Icons.download_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      child: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    )
                  ],
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
                  margin: EdgeInsets.only(
                    bottom: 10,
                  ),
                  height: 50,
                  width: 350,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.emoji_emotions_outlined,
                        color: Color(0xff7F7F7F),
                        size: 32,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 3),
                          child: AutoSizeTextField(
                            onTap: () {},
                            autofocus: false,
                            focusNode: commentNode,
                            controller: _messageController,
                            style: TextStyle(fontSize: 16),
                            minFontSize: 15,
                            minLines: 1,
                            maxLines: 10,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_messageController.text != null) {
                              UserSecureStorage.getToken().then((value) {
                                PhotosHttp.addComment(
                                        widget.imageDetails.photos!.imageId
                                            .toString(),
                                        _messageController.text.toString(),
                                        value!)
                                    .then(
                                  (value) => {
                                    _messageController.clear(),
                                    commentNode.unfocus()
                                  },
                                );
                              });
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
