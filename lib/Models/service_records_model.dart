class ServiceRecordModel {
  String? id;
  String? mobileNumber;
  String? vehicleType;
  String? vehicleNumber;
  String? serviceType;
  String? comments;
  String? slotDate;
  String? slotTime;
  String? dealer;
  String? city;
  String? dealerPhone;
  String? dealerName;
  int? dealerRating;
  List? invoice;

  Map toList() {
    return {
      'Mobile Number': mobileNumber,
      'Vehicle Number': vehicleNumber,
      'Service Type': serviceType,
      'Time': slotTime,
      'Dealer': dealerName,
      'City': city,
      'Comments': comments,
    };
  }

  ServiceRecordModel.fromJson(Map json) {
    id=json['_id'];
    dealerPhone=json["dealerPhoneNumber"];
    mobileNumber = json['mobile'];
    vehicleNumber = json['vehicleNumber'];
    serviceType = json['serviceType'];
    comments = json['comments'];
    slotDate = json['slotDate'];
    slotTime = json['time'];
    dealerName = json['dealer'];
    city = json['city'];
    dealerRating = json['ratings'];
    invoice = json['invoice'];
  }

  ServiceRecordModel.fetchSortedServices(Map json){
    serviceType = json['serviceType'];
    slotDate = json['slotDate'];
    vehicleNumber = json['vehicleNumber'];
  }
}
