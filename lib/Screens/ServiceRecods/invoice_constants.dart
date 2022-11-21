import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle kInvoiceLabelTextStyle = GoogleFonts.roboto(
  fontWeight: FontWeight.w600,
  color: Color(0x66000000),
);
TextStyle kItemsTextStyle = GoogleFonts.roboto(
    color: Color(0xdd5B5B5B), fontSize: 16, fontWeight: FontWeight.w700);
TextStyle kTotalTextStyle = GoogleFonts.roboto(
    color: Color(0xffED7F2C), fontWeight: FontWeight.w500, fontSize: 34);
BoxDecoration kInvoiceBoxDecoration = const BoxDecoration(
  borderRadius: BorderRadius.only(
      topRight: Radius.circular(8), topLeft: Radius.circular(8)),
  color: Colors.white,
);

BoxDecoration kInvoiceBackground = const BoxDecoration(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(8), topLeft: Radius.circular(8)),
    color: Colors.transparent,
    boxShadow: [
      BoxShadow(
        offset: Offset(
          1,
          -2.5,
        ),
        color: Colors.black26,
        blurRadius: 6,
        spreadRadius: 1,
      ),
    ]);