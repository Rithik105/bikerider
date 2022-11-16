import 'dart:convert';

class AddBikeModel {
  late String vehicleType;
  late String vehicleNumber;
  late String engineNumber;
  late String frameNumber;
  late String batteryMake;
  late String registerNumber;
  late String model;
  late String color;
  late String dealerCode;

  AddBikeModel(
      {required this.vehicleNumber,
      required this.vehicleType,
      required this.engineNumber,
      required this.batteryMake,
      required this.frameNumber,
      required this.registerNumber,
      required this.model,
      required this.color,
      required this.dealerCode});


  toJson() {
    return jsonEncode({
      "vehicleType": vehicleType,
      "vehicleNumber": vehicleNumber,
      "engineNumber": engineNumber,
      "frameNumber": frameNumber,
      "batteryMake": batteryMake,
      "registerNumber": registerNumber,
      "model": model,
      "color": color,
      "dealerCode": dealerCode,
    });
  }
}
