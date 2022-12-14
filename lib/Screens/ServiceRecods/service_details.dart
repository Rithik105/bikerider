import 'dart:async';

import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../Http/BookService.dart';
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
      required this.callBack})
      : super(key: key);
  Function() callBack;
  final ServiceRecordModel serviceRecordList;
  // final List<ProductInvoiceModel> invoiceModelList;

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  bool loading = true;
  List<ProductInvoiceModel> invoiceList = [];
  IconData? _selectedIcon;
  double _rating = -1;
  double store = 2;
  void initState() {
// TODO: implement initState
    super.initState();
    print('InitState');
    BookServiceHttp.getInvoiceDetails(widget.serviceRecordList.id!).then(
      (value) {
        invoiceList = [];

        for (var e in value) {
          print("value of e is ${e}");
          invoiceList.add(
            ProductInvoiceModel.fromJson(e),
          );
        }
        //   serviceRecordList.add(value);
        print("invoice list is${invoiceList}");
        setState(() {
          invoiceList;
          loading = false;
        });
      },
    );
  }

  void dispose() {
    invoiceList.clear();
    super.dispose();
  }

  Widget billpaid() {
    if (invoiceList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 5),
        child: Text(
          "Service yet to be completed",
          style: GoogleFonts.robotoFlex(
              color: const Color(0xffed863a),
              letterSpacing: 1,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
      );
    } else {
      return Column(children: [
        Text(
          "Total bill paid",
          style:
              GoogleFonts.roboto(color: const Color(0x99000000), fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Rs ${invoiceList[0].total ?? ""}/-",
          style: GoogleFonts.roboto(
              color: const Color(0xffED7F2C),
              fontSize: 35,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Rate the Service"),
        const SizedBox(
          height: 20,
        ),
        RatingBar.builder(
          initialRating: widget.serviceRecordList.dealerRating!.toDouble(),
          minRating: 0,
          unratedColor: const Color(0x33000000),
          itemCount: 5,
          itemSize: 25.0,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) async {
            store = rating;
            await AddBikeHttp.addReview(widget.serviceRecordList.id!, rating,
                    widget.serviceRecordList.dealerPhone!)
                .then((value) {
              print("the value is${value["dealerTotalRatings"]}");
              _rating = rating;
              print(_rating);
            });
            setState(() {});
          },
          updateOnDrag: true,
        ),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffed863a),
        leading: BackButton(
          onPressed: () {
            Timer(const Duration(milliseconds: 500), () {
              Navigator.pop(context);
            });
            widget.callBack();
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
            padding: const EdgeInsets.only(right: 10),
            height: 40,
            width: 40,
            child: GestureDetector(
              onTap: () {
                if (invoiceList.isEmpty) {
                  showToast(msg: "Service yet to be completed");
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvoiceScreen(
                        productInvoiceList: invoiceList,
                      ),
                    ),
                  );
                }
              },
              child: Image.asset("assets/images/book_service/invoice_logo.png"),
            ),
          ),
        ],
      ),
      body: Center(
        child: loading
            ? const CircularProgressIndicator(
                color: Colors.orange,
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // height:MediaQuery.of(context).orientation==Orientation.portrait MediaQuery.of(context).size.height * 0.8,
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 30),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
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
                        ],
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            DateFormat('dd').format(
                                              DateTime.parse(widget
                                                  .serviceRecordList.slotDate!),
                                            ),
                                            style: GoogleFonts.roboto(
                                                color: const Color(0xffED7F2C),
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
                                                      .slotDate!),
                                                ),
                                                style: GoogleFonts.roboto(
                                                    color:
                                                        const Color(0xffED7F2C),
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                              Text(
                                                DateFormat('yyyy').format(
                                                  DateTime.parse(widget
                                                      .serviceRecordList
                                                      .slotDate!),
                                                ),
                                                style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  color:
                                                      const Color(0xffED7F2C),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 1,
                                        color: const Color(0x25000000),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              widget.serviceRecordList
                                                  .serviceType!,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              style: GoogleFonts.roboto(
                                                color: const Color(0x99000000),
                                              ),
                                            ),
                                          ),
                                          RatingBarIndicator(
                                            rating: _rating == -1
                                                ? widget.serviceRecordList
                                                    .dealerRating!
                                                    .toDouble()
                                                : _rating,
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                              Icons.star,
                                              color: Color(0xffF3DA3B),
                                            ),
                                            itemCount: 5,
                                            itemSize: 23.0,
                                            unratedColor:
                                                const Color(0xffd3d3d3),
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
                                    .map((e) {
                                  if (e.key == 'Comments') {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          e.key,
                                          style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xff4F504F),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          e.value,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            color: const Color(0xff4F504F),
                                          ),
                                        ),
                                        const Divider(
                                          thickness: 0,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                              child: Text(
                                                e.key,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900,
                                                  color:
                                                      const Color(0x99000000),
                                                ),
                                              ),
                                            ),
                                            const Text(':'),
                                            e.value != "Breakdown assistance"
                                                ? SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.35,
                                                    child: Text(
                                                      e.value,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 15,
                                                        color: const Color(
                                                            0xff4F504F),
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.35,
                                                    child: Text(
                                                      e.value,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 15,
                                                        color: const Color(
                                                            0xff4F504F),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 1,
                                        ),
                                      ],
                                    );
                                  }
                                }),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: DateTime.parse(
                                        widget.serviceRecordList.slotDate!)
                                    .isAfter(DateTime.now())
                                ? Container(
                                    decoration: kServiceCardTagDecoration,
                                    height: 25,
                                    width: 65,
                                    child: const Center(
                                      child: Text(
                                        "New",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: kBookingDetailsTagDecoration,
                                    height: 25,
                                    width: 65,
                                    child: const Center(
                                      child: Text(
                                        "Past",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    billpaid(),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
