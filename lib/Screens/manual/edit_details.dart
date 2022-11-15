import 'package:bikerider/Screens/manual/servieces.dart';
import 'package:flutter/material.dart';
import 'manual_model.dart';
import 'package:google_fonts/google_fonts.dart';

class EditDetails extends StatefulWidget {
  PersonalDetailsModel person;
  BikeDetailsModel bike;
  EditDetails({required this.person, required this.bike});

  @override
  State<EditDetails> createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(240, 148, 85, 1),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5, right: 15),
            height: 13,
            width: 23,
            child: GestureDetector(
                onTap: () {},
                child: Image.asset("assets/images/manual/share.png")),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        //padding: EdgeInsets.only(left: 20),
        //margin: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(
                        3,
                        3,
                      ),
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(
                        -3,
                        -3,
                      ),
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                //height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width - 40,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Personal Details",
                            style: GoogleFonts.roboto(
                                fontSize: 25, color: Color(0xffED7F2C)),
                          ),
                          GestureDetector(
                            onTap: () {
                              UpdateOwnerDetails.updateOwner(
                                  widget.person.toJson());
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              "assets/images/manual/save.png",
                              scale: 3,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: widget.person.licenceNumberController,
                        decoration: InputDecoration(
                          label: Text(
                            "Licence No",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                      TextField(
                        enabled: false,
                        controller: widget.person.nameController,
                        decoration: InputDecoration(
                          label: Text(
                            "Name",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                      TextField(
                        controller: widget.person.doorNoController,
                        decoration: InputDecoration(
                          label: Text(
                            "Door no",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                      TextField(
                        controller: widget.person.cityController,
                        decoration: InputDecoration(
                          label: Text(
                            "City",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                      TextField(
                        controller: widget.person.stateController,
                        decoration: InputDecoration(
                          label: Text(
                            "State",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                      TextField(
                        controller: widget.person.pincodeController,
                        decoration: InputDecoration(
                          label: Text(
                            "Pincode",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                      TextField(
                        enabled: false,
                        controller: widget.person.mobileController,
                        decoration: InputDecoration(
                          label: Text(
                            "Mobile",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                      TextField(
                        enabled: false,
                        controller: widget.person.emailController,
                        decoration: InputDecoration(
                          label: Text(
                            "Email",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // width: 300,
              ),
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(
                        3,
                        3,
                      ),
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(
                        -3,
                        -3,
                      ),
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                // height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width - 40,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Bike Details",
                            style: GoogleFonts.roboto(
                                fontSize: 25, color: Color(0xffED7F2C)),
                          )
                        ],
                      ),
                      // TextField(
                      //   controller: licenseController,
                      //   decoration: InputDecoration(
                      //     label: Text(
                      //       "License Number",
                      //       style: GoogleFonts.roboto(
                      //           fontSize: 15, color: Color(0x99000000)),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        enabled: false,
                        controller: widget.bike.engineController,
                        decoration: InputDecoration(
                          label: Text(
                            "Vehicle Number",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        enabled: false,
                        controller: widget.bike.vehicleNumberController,
                        decoration: InputDecoration(
                          label: Text(
                            "Engine",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                      TextField(
                        enabled: false,
                        controller: widget.bike.frameController,
                        decoration: InputDecoration(
                          label: Text(
                            "Frame No",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                      TextField(
                        enabled: false,
                        controller: widget.bike.batteryController,
                        decoration: InputDecoration(
                          label: Text(
                            "Battery make",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                      TextField(
                        enabled: false,
                        controller: widget.bike.regNoController,
                        decoration: InputDecoration(
                          label: Text(
                            "Reg No",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                      TextField(
                        enabled: false,
                        controller: widget.bike.modelController,
                        decoration: InputDecoration(
                          label: Text(
                            "Model",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                      TextField(
                        enabled: false,
                        controller: widget.bike.bikeColorController,
                        decoration: InputDecoration(
                          label: Text(
                            "Color",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                      TextField(
                        enabled: false,
                        controller: widget.bike.dealerCodeController,
                        decoration: InputDecoration(
                          label: Text(
                            "Dealer code",
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Color(0x99000000)),
                          ),
                        ),
                      ),
                    ],
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
