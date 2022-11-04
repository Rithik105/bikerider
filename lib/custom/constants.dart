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
