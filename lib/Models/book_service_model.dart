class BookServiceModel {
  static late String mobileNumber;
  static late String vehicleType;
  static late String vehicleNumber;
  static late String serviceType;
  static late String comments;
  static late DateTime? slotDate;
  static late String slotTime;
  static late String dealerName;
  static late String dealerCity;
  static late int dealerRating;


  // BookServiceModel({required this.mobileNumber,required this.vehicleType,required this.vehicleNumber,required this.serviceType,required this.comments});
//
  static void clearBookingDetails() {
    BookServiceModel.mobileNumber = "";
    BookServiceModel.vehicleType = "";
    BookServiceModel.vehicleNumber = "";
    BookServiceModel.serviceType = "";
    BookServiceModel.comments = "";
    BookServiceModel.slotDate = null;
    BookServiceModel.slotTime = "";
    BookServiceModel.dealerName = "";
    BookServiceModel.dealerCity = "";
  }

  static Map toJson() {
    return {
      'Mobile Number': mobileNumber,
      'vehicleNumber': vehicleNumber,
      'serviceType': serviceType,
      'vehicleType': vehicleType,
      'slotDate': slotDate.toString(),
      'time': slotTime,
      'dealer': dealerName,
      'city': dealerCity,
      'comments': comments,
    };
  }

  static Map toList() {
    return {
      'Mobile Number': mobileNumber,
      'Vehicle Number': vehicleNumber,
      'Service Type': serviceType,
      'Slot Date': slotDate,
      'Time': slotTime,
      'Dealer': dealerName,
      'City': dealerCity,
      'Comments': comments,
    };
  }

  BookServiceModel.fromJson(Map json) {
    mobileNumber = json['mobile'];
    vehicleNumber = json['vehicleNumber'];
    serviceType = json['serviceType'];
    comments = json['comments'];
    slotTime = json['time'];
    dealerName = json['dealer'];
    dealerCity = json['city'];
    dealerRating = json['ratings'];
  }
}
