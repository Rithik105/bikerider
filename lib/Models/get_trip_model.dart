import 'package:bikerider/Models/autocomplete.dart';

import '../Providers/invite_provider.dart';
import 'milestone.dart';

class GetTripModel {
  String? id;
  String? mobile;
  LocationDetails? source;
  LocationDetails? destination;
  String? tripName;
  String? startDate;
  String? endDate;
  List<ContactDetails> riders = [];
  String? startTime;
  GetTripModel(
      {required this.destination,
      required this.endDate,
      required this.id,
      required this.mobile,
      required this.startDate,
      required this.startTime,
      required this.tripName,
      required this.source});
  GetTripModel.fromJson(Map json) {
    id = json['_id'];
    mobile = json['mobile'];
    source = LocationDetails.fromJson(json['source'][0]);
    destination = LocationDetails.fromJson(json['source'][0]);
    tripName = json['tripName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    json['riders'].map((e) => riders.add(ContactDetails.fromJson(e)));
    json['milestones'].map((e) => MilestoneModal.fromJson(e));
  }
  @override
  String toString() {
    // TODO: implement toString
    return "$tripName";
  }
}
