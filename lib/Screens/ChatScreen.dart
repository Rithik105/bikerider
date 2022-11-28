import 'dart:async';
import 'dart:io';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:bikerider/Providers/invite_provider.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../Http/UserHttp.dart';
import '../bloc/BikeCubit.dart';
import '../custom/widgets/ShowToast.dart';
import '../custom/widgets/bubble.dart';
import 'MyProfileScreen.dart';

class ChatScreen extends StatefulWidget {
  String groupId, number, token, groupName;
  // String responseTripId;

  List chatList = [];
  String adminNumber;
  List<ContactDetails> riderDetails;

  ChatScreen({
    Key? key,
    required this.chatList,
    required this.number,
    required this.groupId,
    required this.token,
    required this.groupName,
    required this.adminNumber,
    required this.riderDetails,
    // required this.responseTripId,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController chatListController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  bool _isEmoji = false;
  FocusNode focus = FocusNode();
  Timer? timer1;
  int timerCount = 0;
  File? storeImage;
  FocusNode focusNode = FocusNode();
  bool goDownButtonEnable = true;
  bool once = true;

  @override
  void initState() {
    // widget.riderDetails
    //     .add(ContactDetails(name: 'name', phoneNumber: widget.number));
    // print(widget.chatList);
    // TODO: implement initState
    super.initState();
    timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.chatList.length < 20) {
        setState(() {
          goDownButtonEnable = false;
        });
        // print('length<20');
      }
      // print('pixels' + chatListController.position.pixels.toString());
      timerCount++;
      // print(widget.groupId);
      UserHttp.getChats(widget.groupId, widget.token).then((value) {
        // print('Inside Chats');
        // print(value);
        print('ID validation' + (value['tripId']).toString());
        print('Length' + (value['chatDetails'].length).toString());
        if (value['tripId'] == widget.groupId) {
          print(value['chatDetails']);
          if (widget.chatList.length != value["chatDetails"].length) {
            // print(value["chatDetails"].last);
            List temp = value["chatDetails"];
            widget.chatList =
                temp.map((e) => e['groupId'] == widget.groupId).toList();
            Future.delayed(const Duration(milliseconds: 500)).then(
              (value) => chatListController.animateTo(
                  chatListController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.fastOutSlowIn),
            );
          }

          setState(() {});
          if (once) {
            // print(once);
            Future.delayed(const Duration(milliseconds: 500)).then((value) {
              chatListController.animateTo(
                chatListController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 100),
                curve: Curves.fastOutSlowIn,
              );
              once = false;
              // print(once);
              setState(() {});
            });
          }
        }
      });
    });

    chatListController.addListener(() {
      if (chatListController.position.pixels !=
          chatListController.position.maxScrollExtent) {
        setState(() {
          goDownButtonEnable = true;
        });
      } else {
        setState(() {
          goDownButtonEnable = false;
        });
      }
    });
    focus.addListener(() {
      print('listening');
      if (focus.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500)).then((value) {
          print('has focus');
          chatListController.animateTo(
              chatListController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 10),
              curve: Curves.linear);
        });
      }
    });
  }

  String TimeConverter(String time) {
    DateTime temp = DateTime.parse(time);
    final _utcTime = DateTime.utc(
        temp.year, temp.month, temp.day, temp.hour, temp.minute, temp.second);
    final localTime = _utcTime.toLocal();
    return (localTime.toString().split(' ')[1].split('.')[0]);
  }

  String DateConverter(String time) {
// print(DateTime.parse(time).hour);
    DateTime temp = DateTime.parse(time);
    final _utcTime = DateTime.utc(
        temp.year, temp.month, temp.day, temp.hour, temp.minute, temp.second);
    final localTime = _utcTime.toLocal();
    return (localTime.toString().split(' ')[0].split('-').reversed.join('-'));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer1!.cancel();
    print('Timer disposed');
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: source, preferredCameraDevice: CameraDevice.front);
      if (image == null) {
        return;
      } else {
        final tempImage = File(image.path);

        storeImage = tempImage;
        return tempImage;
      }
    } on PlatformException catch (e) {
      print("failed to pick image : $e");
      showToast(msg: "failed to pick image : $e");
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.groupName,
            style:
                GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: const Color.fromRGBO(240, 148, 85, 1),
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              print(value);
              // if (value == 0) {
              //   //  group info
              // }
              if (value == 1) {
                //  group info
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ...widget.riderDetails.map(
                              (e) {
                                return ListTile(
                                  // leading: CircleAvatar(
                                  //   backgroundImage:
                                  //   NetworkImage(e
                                  //       .profilePic
                                  //       .toString()),
                                  // ),
                                  title: Text(e.name.toString()),
                                  subtitle: Text(e.phoneNumber.toString()),
                                  onTap: () {
                                    // print(e.likedNumber);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) => BikeCubit()
                                            ..getProfile(e.phoneNumber!),
                                          child: const ProfileHeader(),
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
              }
              if (value == 2) {
                //  Notifications
              }
              if (value == 3) {
                if (widget.number == widget.adminNumber) {
                  // showToast(msg: 'Call ClearChat');
                  UserChatImageHttp.clearChats(
                      token: widget.token, groupId: widget.groupId);
                } else {
                  showToast(
                      msg: 'You do not have permission to clear the chat');
                }
              }
            },
            // position: PopupMenuPosition.under,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text(
                  "Group Info",
                  style: TextStyle(
                    color: Color(0xdd4E4E4E),
                  ),
                ),
              ),
              // popupmenu item 2
              const PopupMenuItem(
                value: 2,
                child: Text(
                  "Notifications",
                  style: TextStyle(
                    color: Color(0xdd4E4E4E),
                  ),
                ),
              ),
              const PopupMenuItem(
                value: 3,
                child: Text(
                  "Clear Chat",
                  style: TextStyle(
                    color: Color(0xdd4E4E4E),
                  ),
                ),
              ),
            ],
            color: Colors.white, padding: const EdgeInsets.all(0),
          ),
        ],
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: WillPopScope(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        alignment: Alignment.bottomRight,
                        image: AssetImage(
                          'assets/images/Chat/chat.png',
                        ),
                        scale: 1.7,
                        opacity: 0.05,
                      ),
                    ),
                    child: ListView.builder(
                      controller: chatListController,
                      itemCount: widget.chatList.length,
                      itemBuilder: ((context, index) {
                        if (widget.chatList[index]["memberNumber"] ==
                            widget.number) {
                          //   print(widget.chatList[index]);
                          // print("time is");
                          // print(widget.chatList[index]["time"]);
                          return MessageBubble(
                            isMe: true,
                            time: TimeConverter(widget.chatList[index]["time"]),
                            image: widget.chatList[index]["senderImage"],
                            messageText: widget.chatList[index]["chat"],
                            senderName: widget.chatList[index]["senderName"],
                            isImage: widget.chatList[index]["isImage"],
                            date: DateConverter(
                              widget.chatList[index]["time"],
                            ),
                          );
                        } else {
                          return MessageBubble(
                            isMe: false,
                            time: TimeConverter(widget.chatList[index]["time"]),
                            image: widget.chatList[index]["senderImage"],
                            messageText: widget.chatList[index]["chat"],
                            senderName: widget.chatList[index]["senderName"],
                            isImage: widget.chatList[index]["isImage"],
                            date: DateConverter(widget.chatList[index]["time"]),
                          );
                        }
                      }),
                    ),
                  ),
                ),
                Container(
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
                  margin: const EdgeInsets.only(bottom: 30),
                  height: 50,
                  width: 350,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isEmoji = !_isEmoji;
                            FocusScope.of(context).unfocus();
                            focus.canRequestFocus = true;
                          });
                        },
                        child: const Icon(
                          Icons.emoji_emotions_outlined,
                          color: Color(0xff7F7F7F),
                          size: 32,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 3),
                          child: AutoSizeTextField(
                            focusNode: focusNode,
                            onTap: () {
                              setState(() {
                                _isEmoji = false;
                              });
                            },
                            autofocus: false,
                            controller: _messageController,
                            style: const TextStyle(fontSize: 16),
                            minFontSize: 15,
                            minLines: 1,
                            maxLines: 10,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.photo),
                                      title: const Text('Photo'),
                                      onTap: () {
                                        pickImage(ImageSource.gallery)
                                            .then((storeImage) {
                                          print(storeImage.toString());
                                          if (storeImage == null) {
                                            print("null");
                                          } else {
                                            UserSecureStorage.getToken()
                                                .then((value) {
                                              print(value);
                                              UserChatImageHttp
                                                  .submitSubscription(
                                                      token: value!,
                                                      file: storeImage,
                                                      groupId: widget.groupId);
                                            });
                                          }
                                        });
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.music_note),
                                      title: const Text('Music'),
                                      onTap: () {
                                        //   Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.videocam),
                                      title: const Text('Video'),
                                      onTap: () {
                                        //  Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.share),
                                      title: const Text('Share'),
                                      onTap: () {
                                        // Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading:
                                          const Icon(Icons.file_copy_rounded),
                                      title: const Text('Files'),
                                      onTap: () {
                                        // Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Icon(
                          Icons.attach_file_outlined,
                          color: Color(0xff7F7F7F),
                          size: 32,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_messageController.text != "") {
                            String text = _messageController.text;
                            _messageController.clear();
                            UserSecureStorage.getToken().then((value) {
                              UserHttp.sendChat(
                                      widget.groupId, widget.token, text)
                                  .then((value) {
                                print(value);
                              });
                            });
                            showToast(msg: 'Sending message');
                            focusNode.unfocus();

                            // chatList.add({
                            //   "sender": sender,
                            //   "message": _messageController.text
                            // });
                            // chatListController.animateTo(
                            //     chatListController.position.maxScrollExtent + 100,
                            //     duration: const Duration(seconds: 1),
                            //     curve: Curves.fastOutSlowIn);
                          }
                        },
                        child: const CircleAvatar(
                          backgroundColor: Color(0xffED7F2C),
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
                Visibility(
                  visible: _isEmoji,
                  child: SizedBox(
                    height: 250,
                    child: EmojiPicker(
                      onEmojiSelected: (category, emoji) {},
                      onBackspacePressed: () {
                        // print(_messageController.text.length);
                        _messageController.text = _messageController.text
                            .substring(0, _messageController.text.length - 2);
                      },
                      textEditingController: _messageController,
                      // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                      config: const Config(
                        columns: 7,
                        emojiSizeMax: 32 * 1.0,
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        gridPadding: EdgeInsets.zero,
                        initCategory: Category.SMILEYS,
                        bgColor: Color(0xFFF2F2F2),
                        indicatorColor: Colors.grey,
                        iconColor: Colors.grey,
                        iconColorSelected: Colors.grey,
                        backspaceColor: Colors.grey,
                        skinToneDialogBgColor: Colors.white,
                        skinToneIndicatorColor: Colors.grey,
                        enableSkinTones: true,
                        showRecentsTab: true,
                        recentsLimit: 28,
                        noRecents: Text(
                          'No Recents',
                          style: TextStyle(fontSize: 20, color: Colors.black26),
                          textAlign: TextAlign.center,
                        ),
                        // Needs to be const Widget
                        loadingIndicator: SizedBox.shrink(),
                        // Needs to be const Widget
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            goDownButtonEnable
                ? Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.15,
                    right: 20,
                    child: InkWell(
                      onTap: () {
                        chatListController.animateTo(
                          chatListController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate,
                        );
                      },
                      // backgroundColor: Colors.orangeAccent,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.orangeAccent,
                        ),
                        child: const Icon(
                          Icons.arrow_downward_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        onWillPop: () {
          if (_isEmoji) {
            setState(() {
              _isEmoji = false;
            });
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
      ),
      // floatingActionButton: goDownButtonEnable
      //     ? InkWell(
      //         onTap: () {
      //           chatListController.animateTo(
      //             chatListController.position.maxScrollExtent,
      //             duration: const Duration(milliseconds: 500),
      //             curve: Curves.decelerate,
      //           );
      //         },
      //         // backgroundColor: Colors.orangeAccent,
      //         child: Container(
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(5),
      //             color: Colors.orangeAccent,
      //           ),
      //           child: const Icon(
      //             Icons.arrow_downward_outlined,
      //             color: Colors.white,
      //           ),
      //         ),
      //       )
      //     : null,
    );
  }
}
