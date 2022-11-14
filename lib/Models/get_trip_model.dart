import 'package:bikerider/Models/autocomplete.dart';
import 'package:bikerider/Models/tuple_class.dart';

import '../Http/mapHttp.dart';
import '../Providers/invite_provider.dart';
import 'milestone.dart';

class GetTripModel {
  String? id;
  String? mobile;
  String? url;
  LocationDetails? source;
  LocationDetails? destination;
  String? tripName;
  String? startDate;
  String? endDate;
  List<ContactDetails> riders = [];
  String? startTime;
  List<MilestoneModal> milestones = [];
  List<String> recommendations = [];
  Tuple? distance;
  GetTripModel(
      {required this.destination,
      required this.url,
      required this.endDate,
      required this.id,
      required this.mobile,
      required this.startDate,
      required this.startTime,
      required this.tripName,
      required this.source});
  GetTripModel.fromJson(Map json) {
    print(json["recommendations"].runtimeType);
    id = json['_id'];
    mobile = json['mobile'];
    url = json['url'];
    source = LocationDetails.fromJson(json['source'][0]);
    destination = LocationDetails.fromJson(json['destination'][0]);
    tripName = json['tripName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    // recommendations.add(json["recommendations"]);
    json['recommendations'].forEach((e) => recommendations.add(e));

    startTime = json['startTime'];
    json['riders'].forEach((e) => riders.add(ContactDetails.fromJson(e)));
    json['milestones']
        .forEach((e) => milestones.add(MilestoneModal.fromJson(e)));
    print(milestones);
  }
  @override
  String toString() {
    // TODO: implement toString
    return "$tripName";
  }

  Future<bool> setDetails() async {
    distance = Tuple();
    await getDirections(source!, destination!).then(
      (value) {
        print('getDirectionDone');
        print('source: Lat${source!.latitude}, Lon${source!.longitude}');
        print(
            'destination: Lat${destination!.latitude}, Lon${destination!.longitude}');
        distance = value;
        print(value.points.length);
        print('Done');
      },
    );
    // for (int i = 0; i < milestone.length; i++) {
    //   getDirections(milestone[i].from!, milestone[i].to!)
    //       .then((value) => milestone[i].distance = value);
    // }
    return true;
  }

  getDistance() {
    // for (MilestoneModal temp in milestone) {}
    if (source != null && destination != null) {
      getDirections(source!, destination!).then((value) => print(value));
    }
  }
}
