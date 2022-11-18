import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    },
  );
}

Future<http.Response> getData(city) {
  var result = http.get(Uri.parse(
      "https://api.tomtom.com/routing/1/calculateRoute/13.336817194763675,74.737992486596:12.913909224973084,74.85484793693875/json?key=sC9cDEhhsj0O9fCVgUp0kZYia2IaGm7L"));
  return result;
}

Future<LatLng> getCurrentLocationData() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission != LocationPermission.whileInUse) {
    LocationPermission permission = await Geolocator.requestPermission();
  }

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);
  var lattitude = position.latitude;
  var longitude = position.longitude;
  return LatLng(lattitude, longitude);
  // print(position);
}

Future<List<NearByServices>> getAtmLocations(LatLng location) async {
  var rawData = await http.get(
    Uri.parse(
      'https://api.foursquare.com/v3/places/search?ll=${location.latitude},${location.longitude}&categories=11044&sort=DISTANCE',
    ),
    headers: {
      'Authorization': 'fsq3T7SKdVMGwe+IQk+L/A1uyXQgk+w0ILNgWBUGmoeyld8=',
      'accept': 'application/json'
    },
  );
  Map json = jsonDecode(rawData.body);
  List<NearByServices> details = [];
  // json['results'].map((e) => NearByServices.fromJson(e)).toList();
  for (int i = 0; i < json['results'].length; i++) {
    details.add(NearByServices.fromJson(json['results'][i]));
  }
  return details;
}

Future<List<NearByServices>> getRestaurantLocations(LatLng location) async {
  var rawData = await http.get(
    Uri.parse(
      'https://api.foursquare.com/v3/places/search?ll=${location.latitude},${location.longitude}&categories=13000&sort=DISTANCE',
    ),
    headers: {
      'Authorization': 'fsq3T7SKdVMGwe+IQk+L/A1uyXQgk+w0ILNgWBUGmoeyld8=',
      'accept': 'application/json'
    },
  );
  Map json = jsonDecode(rawData.body);
  List<NearByServices> details = [];
  // json['results'].map((e) => NearByServices.fromJson(e)).toList();
  for (int i = 0; i < json['results'].length; i++) {
    details.add(NearByServices.fromJson(json['results'][i]));
  }
  return details;
}

Future<List<NearByServices>> getFuelStationsLocations(LatLng location) async {
  var rawData = await http.get(
    Uri.parse(
      'https://api.foursquare.com/v3/places/search?ll=${location.latitude},${location.longitude}&categories=19007&sort=DISTANCE',
    ),
    headers: {
      'Authorization': 'fsq3T7SKdVMGwe+IQk+L/A1uyXQgk+w0ILNgWBUGmoeyld8=',
      'accept': 'application/json'
    },
  );
  Map json = jsonDecode(rawData.body);
  List<NearByServices> details = [];
  // json['results'].map((e) => NearByServices.fromJson(e)).toList();
  for (int i = 0; i < json['results'].length; i++) {
    details.add(NearByServices.fromJson(json['results'][i]));
  }
  return details;
}

Future<List<NearByServices>> getLodgeLocations(LatLng location) async {
  var rawData = await http.get(
    Uri.parse(
      'https://api.foursquare.com/v3/places/search?ll=${location.latitude},${location.longitude}&categories=19016&sort=DISTANCE',
    ),
    headers: {
      'Authorization': 'fsq3T7SKdVMGwe+IQk+L/A1uyXQgk+w0ILNgWBUGmoeyld8=',
      'accept': 'application/json'
    },
  );
  Map json = jsonDecode(rawData.body);
  List<NearByServices> details = [];
  // json['results'].map((e) => NearByServices.fromJson(e)).toList();
  for (int i = 0; i < json['results'].length; i++) {
    details.add(NearByServices.fromJson(json['results'][i]));
  }
  return details;
}

class NearByServices {
  LatLng? place;
  String? name;
  String? address;
  String? distance;

  NearByServices.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    distance = '${(json['distance'] / 1000).toStringAsFixed(2)}km' ?? '';
    var temp = json['geocodes']['main'];
    place = LatLng(temp['latitude'], temp['longitude']);
    address = json['location']['formatted_address'] ?? '';
  }
}

sendStatus(LatLng point, String token, String id) async {
  print(token);
  print(id);
  print(point);
  print(token);
  final http.Response response = await http.post(
    Uri.parse(
        "https://riding-application.herokuapp.com/api/v1/trip/currentLocation"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'BEARER $token'
    },
    body: json.encode({
      '_id': id,
      'currentLocation': [
        {'latitude': point.latitude, 'longitude': point.longitude}
      ],
    }),
  );
  print('.....');

  print(jsonDecode(response.body));
  return jsonDecode(response.body);
}

endTrip(String token, String id) async {
  print(id);
  print(token);
  final http.Response response = await http.post(
      Uri.parse(
          "https://riding-application.herokuapp.com/api/v1/trip/updateTripStatus"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token'
      },
      body: json.encode({"_id": id}));
  print('.....');

  print(jsonDecode(response.body));
  return jsonDecode(response.body);
}
