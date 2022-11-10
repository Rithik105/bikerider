import 'package:flutter/material.dart';

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
      'milestoneId': milestoneId,
      'from': from?.toJson(),
      'to': to?.toJson()
    };
  }

  MilestoneModal.fromJson(Map json) {
    milestoneId = json['id'];
    type = json['type'];
    from = json['from'];
    to = json['to'];
  }
  @override
  String toString() {
    return 'id:$milestoneId,From:$from,To:$to';
  }
}
