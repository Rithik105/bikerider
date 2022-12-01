class ActivityModel {
  int? id;
  String? url;
  String? tripName;
  DateTime? startDate;
  DateTime? endDate;
  bool isLast;
  ActivityModel({
    required this.id,
    required this.tripName,
    required this.startDate,
    required this.endDate,
    required this.url,
    this.isLast = false,
  });

  ActivityModel.fromJson(Map json, {int Id = 0, this.isLast = false}) {
    id = Id;
    tripName = json['tripName'];
    startDate = DateTime.parse(json['startDate']);
    endDate = DateTime.parse(json['endDate']);
    // url = json['url'];
    url = json['tripImage'];
  }

  @override
  String toString() {
    return '[id:$id,tripName:$tripName,startDate:$startDate,endDate:$endDate,url:$url.]';
  }
}
