import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
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
      required this.createdDate,
      required this.productLike,
      required this.productId})
      : super(key: key);
  String productName, category, productImage, productId;
  int productPrice;
  bool productLike;
  DateTime createdDate;

  @override
  State<AccessoriesCard> createState() => _AccessoriesCardState();
}

class _AccessoriesCardState extends State<AccessoriesCard> {
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
                  widget.productLike = !widget.productLike;
                  UserSecureStorage.getToken().then((value) {
                    UserHttp.accLike(
                        widget.productId, widget.productLike, value!);
                  });
                  setState(() {});
                },
                icon: Icon(
                  widget.productLike
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
            style: GoogleFonts.roboto(color: Color(0xff664700), fontSize: 12),
          ),
          SizedBox(
            height: 0,
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
