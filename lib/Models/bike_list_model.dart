class BikeListModel {
  String bikeType = '';
  String bikeImage = '';
  String vehicleImage = '';

  BikeListModel.fromJson(Map json) {
    bikeType = json["vehicleType"];
    bikeImage = json["vehicleImage"];
    vehicleImage = json['vehicleImage'] ??
        'https://images.hindustantimes.com/auto/img/2021/01/13/600x338/Royal_Enfiled_Classic_350_1606287446412_1606287452623_1610507147713.jpg';
  }
}
