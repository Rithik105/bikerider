import 'package:bikerider/Http/BookService.dart';
import 'package:bikerider/Screens/ServiceRecods/service_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../Models/invoice_model.dart';
import '../../Models/service_records_model.dart';
import '../../custom/constants.dart';

class ServiceRecordsCard extends StatefulWidget {
  final ServiceRecordModel serviceRecordList;
  ServiceRecordsCard({
    Key? key,
    required this.serviceRecordList,
    required this.callBack,
    // required this.serviceRecordList,
  }) : super(key: key);
  Function() callBack;
  @override
  State<ServiceRecordsCard> createState() => _ServiceRecordsCardState();
}

class _ServiceRecordsCardState extends State<ServiceRecordsCard> {

  IconData? _selectedIcon;
  //double _userRating = widget.serviceRecordList.dealerRating!.toDouble();
  bool _isVertical = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetails(
                serviceRecordList: widget.serviceRecordList,
                callBack: widget.callBack,
               ),
          ),
        );
        // BookServiceHttp.getInvoiceDetails(widget.serviceRecordList.id!).then(
        //   (value) {
        //     invoiceList = [];
        //
        //     for (var e in value) {
        //       print("value of e is ${e}");
        //       invoiceList.add(
        //         ProductInvoiceModel.fromJson(e),
        //       );
        //     }
        //     //   serviceRecordList.add(value);
        //     print("invoice list is${invoiceList}");
        //     setState(() {});
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => ServiceDetails(
        //             serviceRecordList: widget.serviceRecordList,
        //             callBack: widget.callBack,
        //             invoiceModelList: invoiceList),
        //       ),
        //     );
        //   },
        // );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(
                0,
                0,
              ),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ), //BoxShadow
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: DateTime.parse(widget.serviceRecordList.slotDate!).isAfter(
                DateTime.now(),
              )
                  ? Container(
                      decoration: kServiceCardTagDecoration,
                      height: 25,
                      width: 60,
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
                      width: 60,
                      child: const Center(
                        child: Text(
                          "Past",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            DateFormat('dd').format(
                              DateTime.parse(
                                  widget.serviceRecordList.slotDate!),
                            ),
                            style: DateTime.parse(
                                        widget.serviceRecordList.slotDate!)
                                    .isAfter(
                              DateTime.now(),
                            )
                                ? kServiceRecordCardDateTextStyle
                                : kServicePastRecordCardDateTextStyle),
                        const SizedBox(
                          width: 3,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('MMM').format(
                                DateTime.parse(
                                    widget.serviceRecordList.slotDate!),
                              ),
                              style: DateTime.parse(
                                          widget.serviceRecordList.slotDate!)
                                      .isAfter(
                                DateTime.now(),
                              )
                                  ? kServiceRecordCardMonthTextStyle
                                  : kServicePastRecordCardMonthTextStyle,
                            ),
                            Text(
                              DateFormat('yyyy').format(DateTime.parse(
                                  widget.serviceRecordList.slotDate!)),
                              style: DateTime.parse(
                                          widget.serviceRecordList.slotDate!)
                                      .isAfter(
                                DateTime.now(),
                              )
                                  ? kServiceRecordCardYearTextStyle
                                  : kServicePastRecordCardYearTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    color: Colors.black12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width:MediaQuery.of(context).size.width*0.4,
                        child: Text(

                          widget.serviceRecordList.serviceType!,
                          style: kServiceRecordCardStarTextStyle,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width:MediaQuery.of(context).size.width*0.4,
                        child: RatingBarIndicator(
                          rating:
                              widget.serviceRecordList.dealerRating!.toDouble(),
                          itemBuilder: (context, index) => Icon(
                            _selectedIcon ?? Icons.star,
                            color: Color(0xffF3DA3B),
                          ),
                          itemCount: 5,
                          itemSize: 22.0,
                          unratedColor: Color(0xffd3d3d3),
                          direction:
                              _isVertical ? Axis.vertical : Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
