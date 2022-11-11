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
      'Id': milestoneId,
      'source': from?.toJson(),
      'destination': to?.toJson()
    };
  }

  MilestoneModal.fromJson(Map json) {
    milestoneId = json['Id'];
    type = json['type'];
    from = json['from'];
    to = json['to'];
  }
  @override
  String toString() {
    return 'Id:$milestoneId,From:$from,To:$to';
  }
}
