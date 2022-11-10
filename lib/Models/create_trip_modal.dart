import 'package:bikerider/Models/tuple_class.dart';

import '../Http/mapHttp.dart';
import 'autocomplete.dart';
import 'milestone.dart';

class CreateTripModal {
  static LocationDetails? toDetails;
  static LocationDetails? fromDetails;
  static String? tripName;
  static String? startDate;
  static String? endDate;
  static String? startTime;
  static List<String> recommendations = [];
  static List<ContactDetails> contacts = [];
  static List<MilestoneModal> milestone = [];
  static Tuple? distance;
  toJson() {
    return {
      'tripName': tripName,
      'from': fromDetails?.toJson(),
      'to': toDetails?.toJson(),
      'startDate': startDate,
      'endDate': endDate,
      'startTime': startTime,
      'recommendations': recommendations,
      'contacts': contacts.map((e) => e.toJson()).toList(),
      'milestone': milestone.map((e) => e.toJson()).toList(),
      'distance': distance?.toJson(),
    }.toString();
  }

  static printRecommendations() {
    recommendations.forEach((element) {
      print(element);
    });
  }

  static Future<bool> setDetails() async {
    distance = Tuple();
    await getDirections(fromDetails!, toDetails!).then(
      (value) {
        CreateTripModal.distance = value;
      },
    );
    for (int i = 0; i < milestone.length; i++) {
      await getDirections(milestone[i].from!, milestone[i].to!)
          .then((value) => milestone[i].distance = value);
    }
    return true;
  }

  static void printAll() {
    print(CreateTripModal().toJson());
  }

//  static createMilestone() {}
  static printMilestones() {
    for (MilestoneModal e in milestone) {
      print(e);
    }
  }

  static getDistance() {
    // for (MilestoneModal temp in milestone) {}
    if (fromDetails != null && toDetails != null) {
      getDirections(fromDetails!, toDetails!).then((value) => print(value));
    }
  }

  static void printContacts() {
    // print('Print contacts called');
    print('Selected Contacts:');
    for (ContactDetails e in contacts) {
      print(e);
    }
  }

  static void printFromDetails() {
    print('Print From Details');
    print(fromDetails);
    // contacts.forEach((e) => print(e));
  }

  static void printToDetails() {
    print('Print To Details');
    print(toDetails);
    // contacts.forEach((e) => print(e));
  }

  static void printStartDate() {
    print('Print Start Date');
    print(startDate);
  }

  static void printEndDate() {
    print('Print End Date');
    print(endDate);
  }

  static void printTripName() {
    print('Print TripName');
    print(tripName);
  }

  static void printStartTime() {
    print('StartTime: $startTime');
  }
}
