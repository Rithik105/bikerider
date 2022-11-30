import 'dart:io';
import 'dart:typed_data';
import 'package:bikerider/Screens/GarageCard.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../Models/invoice_model.dart';
import 'clipper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'invoice_constants.dart';
import 'invoice_service.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key, required this.productInvoiceList})
      : super(key: key);
  final List<ProductInvoiceModel> productInvoiceList;

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  PdfInvoiceServices pdf = PdfInvoiceServices();

  Future<void> savePDF(String filename, Uint8List byteList) async {
    var filepath = '/storage/emulated/0/Download/invoice.pdf';
    final file = File(filepath);
    await file.writeAsBytes(byteList);
    return;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.productInvoiceList[0].itemList);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.orange,
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              height: 30,
              width: 30,
              child: GestureDetector(
                onTap: () {
                  showToast(msg: "downloading...");
                  pdf
                      .createFinalInvoice(
                          widget.productInvoiceList.cast<ProductInvoiceModel>())
                      .then((value) {
                    savePDF("sai", value);
                    showToast(msg: "Pdf downloaded successfully");
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => GarageCard(),
                    //   ),
                    // );
                    // Navigator.popUntil(
                    //     context, ModalRoute.withName('/HomeScreen'));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                },
                child: Image.asset(
                  "assets/images/book_service/download.png",
                ),
              ),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 30),
                decoration: kInvoiceBackground,
                child: ClipPath(
                  clipper: CustomClips(),
                  child: Container(
                    decoration: kInvoiceBoxDecoration,
                    // width: double.infinity,
                    child: Container(
                      margin: const EdgeInsets.all(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Invoice",
                                style: GoogleFonts.roboto(
                                    fontSize: 22,
                                    color: const Color(0x99000000),
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                widget.productInvoiceList[0].invoiceNumber!,
                                style: kInvoiceLabelTextStyle,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            DateFormat('dd MMM yyyy').format(
                                widget.productInvoiceList[0].invoiceDate!),
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: const Color(0x99000000),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "₹ ${widget.productInvoiceList[0].total.toString()!} ",
                                  style: kTotalTextStyle,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                widget.productInvoiceList[0].paid == true
                                    ? Container(
                                        width: 80,
                                        height: 30,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 3),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: const Color(0xff19B692),
                                                width: 1.3)),
                                        child: const Center(
                                            child: Text(
                                          "√ Paid",
                                          style: TextStyle(
                                              color: Color(0xff19B692),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        )),
                                      )
                                    : Container(
                                        width: 100,
                                        height: 30,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 3),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.red, width: 1.3)),
                                        child: const Center(
                                          child: Text(
                                            "Not Paid",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const DottedLine(
                            direction: Axis.horizontal,
                            dashColor: Colors.black26,
                            lineThickness: 1,
                            dashLength: 8,
                            dashGapRadius: 0,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "PRODUCT",
                                style: kInvoiceLabelTextStyle,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "UNIT",
                                style: kInvoiceLabelTextStyle,
                              ),
                              Text(
                                "PRICE",
                                style: kInvoiceLabelTextStyle,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                ...widget.productInvoiceList[0].itemList.map(
                                  (e) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              e.itemName!,
                                              style: kItemsTextStyle,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              e.itemQuantity!.toString(),
                                              style: kItemsTextStyle,
                                            ),
                                            Text(
                                              e.itemPrice!.toString(),
                                              style: kItemsTextStyle,
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "TOTAL",
                                style: kItemsTextStyle,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.productInvoiceList[0].total.toString()!,
                                style: kItemsTextStyle,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const DottedLine(
                            direction: Axis.horizontal,
                            dashColor: Colors.black26,
                            lineThickness: 1,
                            dashLength: 8,
                            dashGapRadius: 0,
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
