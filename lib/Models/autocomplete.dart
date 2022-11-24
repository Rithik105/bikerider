class LocationDetails {
  late String place;
  late double latitude;
  late double longitude;
  LocationDetails(
      {required this.place, required this.latitude, required this.longitude});
  Map toJson() {
    return {'place': place, 'latitude': latitude, 'longitude': longitude};
  }

  LocationDetails.fromJson(Map json) {
    place = (json['place']);

    latitude = double.parse(json['latitude']);
    longitude = double.parse(json['longitude']);
  }
  @override
  String toString() {
    return 'place:$place,latitude:$latitude,longitude:$longitude';
  }
}
