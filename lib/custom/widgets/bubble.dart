import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {required this.isMe,
      required this.messageText,
      required this.senderName,
      required this.image,
      required this.date,
      required this.time});
  String messageText;
  String time;
  String date;
  String senderName, image;
  bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Visibility(
                  visible: isMe,
                  child: Column(
                    children: [
                      Icon(
                        Icons.done_rounded,
                        size: 13,
                        color: Colors.green,
                      ),
                      Text(
                        time,
                        style:
                            TextStyle(fontSize: 13, color: Color(0x99000000)),
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 8,
                          color: Color(0x99000000),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !isMe,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0x44ffaa10),
                  foregroundImage: NetworkImage(image),
                  // backgroundImage: NetworkImage(profileUrl),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Material(
                borderRadius: isMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                elevation: 5,

                color:
                    !isMe ? const Color(0xffADADAD) : const Color(0xff4EB5F4),

                child: Container(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.62,
                      minWidth: 1,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child: Text(
                      "$messageText",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 7),
                child: Visibility(
                  visible: !isMe,
                  child: Column(
                    children: [
                      Icon(
                        Icons.done_rounded,
                        size: 13,
                        color: Color(0x99000000),
                      ),
                      Text(
                        time,
                        style:
                            TextStyle(fontSize: 13, color: Color(0x99000000)),
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 8,
                          color: Color(0x99000000),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Visibility(
            visible: !isMe,
            child: Text(
              "$senderName",
              style: GoogleFonts.roboto(color: const Color(0xff7F7F7F)),
            ),
          ),
        ],
      ),
    );
  }
}
