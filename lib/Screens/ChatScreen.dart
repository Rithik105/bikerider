import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom/widgets/bubble.dart';

<<<<<<< HEAD
class ChatScreen extends StatefulWidget {
  String groupId, number, token;

  List chatList;
  ChatScreen(
      {Key? key,
      required this.chatList,
      required this.number,
      required this.groupId,
      required this.token})
      : super(key: key);
=======
class NewChatScreen extends StatefulWidget {
  const NewChatScreen({Key? key}) : super(key: key);
>>>>>>> 8e56a7c9c01a3e9b48106d03ccd8a1e042534f2c

  @override
  State<NewChatScreen> createState() => _NewChatScreenState();
}

<<<<<<< HEAD
class _ChatScreenState extends State<ChatScreen> {
  ScrollController chatListController = ScrollController();
=======
class _NewChatScreenState extends State<NewChatScreen> {
  ScrollController chatListController = ScrollController();
  String sender = 'esikiel';
  List<Map<String, String>> chatList = [
    {"sender": "esikiel", "message": "whats your name"},
    {"sender": "tony", "message": "whaaaat!!"},
    {"sender": "esikiel", "message": "what is your name"},
    {"sender": "tony", "message": "tony"},
  ];
>>>>>>> 8e56a7c9c01a3e9b48106d03ccd8a1e042534f2c
  TextEditingController _messageController = TextEditingController();
  bool _isEmoji = false;
  FocusNode focus = FocusNode();
  Timer? timer;

  @override
  void initState() {
<<<<<<< HEAD
    print("i ${widget.chatList}");
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 10), (timer) {
      updateChat();
    });
  }

  void updateChat() async {
    widget.chatList = await UserHttp.getChats(widget.groupId, widget.token);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
=======
    // TODO: implement initState
    super.initState();
    // timer = Timer.periodic(Duration(seconds: 10), (timer) {
    //   UserHttp.getChats().then((value) {
    //     chatList = value;
    //   });
    // });
    // UserHttp.getChats().then((value) {
    //   chatList = value;
    // });
    // UserHttp.getNumber().then((value) {
    //   sender = value;
    // });
  }

  @override
  void dispose() {
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();
>>>>>>> 8e56a7c9c01a3e9b48106d03ccd8a1e042534f2c
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Reunion Manali",
            style:
                GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: Color.fromRGBO(240, 148, 85, 1),
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              print(value);
            },
            // position: PopupMenuPosition.under,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text(
                  "Group Info",
                  style: TextStyle(
                    color: Color(0xdd4E4E4E),
                  ),
                ),
              ),
              // popupmenu item 2
              PopupMenuItem(
                value: 2,
                child: Text(
                  "Notifications",
                  style: TextStyle(
                    color: Color(0xdd4E4E4E),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Text(
                  "Clear Chat",
                  style: TextStyle(
                    color: Color(0xdd4E4E4E),
                  ),
                ),
              ),
            ],
            color: Colors.white, padding: EdgeInsets.all(0),
          ),
        ],
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: WillPopScope(
        child: Column(
          children: [
            Expanded(
              child: Container(
<<<<<<< HEAD
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      alignment: Alignment.bottomRight,
                      image: AssetImage(
                        'assets/images/Chat/chat.png',
                      ),
                      scale: 1.7,
                      opacity: 0.05,
=======
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    alignment: Alignment.bottomRight,
                    image: AssetImage(
                      'images/chat.png',
>>>>>>> 8e56a7c9c01a3e9b48106d03ccd8a1e042534f2c
                    ),
                  ),
<<<<<<< HEAD
                  child: ListView.builder(
                      controller: chatListController,
                      itemCount: widget.chatList.length,
                      itemBuilder: ((context, index) {
                        if (widget.chatList[index]["senderNum"] ==
                            widget.number) {
                          print(widget.number);
                          return MessageBubble(
                              isMe: true,
                              messageText: widget.chatList[index]["message"]!,
                              senderName: widget.chatList[index]["sender"]!);
                        } else {
                          return MessageBubble(
                              isMe: false,
                              messageText: widget.chatList[index]["message"]!,
                              senderName: widget.chatList[index]["sender"]!);
                        }
                      }))),
=======
                ),
                child: ListView.builder(
                    controller: chatListController,
                    itemCount: chatList.length,
                    itemBuilder: ((context, index) {
                      if (chatList[index]["sender"] == sender) {
                        return MessageBubble(
                            isMe: true,
                            messageText: chatList[index]["message"]!,
                            senderName: chatList[index]["sender"]!);
                      } else {
                        return MessageBubble(
                            isMe: false,
                            messageText: chatList[index]["message"]!,
                            senderName: chatList[index]["sender"]!);
                      }
                    })),
              ),
>>>>>>> 8e56a7c9c01a3e9b48106d03ccd8a1e042534f2c
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
              margin: EdgeInsets.only(bottom: 30),
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
                    child: Icon(
                      Icons.emoji_emotions_outlined,
                      color: Color(0xff7F7F7F),
                      size: 32,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 3),
                      child: AutoSizeTextField(
                        onTap: () {
                          setState(() {
                            _isEmoji = false;
                          });
                        },
                        autofocus: false,
                        controller: _messageController,
                        style: TextStyle(fontSize: 16),
                        minFontSize: 15,
                        minLines: 1,
                        maxLines: 10,
                        decoration: InputDecoration(border: InputBorder.none),
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
                                  leading: new Icon(Icons.photo),
                                  title: new Text('Photo'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: new Icon(Icons.music_note),
                                  title: new Text('Music'),
                                  onTap: () {
                                    //   Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: new Icon(Icons.videocam),
                                  title: new Text('Video'),
                                  onTap: () {
                                    //  Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: new Icon(Icons.share),
                                  title: new Text('Share'),
                                  onTap: () {
                                    // Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: new Icon(Icons.file_copy_rounded),
                                  title: new Text('Files'),
                                  onTap: () {
                                    // Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Icon(
                      Icons.attach_file_outlined,
                      color: Color(0xff7F7F7F),
                      size: 32,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_messageController.text != "") {
                        chatList.add({
                          "sender": sender,
                          "message": _messageController.text
                        });
                        chatListController.animateTo(
                            chatListController.position.maxScrollExtent + 100,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn);
                        setState(() {});
                        _messageController.clear();
                      }
                    },
                    child: CircleAvatar(
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
                  textEditingController:
                      _messageController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
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
                    ), // Needs to be const Widget
                    loadingIndicator:
                        SizedBox.shrink(), // Needs to be const Widget
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL,
                  ),
                ),
              ),
            ),
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
    );
  }
}
