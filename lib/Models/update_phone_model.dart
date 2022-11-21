class UpdatePhoneModel{
  String? message;
  int? attempts;


  UpdatePhoneModel.fromJson(Map json){
    message=json["message"];
  }
}