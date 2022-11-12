import 'package:bikerider/Models/get_trip_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Models/create_trip_modal.dart';
// import 'package:ride_app/screens/custom_padding.dart';
// import 'package:ride_app/service/direction.dart';
//
// import '../Providers/map_provider.dart';
// import '../constants.dart';

class MapCardGo extends StatefulWidget {
  GetTripModel getTripModel;
  MapCardGo({Key? key, required this.getTripModel
      // required this.points,
      })
      : super(key: key);
  // final List points;
  @override
  State<MapCardGo> createState() => _MapCardGoState();
}

class _MapCardGoState extends State<MapCardGo> {
  late GoogleMapController myController;
  // bool pauseButton = false;
  Marker? origin;
  Marker? destination;
  // DirectionRepository dir = DirectionRepository();
  final Set<Marker> _markers = <Marker>{};
  final Set<Polygon> _polygons = <Polygon>{};
  final Set<Polyline> _polylines = <Polyline>{};

  List<LatLng> polygonLatLngs = <LatLng>[];
  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  static CameraPosition _initialCameraPosition =
      CameraPosition(target: LatLng(28.67921234833848, 77.16738359902374));
  double getZoomLevel() {
    int length = widget.getTripModel.distance!.points.length;
    if (length > 9000) {
      return 3;
    } else if (length > 7000) {
      return 6;
    } else if (length > 6000) {
      return 7;
    } else if (length > 5000) {
      return 8;
    } else if (length > 2000) {
      return 8.15;
    } else if (length < 1000) {
      return 12;
    }
    return 8;
  }

  void _onMapCreated(GoogleMapController controller) {
    _initialCameraPosition = _initialCameraPosition = CameraPosition(
      // target: LatLng(13.336817194763675, 74.737992486596),
      // var coordinates = CreateTripModal
      //   .distance!.points[CreateTripModal.distance!.points.length ~/ 2];
      target: LatLng(
        widget.getTripModel.distance!
                .points[widget.getTripModel.distance!.points.length ~/ 2]
            ['latitude'],
        widget.getTripModel.distance!
                .points[widget.getTripModel.distance!.points.length ~/ 2]
            ['longitude'],
      ),
      zoom: getZoomLevel(),
    );
    myController = controller;
    controller.getVisibleRegion().then(
          (value) => print('Visible region $value'),
        );
    // controller.getZoomLevel().then((value) => print('Zoom level $value'));
    // double zoom = (CreateTripModal.distance!.points.length ~/ 10) as double;
    // print(zoom);
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(
          widget.getTripModel.distance!
                  .points[widget.getTripModel.distance!.points.length ~/ 2]
              ['latitude'],
          widget.getTripModel.distance!
                  .points[widget.getTripModel.distance!.points.length ~/ 2]
              ['longitude'],
        ),
        getZoomLevel(),
      ),
    );
    // controller.getVisibleRegion().then(
    //       (value) => print('Visible region $value'),
    //     );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Map screen ${widget.getTripModel.distance!.points}');
    print('widget..getTripModel.source!.latitude');
    _setMarker(
      LatLng(
        widget.getTripModel.source!.latitude,
        widget.getTripModel.source!.longitude,
      ),
    );
    _setMarker(
      LatLng(
        widget.getTripModel.destination!.latitude,
        widget.getTripModel.destination!.longitude,
      ),
    );
    // _setMarker(const LatLng(13.336817194763675, 74.737992486596));
    // _setMarker(const LatLng(13.62045787701918, 74.69220898124763));
    // 13.336817194763675,74.737992486596:12.913909224973084,74.85484793693875
    // _setPolygon();
    // dir.getDirections().then((value) => _setPolyline(value));
    _setPolyline(widget.getTripModel.distance!.points);
  }

  void _setMarker(LatLng point) {
    // setState(() {
    _markers.add(
      Marker(markerId: const MarkerId('marker'), position: point),
    );
    // });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
    );
  }

  void _setPolyline(List points) {
    print(points);
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 5,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(
                point["latitude"],
                point["longitude"],
              ),
            )
            .toList()));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomGesturesEnabled: false,
      rotateGesturesEnabled: false,
      scrollGesturesEnabled: false,
      polylines: _polylines,
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: _onMapCreated,
      initialCameraPosition: _initialCameraPosition,
      markers: _markers,
      polygons: _polygons,
      // onTap: (point) {
      //   setState(() {
      //     polygonLatLngs.add(point);
      //     _setPolygon();
      //   });
      // },
    );
  }

  // void _addMarker(LatLng pos) {
  //   if (origin == null || (origin != null && destination != null)) {
  //     setState(
  //       () {
  //         origin = Marker(
  //           markerId: const MarkerId('origin'),
  //           infoWindow: const InfoWindow(title: 'origin'),
  //           icon: BitmapDescriptor.defaultMarkerWithHue(
  //             BitmapDescriptor.hueGreen,
  //           ),
  //           position: pos,
  //         );
  //         destination = null;
  //       },
  //     );
  //   } else {
  //     setState(
  //       () {
  //         destination = Marker(
  //           markerId: const MarkerId('destination'),
  //           infoWindow: const InfoWindow(title: 'destination'),
  //           icon: BitmapDescriptor.defaultMarkerWithHue(
  //             BitmapDescriptor.hueBlue,
  //           ),
  //           position: pos,
  //         );
  //       },
  //     );
  //   }
  // }
}
