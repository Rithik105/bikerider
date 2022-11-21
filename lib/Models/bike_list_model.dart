class BikeListModel {
  String vehicleType = '';
  String vehicleImage = '';

  BikeListModel.fromJson(Map json) {
    vehicleType = json["vehicleType"];
    vehicleImage = json['vehicleImage'] ??
        'https://images.hindustantimes.com/auto/img/2021/01/13/600x338/Royal_Enfiled_Classic_350_1606287446412_1606287452623_1610507147713.jpg';
  }
  @override
  String toString() {
    return 'Vehicle Type:$vehicleType, Vehicle Image:$vehicleImage';
  }
}
