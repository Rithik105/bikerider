import 'package:bikerider/Models/tuple_class.dart';
import 'package:flutter/material.dart';

import '../Utility/enums.dart';
import 'autocomplete.dart';

class MilestoneModal {
  int? milestoneId;
  late MilestoneType type;
  LocationDetails? from;
  LocationDetails? to;
  // String? distance;
  Tuple? distance;
  String? milDistance;
  // late double lat;
  // late double lon;
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  // MilestoneModal(
  //     {required this.milestoneId,
  //     required this.type,
  //     required this.lat,
  //     required this.lon});
  MilestoneModal({
    required this.milestoneId,
  });
  toJson() {
    return {
      'id': milestoneId,
      'source': from?.toJson(),
      'destination': to?.toJson(),
      'distance': distance?.distance
    };
  }

  MilestoneModal.fromJson(Map json) {
    // milestoneId = json['Id'];
    // type = json['type'];
    milestoneId = int.parse(json["id"]);
    print('test $json');
    from = LocationDetails.fromJson(json['source'][0]);
    print(json['destination']);
    to = LocationDetails.fromJson(json['destination'][0]);

    // to = json['destination'];
    // distance!.distance = json['distance'];
    milDistance = json['distance'];
  }
  @override
  String toString() {
    return 'Id:$milestoneId,From:$from,To:$to,dis:${distance}';
  }
}
