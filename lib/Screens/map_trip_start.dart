import 'package:bikerider/Models/get_trip_model.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../custom/constants.dart';
import 'maps_provider.dart';

class MapStart extends StatefulWidget {
  MapStart({
    Key? key,
    required this.getTripModel,
  }) : super(key: key);
  @override
  State<MapStart> createState() => _MapStartState();
  final GetTripModel getTripModel;
}

class _MapStartState extends State<MapStart> {
  late GoogleMapController myController;
  bool pauseButton = false;
  Marker? origin;
  Marker? destination;
  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();

  List<LatLng> polygonLatLngs = <LatLng>[];
  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;
  static CameraPosition _initialCameraPosition =
      CameraPosition(target: LatLng(28.67921234833848, 77.16738359902374));

  // static const _initialCameraPosition = CameraPosition(
  //   target: LatLng(widget.getTripMistance!.points[widget.getTripModel.distance!.points.length~/2],widget.getTripModel.distance!.points[widget.getTripModel.distance!.points.length~/2].),
  //   zoom: 10.0,
  // );
  // double getZoomLevel() {
  //   int length = widget.getTripModel.distance!.points.length;
  //   if (length > 9000) {
  //     return 3;
  //   } else if (length > 7000) {
  //     return 6;
  //   } else if (length > 6000) {
  //     return 7;
  //   } else if (length > 5000) {
  //     return 8;
  //   } else if (length > 2000) {
  //     return 8.15;
  //   } else if (length < 1000) {
  //     return 12;
  //   }
  //   return 8;
  // }
  LatLng getSouthWestBounds(LatLng src, LatLng dst) {
    double? lat, lon;
    if (src.latitude < dst.latitude) {
      lat = src.latitude;
    } else {
      lat = dst.latitude;
    }

    if (src.longitude < dst.longitude) {
      lon = src.longitude;
    } else {
      lon = dst.longitude;
    }
    return LatLng(lat, lon);
  }

