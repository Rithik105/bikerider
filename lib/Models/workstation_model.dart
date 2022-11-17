
class WorkstationModel{
  String? id;
  String? dealerName;
  String? distance;
  String? dealerCity;
  String? dealerAddress;
  String? dealerDescription;
  String? dealerPhoneNumber;
  double? dealerRating;
  String? dealerImage;

  //WorkstationModel({required this.id,required this.dealerName,required this.dealerCity,required this.dealerDescription,required this.dealerPhoneNumber,required this.dealerRating,required this.dealerImage,this.distance,});

  toJson(){
    return{'id':id,'dealerName':dealerName,'distance':distance,'dealerDescription':dealerDescription,'phone':dealerPhoneNumber,'stars':dealerRating,};
  }
  WorkstationModel.fromJson(Map json) {
    dealerName = json['dealerName'];
    //distance = json['distance'];
    dealerCity=json["dealerCity"];
    dealerAddress=json["dealerAddress"];
    dealerDescription = json['dealerDescription'];
    dealerPhoneNumber = json['dealerPhoneNumber'];
    dealerRating = json['dealerRating'];
    dealerImage=json['dealerImage'];
  }

}