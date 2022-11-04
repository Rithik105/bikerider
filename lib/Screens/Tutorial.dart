import 'package:bikerider/custom/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Tutorial extends StatefulWidget {
  Tutorial({super.key});

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  final _pageController = PageController();

  int pagenumber = 0;
  String text = "Skip";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10, top: 10),
              child: GestureDetector(
                onTap: () {
                  _pageController.animateToPage(2,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.linear);
                },
                child: Text(
                  text,
                  style: GoogleFonts.roboto(
                      color: Color(0XFFF2944E),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
          backgroundColor: Color.fromARGB(255, 250, 250, 250),
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.only(bottom: 50),
          child: PageView(
            onPageChanged: (value) {
              if (value == 2)
                text = "";
              else
                text = "Skip";
              setState(() {});
            },
            controller: _pageController,
            children: [
              Container(
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                      "assets/images/tutorial/page1.png",
                      height: 350,
                    )),
                    Text(
                      "Ride Free",
                      style: GoogleFonts.roboto(
                        color: Color(0XFF585858),
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Create a hassle free ride ",
                      style: GoogleFonts.roboto(
                          color: Color(0XFF717171), fontSize: 17),
                    ),
                    Text(
                      "anytime and anywhere ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: Color(0XFF717171), fontSize: 17),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                      "assets/images/tutorial/page2.png",
                      height: 350,
                    )),
                    Text(
                      "Know your Bike",
                      style: GoogleFonts.roboto(
                        color: Color(0XFF585858),
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Keep your bike fettle! ",
                      style: GoogleFonts.roboto(
                          color: Color(0XFF717171), fontSize: 17),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                      "assets/images/tutorial/page3.png",
                      height: 350,
                    )),
                    Text(
                      "Your Cart",
                      style: GoogleFonts.roboto(
                        color: Color(0XFF585858),
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Book bike online and shop ",
                      style: GoogleFonts.roboto(
                          color: Color(0XFF717171), fontSize: 17),
                    ),
                    Text(
                      "accessories",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: Color(0XFF717171), fontSize: 17),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 35),
                      child: LargeSubmitButton(
                        text: "REGISTER",
                        ontap: () {
                          Navigator.pushNamed(context, "/OwnBikeScreen");
                        },
                        width: 320,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomSheet: Container(
          height: 80,
          child: Center(
            child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: ScaleEffect(
                  dotWidth: 10,
                  dotHeight: 10,
                  dotColor: Color(0XFFF7931E),
                  activeDotColor: Color(0XFFF7931E),
                )),
          ),
        ));
  }
}
//  Navigator.pushNamed(context, "/OwnBikeScreen");

