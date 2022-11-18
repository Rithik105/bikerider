import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentCard extends StatelessWidget {
  final String name;
  final String comment;
  final String profilePic;
  const CommentCard(
      {Key? key,
      required this.name,
      required this.comment,
      required this.profilePic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
      // height: 50,
      width: double.infinity,
      // color: Colors.red,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profilePic),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.robotoFlex(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0x88000000)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  comment,
                  style: GoogleFonts.robotoFlex(fontSize: 16),
                  softWrap: true,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
