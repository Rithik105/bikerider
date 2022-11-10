import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccessoriesCard extends StatefulWidget {
  const AccessoriesCard({Key? key}) : super(key: key);

  @override
  State<AccessoriesCard> createState() => _AccessoriesCardState();
}

class _AccessoriesCardState extends State<AccessoriesCard> {
  bool _isSlelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "22 SEp",
                style: GoogleFonts.roboto(color: Color(0x99664700)),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isSlelected = !_isSlelected;
                  });
                },
                icon: Icon(
                  _isSlelected
                      ? Icons.thumb_up_alt
                      : Icons.thumb_up_alt_outlined,
                  color: Color(0x99664700),
                ),
              )
            ],
          ),
          SizedBox(
            height: 0,
          ),
          SizedBox(
            width: double.infinity,
            child: SizedBox(
              height: 100,
              width: 80,
              child: Center(
                child: Image.asset("assets/images/Temp/gloves.png"),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Probiker Glovs",
            style: GoogleFonts.roboto(color: Color(0xff664700), fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Rs 189.00",
            style: TextStyle(
                color: Color(0xffED802E),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
