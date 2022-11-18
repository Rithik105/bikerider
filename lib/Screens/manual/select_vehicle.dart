import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../custom/widgets/button.dart';
import 'manual_model.dart';
import 'owners_manual.dart';

class SelectBike extends StatefulWidget {
  List<BikeDetailsModel> bikeCategories = [];
  PersonalDetailsModel personalDetails;
  SelectBike({required this.bikeCategories, required this.personalDetails});
  @override
  State<SelectBike> createState() => _SelectBikeState();
}

class _SelectBikeState extends State<SelectBike> {
  BikeDetailsModel? selectedVehicle;

  @override
  String? vehicleType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            widget.bikeCategories = [];
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFFED863A),
        centerTitle: true,
        title: Text(
          'Owners Manual',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              child: DropdownButtonFormField(
                icon:
                    Image.asset("assets/images/manual/dropdown.png", width: 10),
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelText: 'Vehicle type',
                  labelStyle: GoogleFonts.roboto(
                      color: Color(0xff9F9F9F), fontSize: 18),
                ),
                items: widget.bikeCategories
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item.vehicleType,
                        child: Text(
                          item.vehicleType,
                          style: GoogleFonts.roboto(
                              color: Colors.black87, fontSize: 18),
                        ),
                      ),
                    )
                    .toList(),
                value: vehicleType,
                onChanged: (value) {
                  setState(() {
                    vehicleType = value as String?;
                    print(vehicleType);
                  });
                  selectedVehicle = widget.bikeCategories
                      .where((element) => element.vehicleType == value)
                      .toList()[0];
                },
                itemHeight: 50,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: double.infinity,
              child: LargeSubmitButton(
                text: "GO",
                ontap: () {
                  //print(widget.bikeCategories[0]);
                  if (selectedVehicle != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OwnersManual(
                            bikeDetails: selectedVehicle!,
                            personalDetails: widget.personalDetails),
                      ),
                    );
                  }
                  // GetOwnerDetails.getOwner();
                  // print('Go');
                  // print(selectedVehicle);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
