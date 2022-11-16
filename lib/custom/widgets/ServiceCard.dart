import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../Models/book_service_model.dart';
import '../../Models/workstation_model.dart';
import '../../Screens/BookService/WorkstationDetails.dart';
import '../constants.dart';



class ServiceCard extends StatefulWidget {
  ServiceCard({required this.workstation, Key? key}) : super(key: key);
  late final WorkstationModel workstation;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  IconData? _selectedIcon;
  // final WorkstationModel dealerDetailsList;
  bool _isVertical = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BookServiceModel.dealerName = widget.workstation.dealerName!;
        BookServiceModel.dealerCity = widget.workstation.dealerCity!;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DealerDetails(
                  dealerDetailsList: widget.workstation,
                )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(right: 20, left: 20, top: 20),
        height: 130,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.workstation.dealerName!,
                  style: TextStyle(color: Color(0xcfED7E2B), fontSize: 19),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(widget.workstation.dealerDescription!,
                    style: kServiceCardTextStyle),
                const SizedBox(
                  height: 5,
                ),
                Text(widget.workstation.dealerPhoneNumber!,
                    style: kServiceCardTextStyle),
                const SizedBox(
                  height: 5,
                ),
                RatingBarIndicator(
                  rating: widget.workstation.dealerRating!.ceilToDouble(),
                  itemBuilder: (context, index) => Icon(
                    _selectedIcon ?? Icons.star,
                    color: Color(0xffF3DA3B),
                  ),
                  itemCount: 5,
                  itemSize: 22.0,
                  unratedColor: Color(0xffd3d3d3),
                  direction: _isVertical ? Axis.vertical : Axis.horizontal,
                ),
              ],
            ),
            Text("4km", style: kServiceCardTextStyle)
          ],
        ),
      ),
    );
  }
}
