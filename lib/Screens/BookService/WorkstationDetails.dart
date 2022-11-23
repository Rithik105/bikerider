import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../Models/book_service_model.dart';
import '../../Models/workstation_model.dart';
import '../../custom/widgets/button.dart';
import 'BookingDetails.dart';

class DealerDetails extends StatefulWidget {
  DealerDetails({Key? key, required this.dealerDetailsList}) : super(key: key);
  late final WorkstationModel dealerDetailsList;

  @override
  State<DealerDetails> createState() => _DealerDetailsState();
}

class _DealerDetailsState extends State<DealerDetails> {
  @override
  IconData? _selectedIcon;
  final bool _isVertical = false;
  TextEditingController dateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.red,
              height: 250,
              width: double.infinity,
              child: Image.network(
                widget.dealerDetailsList.dealerImage!,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Stack(
                children: [
                  Positioned(
                      top: 50,
                      right: 10,
                      child: Text("4km",
                          style: GoogleFonts.roboto(
                              color: Color(0x99000000), fontSize: 14))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingBarIndicator(
                        rating:
                            widget.dealerDetailsList.dealerRating!.ceilToDouble(),
                        itemBuilder: (context, index) => Icon(
                          _selectedIcon ?? Icons.star,
                          color: Color(0xffF3DA3B),
                        ),
                        itemCount: 5,
                        itemSize: 24.0,
                        unratedColor: Color(0xffd3d3d3),
                        direction:
                            _isVertical ? Axis.vertical : Axis.horizontal,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.dealerDetailsList.dealerName!,
                        style: GoogleFonts.roboto(
                            color: Color(0xffED7F2C),
                            fontWeight: FontWeight.w500,
                            fontSize: 22),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          widget.dealerDetailsList.dealerAddress!,
                          style: GoogleFonts.roboto(
                              color: Color(0x99000000), fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.dealerDetailsList.dealerDescription!,
                        style: GoogleFonts.roboto(
                            color: Color(0x99000000), fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.dealerDetailsList.dealerPhoneNumber!,
                        style: GoogleFonts.roboto(
                            color: const Color(0x99000000), fontSize: 14),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: LargeSubmitButton(
                            text: "CHECK SLOT",
                            ontap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDatePickerMode: DatePickerMode.day,
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: Color(0xffF2944E),
                                          onPrimary: Colors.white,
                                          shadow: Colors.cyan),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          primary:
                                              Colors.red, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                print(formattedDate);
                                BookServiceModel.slotDate = pickedDate;
                                setState(() {
                                  dateInput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialEntryMode:
                                      TimePickerEntryMode.dialOnly,
                                  initialTime: TimeOfDay.now(),
                                  helpText: "",
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme: const ColorScheme.light(
                                          // change the border color
                                          onPrimaryContainer: Color(0xffF2944E),
                                          primaryContainer: Color(0xffF2944E),
                                          primary: Color(0xffF2944E),
                                          onPrimary: Colors.white,
                                          // change the text color
                                          onSurface: Colors.black,
                                          background: Colors.transparent,
                                        ),

                                        // button colors
                                        buttonTheme: const ButtonThemeData(
                                          colorScheme: ColorScheme.light(
                                            primary: Colors.red,
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (pickedTime != null) {
                                  print(pickedTime.format(context));
                                  BookServiceModel.slotTime =
                                      pickedTime.format(context);
                                  print(BookServiceModel.slotTime);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ConfirmBookingDetails(dealerPhone: widget.dealerDetailsList.dealerPhoneNumber!,),
                                    ),
                                  );
                                  BookServiceModel.slotDate=DateTime(BookServiceModel.slotDate!.year,BookServiceModel.slotDate!.month,BookServiceModel.slotDate!.day,pickedTime.hour,pickedTime.minute);
                                  print('Formated booking date: ${BookServiceModel.slotDate}');
                                }
                              } else {}
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
