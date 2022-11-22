import 'dart:convert';

import 'package:flutter/material.dart';

class PersonalDetailsModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController licenceNumberController = TextEditingController();
  TextEditingController doorNoController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  PersonalDetailsModel.fromJson(Map json) {
    nameController.text = json['userName'] ?? "";
    licenceNumberController.text = json['lisenceNumber'] ?? "";
    doorNoController.text = json['doorNumber'] ?? "";
    cityController.text = json['city'] ?? "";
    stateController.text = json['state'] ?? "";
    pincodeController.text =
        json['pincode'] == null ? "" : json['pincode'].toString();
    mobileController.text = json['mobile'] ?? "";
    emailController.text = json['email'] ?? "";
  }
  toJson() {
    return json.encode({
      'lisenceNumber': licenceNumberController.text,
      'city': cityController.text,
      'state': stateController.text,
      'doorNumber': doorNoController.text,
      'pincode': pincodeController.text,
    });
  }
}

class BikeDetailsModel {
  String vehicleType = "";
  TextEditingController licenseController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController frameController = TextEditingController();
  TextEditingController batteryController = TextEditingController();
  TextEditingController regNoController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController bikeColorController = TextEditingController();
  TextEditingController dealerCodeController = TextEditingController();
  BikeDetailsModel.fromJson(Map json) {
    vehicleNumberController.text = json['vehicleNumber'] ?? '';
    engineController.text = json['engineNumber'] ?? '';
    frameController.text = json['frameNumber'] ?? '';
    batteryController.text = json['batteryMake'] ?? '';
    regNoController.text = json['registerNumber'] ?? '';
    modelController.text = json['model'] ?? '';
    bikeColorController.text = json['color'] ?? '';
    dealerCodeController.text = json['dealerCode'] ?? "";
    vehicleType = json['vehicleType'] ?? '';
  }
  @override
  String toString() {
    return 'License:$vehicleType';
  }
}
