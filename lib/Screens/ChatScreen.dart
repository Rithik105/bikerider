import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  bool _isEmoji = false;
  FocusNode focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.more_vert_outlined),
            ),
          )
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
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    alignment: Alignment.bottomRight,
                    image: AssetImage(
                      'images/chat.png',
                    ),
                    scale: 1.7,
                    opacity: 0.07,
                  ),
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
                        // focusNode:,
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
                    onTap: () {},
                    child: Icon(
                      Icons.attach_file_outlined,
                      color: Color(0xff7F7F7F),
                      size: 32,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _messageController.clear();
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
