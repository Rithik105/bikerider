class PrefillModel {
  String? mobile;
  int? attemptsLeft;
  List<VehicleDetails> prefill = [];
  // PrefillModel({required this.mobile, required this.prefill});
  PrefillModel.fromJson(Map json) {
    print(json);
    mobile = json['mobile'];
    // json['prefilles'] == null
    //     ? null
    //     :
    print(json['prefilled'].length);
    json['prefilled'].forEach((e) => prefill.add(VehicleDetails.fromJson(e)));
    attemptsLeft=json['attampts']??0;
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
