class ActivityModel {
  int? id;
  String? url;
  String? tripName;
  DateTime? startDate;
  DateTime? endDate;

  ActivityModel({
    required this.id,
    required this.tripName,
    required this.startDate,
    required this.endDate,
    required this.url,
  });

  ActivityModel.fromJson(Map json, {int Id = 0}) {
    id = Id;
    tripName = json['tripName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    url = json['url'];
  }

  @override
  String toString() {
    return '[id:$id,tripName:$tripName,startDate:$startDate,endDate:$endDate,url:$url.]';
  }
}
