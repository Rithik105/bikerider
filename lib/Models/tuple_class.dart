class Tuple {
  String distance = '';
  List points = [];
  String duration = '';
  @override
  String toString() {
    return 'Distance: $distance, Points:${points.length}, Duration:$duration';
  }

  Map toJson() {
    return {'distance': distance, 'points': points};
  }
}
