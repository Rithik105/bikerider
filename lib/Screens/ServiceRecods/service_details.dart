import 'dart:async';

import 'package:flutter/Material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../Models/invoice_model.dart';
import '../../Http/AddBikeHttp.dart';
import '../../Models/service_records_model.dart';
import '../../custom/constants.dart';
import 'invoice_details.dart';

class ServiceDetails extends StatefulWidget {
  ServiceDetails(
      {Key? key,
      required,
      required this.serviceRecordList,
      required this.invoiceModelList})
      : super(key: key);

  final ServiceRecordModel serviceRecordList;
  final List<ProductInvoiceModel> invoiceModelList;

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  IconData? _selectedIcon;
  double _rating = -1;
  double store = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffed863a),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
          title: Text(
            'Booking Details',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
          actions: [
            Container(
              padding: EdgeInsets.only(right: 10),
              height: 40,
              width: 40,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InvoiceScreen(productInvoiceList:widget.invoiceModelList,),
                    ),
                  );
                },
                child:
                    Image.asset("assets/images/book_service/invoice_logo.png"),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8),),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(
                          1,
                          -0.5,
                        ),
                        color: Colors.black26,
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      DateFormat('dd').format(DateTime.parse(
                                          widget.serviceRecordList.slotDate!),),
                                      style: GoogleFonts.roboto(
                                          color: Color(0xffED7F2C),
                                          fontSize: 45,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat('MMM').format(
                                              DateTime.parse(widget
                                                  .serviceRecordList
                                                  .slotDate!),),
                                          style: GoogleFonts.roboto(
                                              color: Color(0xffED7F2C),
                                              fontSize: 22,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                          DateFormat('yyyy').format(
                                              DateTime.parse(widget
                                                  .serviceRecordList
                                                  .slotDate!),),
                                          style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            color: Color(0xffED7F2C),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  color: Color(0x25000000),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      widget.serviceRecordList.serviceType!,
                                      style: GoogleFonts.roboto(
                                          color: Color(0x99000000),),
                                    ),
                                    RatingBarIndicator(
                                      rating: _rating == -1
                                          ? widget
                                              .serviceRecordList.dealerRating!
                                              .toDouble()
                                          : _rating,
                                      itemBuilder: (context, index) => const Icon(
                                        Icons.star,
                                        color: Color(0xffF3DA3B),
                                      ),
                                      itemCount: 5,
                                      itemSize: 23.0,
                                      unratedColor: Color(0xffd3d3d3),
                                      direction: Axis.horizontal,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ...widget.serviceRecordList
                              .toList()
                              .entries
                              .toList()
                              .map((e) => Column(
                                    children: [
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width: 150,
                                              child: Text(
                                                e.key,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w900,
                                                    color: Color(0x99000000),),
                                              ),),
                                          Text(':'),
                                          Container(
                                            width: 150,
                                            alignment: Alignment.centerRight,
                                            child: Text(e.value,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 15,
                                                    color: Color(0x99000000),),),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 1,
                                      ),
                                    ],
                                  ),),
                        ],
                      ),
                    ),
                    Positioned(
                        right: 0,
                        top: 0,
                        child:
                            DateTime.parse(widget.serviceRecordList.slotDate!)
                                    .isAfter(DateTime.now())
                                ? Container(
                                    decoration: kServiceCardTagDecoration,
                                    height: 25,
                                    width: 65,
                                    child: const Center(
                                        child: Text(
                                      "New",
                                      style: TextStyle(color: Colors.white),
                                    ),),
                                  )
                                : Container(
                                    decoration: kBookingDetailsTagDecoration,
                                    height: 25,
                                    width: 65,
                                    child: const Center(
                                        child: Text(
                                      "Past",
                                      style: TextStyle(color: Colors.white),
                                    ),),
                                  ),),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Total bill paid",
                style:
                    GoogleFonts.roboto(color: Color(0x99000000), fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text("Rs ${widget.invoiceModelList[0].total}/-",
                  style: GoogleFonts.roboto(
                      color: Color(0xffED7F2C),
                      fontSize: 35,
                      fontWeight: FontWeight.w400),),
              const SizedBox(
                height: 20,
              ),
              Text("Rate the Service"),
              const SizedBox(
                height: 20,
              ),
              RatingBar.builder(
                initialRating:
                    widget.serviceRecordList.dealerRating!.toDouble(),
                minRating: 0,
                unratedColor: Color(0x33000000),
                itemCount: 5,
                itemSize: 25.0,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  _selectedIcon ?? Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) async {
                  print(widget.invoiceModelList[0].itemList[0].itemName);
                  store = rating;
                  await AddBikeHttp.addReview(widget.serviceRecordList.id!,
                          rating, widget.serviceRecordList.dealerPhone!)
                      .then((value) {
                    print("the value is${value["dealerTotalRatings"]}");
                    _rating = rating;
                    print(_rating);
                  });
                  setState(() {});
                },
                updateOnDrag: true,
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),);
  }
}
