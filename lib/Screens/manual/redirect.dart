import 'package:bikerider/Screens/manual/select_vehicle.dart';
import 'package:bikerider/Screens/manual/services.dart';
import 'package:flutter/material.dart';
import 'manual_model.dart';

class Redirect extends StatelessWidget {
  List<BikeDetailsModel> bikes = [];
  PersonalDetailsModel? personalDetails;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // GetBikeDetails.getBikes().then(
        //   (value) {
        //     value.forEach((e) {
        //       bikes.add(BikeDetailsModel.fromJson(e));
        //     });
        //   });
        //     Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => SelectBike(bikeCategories: bikes),
        //     ),
        //     );
        //   },
        // );
        GetOwnerDetails.getOwner().then(
          (value) {
            // print(value[0]);
            personalDetails = PersonalDetailsModel.fromJson(value[0]);
            GetBikeDetails.getBikes().then(
              (value) {
                value.forEach(
                  (e) {
                    bikes.add(BikeDetailsModel.fromJson(e));
                  },
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SelectBike(
                        bikeCategories: bikes,
                        personalDetails: personalDetails!),
                  ),
                );
              },
            );
          },
        );
      },
      child: Text("select"),
    );
  }
}
