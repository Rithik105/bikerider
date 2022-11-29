// import 'ActivityModel.dart';
import 'activityModel.dart';

class TimeLineModel {
  List<ActivityModel> tripList = [];
  TimeLineModel.fromJson(List json) {
    print('JsonList: ${json.length}');
    for (var outerList in json) {
      int id = 0;
      print('OuterList:$outerList');
      for (var innerList in outerList) {
        tripList.add(ActivityModel.fromJson(innerList, Id: id));
        id++;
      }
    }
    // print(tripList.asMap());
    // tripList.asMap().forEach((key, value) {
    //   print('value:${value.id}');
    // });
    tripList.last.isLast = true;
  }
  @override
  String toString() {
    return 'List length: ${tripList.length}';
  }
}

// Future<TimeLineModel> getMyActivities() async {
//   print('getMyActivities');
//   Map rawData = {
//     'tripDetails': [
//       [
//         {
//           'tripName': 'Reunion Manali',
//           'startDate': DateTime.now(),
//           'endDate': DateTime.now(),
//           'url':
//               'https://images.unsplash.com/photo-1536599018102-9f803c140fc1?auto=format&fit=crop&w=440&h=220&q=60',
//         },
//         {
//           'tripName': 'Ultimate Udupi',
//           'startDate': DateTime.now(),
//           'endDate': DateTime.now(),
//           'url':
//               'https://images.unsplash.com/photo-1502759683299-cdcd6974244f?auto=format&fit=crop&w=440&h=220&q=60',
//         },
//         {
//           'tripName': 'Mystic Mysore',
//           'startDate': DateTime.now(),
//           'endDate': DateTime.now(),
//           'url':
//               'https://media.istockphoto.com/id/1352173787/photo/sunset.jpg?b=1&s=170667a&w=0&k=20&c=jKDMxKXALm540OTFB3vMIDFYwOEedauorSpvLgjkU1M=',
//         },
//       ],
//       [
//         {
//           'tripName': 'Go Goa',
//           'startDate': DateTime(2021),
//           'endDate': DateTime.now(),
//           'url':
//               'https://images.unsplash.com/photo-1569317002804-ab77bcf1bce4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dW5zcGxhc2h8ZW58MHx8MHx8&w=1000&q=80',
//         },
//         {
//           'tripName': 'Deadly Delhi',
//           'startDate': DateTime.now(),
//           'endDate': DateTime.now(),
//           'url':
//               'https://images.unsplash.com/photo-1536782376847-5c9d14d97cc0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8ZnJlZXxlbnwwfHwwfHw%3D&w=1000&q=80',
//         },
//       ]
//     ]
//   };
//   // await Future.delayed(const Duration(seconds: 2));
//   final response = TimeLineModel.fromJson(rawData);
//   print('getMyActivities ${response.tripList.length}');
//   return response;
// }
