class PrefillModel {
  String? mobile;
  List<VehicleDetails> prefill = [];
  PrefillModel({required this.mobile, required this.prefill});
  PrefillModel.fromJson(Map json) {
    mobile = json['mobile'];
    json['prefilles'] == null
        ? null
        : json['prefilled']
            .forEach((e) => prefill.add(VehicleDetails.fromJson(e)));
  }
// toJson(){
//   return{'mobile':mobile,'to':vehicleType,'distance':vehicleNumber};
// }
}

class VehicleDetails {
  String? vehicleName;
  String? vehicleNumber;
  VehicleDetails.fromJson(var json) {
    vehicleName = json['vehicleType'];
    vehicleNumber = json['vehicleNumber'];
  }
}