  LatLng getNorthEastBounds(LatLng src, LatLng dst) {
    double? lat, lon;
    if (src.latitude > dst.latitude) {
      lat = src.latitude;
    } else {
      lat = dst.latitude;
    }

    if (src.longitude > dst.longitude) {
      lon = src.longitude;
    } else {
      lon = dst.longitude;
    }
    return LatLng(lat, lon);
  }

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
    // _initialCameraPosition = CameraPosition(
    //   // target: LatLng(13.336817194763675, 74.737992486596),
    //   // var coordinates = CreateTripModal
    //   //   .distance!.points[CreateTripModal.distance!.points.length ~/ 2];
    //   target: LatLng(
    //     widget.getTripModel.distance!
    //             .points[widget.getTripModel.distance!.points.length ~/ 2]
    //         ['latitude'],
    //     widget.getTripModel.distance!
    //             .points[widget.getTripModel.distance!.points.length ~/ 2]
    //         ['longitude'],
    //   ),
    //   // zoom: 8,
    // );
    print('Map Created');
    LatLng source = LatLng(widget.getTripModel.source!.latitude,
        widget.getTripModel.source!.longitude);
    LatLng destination = LatLng(widget.getTripModel.destination!.latitude,
        widget.getTripModel.destination!.longitude);
    print('${source.latitude},${source.longitude}');
    print('${destination.latitude},${destination.longitude}');
    LatLng southWest = getSouthWestBounds(source, destination);
    LatLng northEast = getNorthEastBounds(source, destination);
    print('southWest: $southWest');
    print('northEast: $northEast');
    LatLngBounds(southwest: southWest, northeast: northEast);
    Future.delayed(const Duration(milliseconds: 250)).then(
      (value) => myController.animateCamera(
        CameraUpdate.newLatLngBounds(
            LatLngBounds(southwest: southWest, northeast: northEast), 30),
      ),
    );
  }

  @override
  void dispose() {
    print('map disposed');
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setMarker(LatLng(widget.getTripModel.source!.latitude,
        widget.getTripModel.source!.longitude));
    _setMarker(LatLng(widget.getTripModel.destination!.latitude,
        widget.getTripModel.destination!.longitude));
    _setPolyline(widget.getTripModel.distance!.points);
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(Marker(markerId: const MarkerId('marker'), position: point));
    });
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

  // void _setPolyline(List<PointLatLng> points){
  //   print(points);
  //   final String polylineIdVal='polyline_$_polylineIdCounter';
  //   _polylineIdCounter++;
  //
  //   _polylines.add(Polyline(polylineId: PolylineId(polylineIdVal),
  //       width: 2,
  //       color:Colors.red ,
  //       points:points.map((point)=>LatLng(point.latitude, point.longitude)).toList()
  //       )
  //   );
  // }
  void _setPolyline(List points) {
    print(points);
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 5,
        color: Colors.blue,
        points: points
            .map((point) => LatLng(point["latitude"], point["longitude"]))
            .toList(),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          color: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFFffffff),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              heroTag: 'atm',
              onPressed: () {},
              backgroundColor: Colors.transparent,
              elevation: 0,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusElevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              enableFeedback: false,
              child: Image.asset(
                "assets/images/trip_start/atmMachine.png",
                width: 20,
              ),
            ),
            FloatingActionButton(
              heroTag: 'pump',
              onPressed: () {},
              backgroundColor: Colors.transparent,
              elevation: 0,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusElevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              enableFeedback: false,
              child: Image.asset(
                "assets/images/trip_start/gas-station.png",
                width: 20,
              ),
            ),
            FloatingActionButton(
              heroTag: 'lodge',
              onPressed: () {},
              backgroundColor: Colors.transparent,
              elevation: 0,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusElevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              enableFeedback: false,
              child: Image.asset(
                "assets/images/trip_start/bed.png",
                width: 20,
              ),
            ),
            FloatingActionButton(
              heroTag: 'hotel',
              onPressed: () {},
              backgroundColor: Colors.transparent,
              elevation: 0,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusElevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              enableFeedback: false,
              child: Image.asset(
                "assets/images/trip_start/restaurant.png",
                width: 20,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            // circles: {
            //   Circle(
            //     circleId: CircleId('0'),
            //     center: LatLng(
            //       widget.getTripModel.distance!.points[
            //               widget.getTripModel.distance!.points.length ~/ 2]
            //           ['latitude'],
            //       widget.getTripModel.distance!.points[
            //               widget.getTripModel.distance!.points.length ~/ 2]
            //           ['longitude'],
            //     ),
            //     radius: double.parse(
            //       widget.getTripModel.distance!.distance.substring(0,
            //               widget.getTripModel.distance!.distance.length - 2) *
            //           1000,
            //     ),
            //   ),
            // },

            polylines: _polylines,
            mapType: MapType.normal,
            // myLocationButtonEnabled: false,

            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialCameraPosition,
            markers: _markers,
            polygons: _polygons,
            // {
            //   if (origin != null) origin!,
            //   if (destination != null) destination!
            // },
            onTap: (point) {
              setState(() {
                polygonLatLngs.add(point);
                _setPolygon();
              });
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                // getDirections(widget.getTripModel.source!,
                //         widget.getTripModel.destination!)
                //     .then(
                //   (value) => _setPolyline(value.points),
                // );
                // _setPolyline(directions['polyline_decoded']);
              },
              child: Image.asset(
                "assets/images/trip_start/chat.png",
                width: 80,
              ),
            ),
          ).paddingAll(14, 0, 0, 30),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 40,
              width: 40,
              child: FloatingActionButton(
                onPressed: () {
                  // myController.animateCamera(
                  //   CameraUpdate.newCameraPosition(_initialCameraPosition),
                  // );
                  // getCurrentLocationData();
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                //materialTapTargetSize: MaterialTapTargetSize.padded,
                foregroundColor: Colors.black45,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.gps_fixed,
                  color: Color(0xffA4A4A4),
                ),
              ),
            ),
          ).paddingAll(14, 25, 0, 125),
        ],
      ),
      bottomNavigationBar: Consumer<MapProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return Container(
            height: 50,
            width: double.infinity,
            decoration: kLargeMapButtonDecoration,
            child: GestureDetector(
              onTap: () {
                Provider.of<MapProvider>(context, listen: false).toggleIcon();
              },
              child: Center(
                child: value.playIcon,
              ),
            ),
          );
        },
      ),
    );
  }

  void _addMarker(LatLng pos) {
    if (origin == null || (origin != null && destination != null)) {
      setState(() {
        origin = Marker(
            markerId: const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'origin'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: pos);
        destination = null;
      });
    } else {
      setState(() {
        destination = Marker(
            markerId: const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'destination'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: pos);
      });
    }
  }
}
