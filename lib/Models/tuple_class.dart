class Tuple {
  String distance = '';
  List points = [];
  @override
  String toString() {
    return 'Distance: $distance, Points:${points.length}';
  }

  Map toJson() {
    return {'distance': distance, 'points': points};
  }
}
