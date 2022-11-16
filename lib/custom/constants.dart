import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

BoxDecoration kLargeSubmitButtonDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffED7E2B), Color(0xffF4A264)]),
    boxShadow: const [
      BoxShadow(
        offset: Offset(
          1,
          1,
        ),
        //  blurStyle: BlurStyle.inner,
        color: Colors.black26,
        blurRadius: 1,
        spreadRadius: 1,
      ),
    ]);
BoxDecoration kNoButtonDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffA29D9D), Color(0xffA29D9D)]),
    boxShadow: const [
      BoxShadow(
        offset: Offset(
          1,
          1,
        ),
        //  blurStyle: BlurStyle.inner,
        color: Colors.black26,
        blurRadius: 1,
        spreadRadius: 1,
      ),
    ]);
TextStyle kLargeSubmitButtonTextDecoration = GoogleFonts.roboto(
  color: Colors.white,
  fontWeight: FontWeight.w500,
  fontSize: 17,
  letterSpacing: 1,
);

BoxDecoration kSplashScreenDecoration = const BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xffED7E2B), Color(0xffF4A264)]),
  image: DecorationImage(
    image: AssetImage("assets/images/splash/splash_bg.png"),
    fit: BoxFit.fill,
  ),
);

BoxDecoration kBottomNavigationBar = const BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffED7F2C), Color(0xffF3A469)]),
    boxShadow: [
      BoxShadow(
        offset: Offset(
          1,
          1,
        ),
        //  blurStyle: BlurStyle.inner,
        color: Colors.black26,
        blurRadius: 1,
        spreadRadius: 1,
      ),
    ]);
BoxDecoration kLargeMapButtonDecoration = const BoxDecoration(
  //borderRadius: BorderRadius.circular(30),
  gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xffF4A264), Color(0xffED7E2B)]),
  boxShadow: [
    BoxShadow(
      offset: Offset(
        1,
        1,
      ),
      //  blurStyle: BlurStyle.inner,
      color: Colors.black26,
      blurRadius: 1,
      spreadRadius: 1,
    ),
  ],
);
BoxDecoration kLargeSubmitButtonDecorationDisabled = BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: const Color(0xffFFCAA1),
    boxShadow: const []);

BoxDecoration kServiceCardTagDecoration = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xcfED7E2B), Color(0xccF4A264)]),
  borderRadius: BorderRadius.only(
      topRight: Radius.circular(10), bottomLeft: Radius.circular(5)),
);
TextStyle kServiceCardTextStyle = GoogleFonts.roboto(
    color: Color.fromRGBO(0, 0, 0, 0.5), fontWeight: FontWeight.w500);

//To display orange color date format for Completed services
TextStyle kServiceRecordCardDateTextStyle = GoogleFonts.roboto(
    color: Color(0xffED7F2C), fontWeight: FontWeight.w900, fontSize: 50);

TextStyle kServiceRecordCardMonthTextStyle = GoogleFonts.roboto(
    color: Color(0xffED7F2C), fontWeight: FontWeight.w600, fontSize: 23);

TextStyle kServiceRecordCardYearTextStyle = GoogleFonts.roboto(
    color: Color(0xffED7F2C), fontWeight: FontWeight.w500, fontSize: 18);


//To display green color date format for Completed services
TextStyle kServicePastRecordCardDateTextStyle = GoogleFonts.roboto(
    color: Color(0xff1CB391), fontWeight: FontWeight.w900, fontSize: 50);

TextStyle kServicePastRecordCardMonthTextStyle = GoogleFonts.roboto(
    color: Color(0xff1CB391), fontWeight: FontWeight.w600, fontSize: 23);

TextStyle kServicePastRecordCardYearTextStyle = GoogleFonts.roboto(
    color: Color(0xff1CB391), fontWeight: FontWeight.w500, fontSize: 18);

TextStyle kServiceRecordCardStarTextStyle = GoogleFonts.roboto(
    color: Color(0x9a000000), fontWeight: FontWeight.normal, fontSize: 15);

BoxDecoration kBookingDetailsTagDecoration = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xcf10B691), Color(0xcc3EE1BC)]),
  borderRadius: BorderRadius.only(
      topRight: Radius.circular(8), bottomLeft: Radius.circular(5)),
);

TextStyle kGeneralTextStyle = GoogleFonts.roboto(
    fontSize: 14, fontWeight: FontWeight.w900, color: Color(0x99000000));

