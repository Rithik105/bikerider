class BikeListModel{
  String bikeType='';
  String bikeImage='';


  BikeListModel.fromJson(Map json){
    bikeType=json["vehicleType"];
    bikeImage=json["vehicleImage"];
  }
}