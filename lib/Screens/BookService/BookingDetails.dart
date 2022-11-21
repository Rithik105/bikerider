import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../Http/BookService.dart';
import '../../Models/book_service_model.dart';
import '../../custom/widgets/button.dart';
import '../SuccessPage.dart';

class ConfirmBookingDetails extends StatefulWidget {
   ConfirmBookingDetails({Key? key,required this.dealerPhone}) : super(key: key);
   final String dealerPhone;

  @override
  State<ConfirmBookingDetails> createState() => _ConfirmBookingDetailsState();
}

class _ConfirmBookingDetailsState extends State<ConfirmBookingDetails> {
  Map details = BookServiceModel.toJson();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFFED863A),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Booking Details',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600,
                fontSize: 22.5,
              ),
            ),
            GestureDetector(
                onTap: () {
                  print(details);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...BookServiceModel.toList().entries.toList().map((e) {
              if (e.key == 'Comments') {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      e.key,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff4F504F),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      e.value,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: const Color(0xff4F504F),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color(0xffB4B3B3),
                    ),
                  ],
                );
              } else if (e.key == 'Slot Date') {
                return Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          e.key,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff4F504F),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(":"),
                      Container(
                        width: 170,
                        alignment: Alignment.centerRight,
                        child: Text(
                         e.value ==null?'': DateFormat('dd MMM yyyy').format(e.value),
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: const Color(0xff4F504F),
                          ),
                        ),
                      ),
                    ]),
                    const Divider(
                      thickness: 1,
                      color: Color(0xffB4B3B3),
                    ),
                  ],
                );
              } else {
                return Column(children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          e.key,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff4F504F),
                          ),
                        ),
                      ),
                      Text(":"),
                      Expanded(
                        child: Container(
                          width: 130,
                          alignment: Alignment.centerRight,
                          child: Text(
                            e.value,
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: Color(0xff4F504F),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color(0xffB4B3B3),
                  ),
                ]);
              }
            }),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: LargeSubmitButton(
                text: "BOOK",
                ontap: () {
                  BookServiceHttp.uploadBookingDetails(widget.dealerPhone!).then(
                    (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SuccessPage(
                                title: "Your booking has been confirmed",
                                nextScreen: '',
                              ),
                        ),
                      );
                      Future.delayed(Duration(milliseconds: 250)).then((value) {
                        BookServiceModel.clearBookingDetails();
                        setState(() {

                        });
                      });
                    }
                  );
                },
              ),
            ),
          ],
        ).paddingAll(30, 30, 20, 20),
      ),
    );
  }


}
