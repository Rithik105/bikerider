class LocationDetails {
  late String name;
  late double lat;
  late double lon;
  LocationDetails({required this.name, required this.lat, required this.lon});
  Map toJson() {
    return {'name': name, 'lat': lat, 'lon': lon};
  }

  LocationDetails.fromJson(Map json) {
    name = json['name'];
    lat = json['lat'];
    lon = json['lon'];
  }
  @override
  String toString() {
    return 'Name:$name,Lat:$lat,Lon:$lon';
  }
}
