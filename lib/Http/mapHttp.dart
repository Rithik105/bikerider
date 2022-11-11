import 'dart:convert';

import "package:http/http.dart" as http;
import '../Models/autocomplete.dart';
import '../Models/tuple_class.dart';

Future<Tuple> getDirections(
  LocationDetails from,
  LocationDetails to,
) async {
  String baseUrl =
      'https://api.tomtom.com/routing/1/calculateRoute/${from.latitude},${from.longitude}:${to.latitude},${to.longitude}/json?key=sC9cDEhhsj0O9fCVgUp0kZYia2IaGm7L';
  var response = await http.get(Uri.parse(baseUrl));
  var json = jsonDecode(response.body);
  //print(json);
//  var results={
//    'polyline':json['routes'][0]['legs'][0]['points'],
// 'polyline_decoded':PolylinePoints().decodePolyline(json['routes'][0]['legs'][0]['points'])
//  };
//print(results);
  Tuple details = Tuple();
  details.distance =
      '${json['routes'][0]['summary']['lengthInMeters'] ~/ 1000}km';
  details.points = json['routes'][0]['legs'][0]['points'];
  return details;
}

Future<LocationDetails> getLocationDetails(String placeName) async {
  var rawData = await http.get(
      Uri.parse(
          "https://api.foursquare.com/v3/autocomplete?query=${placeName}&types=geo"),
      headers: {
        'Authorization': 'fsq3T7SKdVMGwe+IQk+L/A1uyXQgk+w0ILNgWBUGmoeyld8=',
        'accept': 'application/json'
      });
  Map jsonData = jsonDecode(rawData.body);
  Map latLon = jsonData['results'][0]['geo']['center'];
  return LocationDetails(
      place: placeName,
      latitude: latLon['latitude'],
      longitude: latLon['longitude']);
}

Future<http.Response> getSuggestions(search) {
  return http.get(
      Uri.parse(
          "https://api.foursquare.com/v3/autocomplete?query=${search}&types=geo"),
      headers: {
        'Authorization': 'fsq3T7SKdVMGwe+IQk+L/A1uyXQgk+w0ILNgWBUGmoeyld8=',
        'accept': 'application/json'
      });
}
