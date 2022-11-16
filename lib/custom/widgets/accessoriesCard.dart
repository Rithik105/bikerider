import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AccessoriesCard extends StatefulWidget {
  AccessoriesCard(
      {Key? key,
      required this.category,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.createdDate})
      : super(key: key);
  String productName, category, productImage;
  int productPrice;
  DateTime createdDate;

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
                DateFormat('dd MMM')
                    .format(widget.createdDate)
                    .toString()
                    .toUpperCase(),
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
                child: Image.network(widget.productImage),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.productName,
            style: GoogleFonts.roboto(color: Color(0xff664700), fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Rs${widget.productPrice.toDouble().toString()}",
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
