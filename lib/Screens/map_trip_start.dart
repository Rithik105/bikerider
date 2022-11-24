// ignore_for_file: iterable_contains_unrelated_type

import 'package:bikerider/Http/mapHttp.dart';
import 'package:bikerider/Models/get_trip_model.dart';
import 'package:bikerider/Screens/tripSummaryComplete.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:bikerider/custom/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Http/UserHttp.dart';
import '../Utility/Secure_storeage.dart';
import '../custom/constants.dart';
import 'ChatScreen.dart';

//  Lodge:      19016
//  Restaurant: 13000
//  ATM:        11044
//  Petrol:     19007

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
  bool showAtmMarkers = true;
  bool showFuelStationMarkers = true;
  bool showRestaurantMarkers = true;
  bool showLodgingMarkers = true;
  bool chatDisable = false;
  late BitmapDescriptor currentLocationIcon;
  late BitmapDescriptor atmLocationIcon;
  late BitmapDescriptor fuelStationLocationIcon;
  late BitmapDescriptor restaurantLocationIcon;
  late BitmapDescriptor lodgeLocationIcon;

  setCustomIcons() async {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/google_maps/fab.png',
    ).then((value) => currentLocationIcon = value);
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/google_maps/atmMachine.png',
    ).then((value) => atmLocationIcon = value);
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/google_maps/bed.png',
    ).then((value) => lodgeLocationIcon = value);
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/google_maps/restaurant.png',
    ).then((value) => restaurantLocationIcon = value);
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/google_maps/gas-station.png',
    ).then((value) => fuelStationLocationIcon = value);
    // await BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(),
    //   'assets/images/google_maps/fab.png',
    // ).then((value) => currentLocationIcon = value);
    // await BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(),
    //   'assets/images/google_maps/fab.png',
    // ).then((value) => currentLocationIcon = value);
  }

  late GoogleMapController myController;
  bool buttonController = false;
  Marker? origin;
  Marker? destination;
  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();

  List<LatLng> polygonLatLngs = <LatLng>[];
  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;
  final CameraPosition _initialCameraPosition = const CameraPosition(
      target: LatLng(28.67921234833848, 77.16738359902374));

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
    setCustomIcons();
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
              onPressed: () {
                if (showAtmMarkers) {
                  getCurrentLocationData().then(
                    (value) {
                      myController.animateCamera(
                        CameraUpdate.newLatLngZoom(value, 12),
                      );
                      bool checkIfExist = _markers.contains((element) =>
                          element.markerId ==
                          const MarkerId('currentLocation'));
                      if (checkIfExist) {
                        _markers.removeWhere((element) =>
                            element.markerId ==
                            const MarkerId('currentLocation'));
                      }
                      _markers.add(
                        Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: value,
                          icon: currentLocationIcon,
                        ),
                      );
                      setState(() {});
                      getAtmLocations(value).then((value) {
                        print('Atm counts: ${value.length}');
                        _markers.removeWhere((element) =>
                            element.markerId.toString().startsWith('ATM'));
                        int atmId = 0;
                        for (int i = 0; i < value.length; i++) {
                          _markers.add(
                            Marker(
                              position: LatLng(value[i].place!.latitude,
                                  value[i].place!.longitude),
                              infoWindow: InfoWindow(
                                title:
                                    '${value[i].name!} [${value[i].distance}]',
                                snippet: value[i].address,
                              ),
                              markerId: MarkerId(
                                'ATM-$atmId',
                              ),
                              icon: atmLocationIcon,
                            ),
                          );
                          atmId++;
                        }
                        _markers.forEach((element) {
                          print(element.infoWindow.title);
                        });
                        setState(() {});
                      });
                    },
                  );
                } else {
                  _markers.removeWhere((element) =>
                      element.markerId.value.toString().startsWith('ATM'));
                  _markers.forEach((element) => print(
                      element.markerId.value.toString().startsWith('ATM')));
                  print('removed atm');
                }
                showAtmMarkers = !showAtmMarkers;
                setState(() {});
              },
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
              heroTag: 'fuel',
              onPressed: () {
                if (showFuelStationMarkers) {
                  getCurrentLocationData().then(
                    (value) {
                      myController.animateCamera(
                        CameraUpdate.newLatLngZoom(value, 12),
                      );
                      bool checkIfExist = _markers.contains((element) =>
                          element.markerId ==
                          const MarkerId('currentLocation'));
                      if (checkIfExist) {
                        _markers.removeWhere((element) =>
                            element.markerId ==
                            const MarkerId('currentLocation'));
                      }
                      _markers.add(
                        Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: value,
                          icon: currentLocationIcon,
                        ),
                      );
                      setState(() {});
                      getFuelStationsLocations(value).then((value) {
                        print('Fuel counts: ${value.length}');
                        _markers.removeWhere((element) => element.markerId
                            .toString()
                            .startsWith('FuelStations'));
                        int fuelId = 0;
                        for (int i = 0; i < value.length; i++) {
                          _markers.add(
                            Marker(
                              position: LatLng(value[i].place!.latitude,
                                  value[i].place!.longitude),
                              infoWindow: InfoWindow(
                                title:
                                    '${value[i].name!} [${value[i].distance}]',
                                snippet: value[i].address,
                              ),
                              markerId: MarkerId(
                                'FuelStations-$fuelId',
                              ),
                              icon: fuelStationLocationIcon,
                            ),
                          );
                          fuelId++;
                        }
                        _markers.forEach((element) {
                          print(element.infoWindow.title);
                        });
                        setState(() {});
                      });
                    },
                  );
                } else {
                  _markers.removeWhere((element) => element.markerId.value
                      .toString()
                      .startsWith('FuelStations'));
                  _markers.forEach((element) => print(element.markerId.value
                      .toString()
                      .startsWith('FuelStations')));
                  print('removed FuelStations');
                }
                showFuelStationMarkers = !showFuelStationMarkers;
                setState(() {});
              },
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
              onPressed: () {
                if (showLodgingMarkers) {
                  getCurrentLocationData().then(
                    (value) {
                      myController.animateCamera(
                        CameraUpdate.newLatLngZoom(value, 12),
                      );
                      bool checkIfExist = _markers.contains((element) =>
                          element.markerId ==
                          const MarkerId('currentLocation'));
                      if (checkIfExist) {
                        _markers.removeWhere((element) =>
                            element.markerId ==
                            const MarkerId('currentLocation'));
                      }
                      _markers.add(
                        Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: value,
                          icon: currentLocationIcon,
                        ),
                      );
                      setState(() {});
                      getLodgeLocations(value).then((value) {
                        print('Lodge counts: ${value.length}');
                        _markers.removeWhere((element) =>
                            element.markerId.toString().startsWith('Lodge'));
                        int lodgeId = 0;
                        for (int i = 0; i < value.length; i++) {
                          _markers.add(
                            Marker(
                              position: LatLng(value[i].place!.latitude,
                                  value[i].place!.longitude),
                              infoWindow: InfoWindow(
                                title:
                                    '${value[i].name!} [${value[i].distance}]',
                                snippet: value[i].address,
                              ),
                              markerId: MarkerId(
                                'Lodge-$lodgeId',
                              ),
                              icon: lodgeLocationIcon,
                            ),
                          );
                          lodgeId++;
                        }
                        _markers.forEach((element) {
                          print(element.infoWindow.title);
                        });
                        setState(() {});
                      });
                    },
                  );
                } else {
                  _markers.removeWhere((element) =>
                      element.markerId.value.toString().startsWith('Lodge'));
                  _markers.forEach((element) => print(
                      element.markerId.value.toString().startsWith('Lodge')));
                  print('removed Lodge');
                }
                showLodgingMarkers = !showLodgingMarkers;
                setState(() {});
              },
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
              heroTag: 'Restaurant',
              onPressed: () {
                if (showRestaurantMarkers) {
                  getCurrentLocationData().then(
                    (value) {
                      myController.animateCamera(
                        CameraUpdate.newLatLngZoom(value, 12),
                      );
                      bool checkIfExist = _markers.contains((element) =>
                          element.markerId ==
                          const MarkerId('currentLocation'));
                      if (checkIfExist) {
                        _markers.removeWhere((element) =>
                            element.markerId ==
                            const MarkerId('currentLocation'));
                      }
                      _markers.add(
                        Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: value,
                          icon: currentLocationIcon,
                        ),
                      );
                      setState(() {});
                      getRestaurantLocations(value).then((value) {
                        print('Restaurant counts: ${value.length}');
                        _markers.removeWhere((element) => element.markerId
                            .toString()
                            .startsWith('Restaurant'));
                        int restaurantId = 0;
                        for (int i = 0; i < value.length; i++) {
                          _markers.add(
                            Marker(
                              position: LatLng(value[i].place!.latitude,
                                  value[i].place!.longitude),
                              infoWindow: InfoWindow(
                                title:
                                    '${value[i].name!} [${value[i].distance}]',
                                snippet: value[i].address,
                              ),
                              markerId: MarkerId(
                                'Restaurant-$restaurantId',
                              ),
                              icon: restaurantLocationIcon,
                            ),
                          );
                          restaurantId++;
                        }
                        _markers.forEach((element) {
                          print(element.infoWindow.title);
                        });
                        setState(() {});
                      });
                    },
                  );
                } else {
                  _markers.removeWhere((element) => element.markerId.value
                      .toString()
                      .startsWith('Restaurant'));
                  _markers.forEach((element) => print(element.markerId.value
                      .toString()
                      .startsWith('Restaurant')));
                  print('removed Restaurant');
                }
                showRestaurantMarkers = !showRestaurantMarkers;
                setState(() {});
              },
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
            PopupMenuButton<int>(
              onSelected: (value) {
                print(value);
                if (value == 2) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Are you sure?',
                        ),
                        content: const Text(
                          'Do you want to End the trip?',
                        ),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Yes'),
                            onPressed: () {


                              UserSecureStorage.getDetails(key: 'mobile')
                                  .then((value) {
                                if (value == widget.getTripModel.mobile) {
                                  UserSecureStorage.getToken().then(
                                    (value) async {
                                      endTrip(value!, widget.getTripModel.id!);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TripSummaryComplete(
                                            getTripModel: widget.getTripModel,
                                          ),
                                        ),
                                        // (route) => false
                                        // ModalRoute.withName('/'),
                                      );
                                      print('popall');
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) {
                                      //       return TripSummaryComplete(
                                      //           getTripModel:
                                      //               widget.getTripModel);
                                      //     },
                                      //   ),
                                      // );
                                      showToast(msg: 'Trip ended successfully');
                                    },
                                  );
                                } else {
                                  showToast(
                                      msg:
                                          'You do not have the privileges to end the trip');
                                }
                              });

// =======

//                               UserSecureStorage.getToken().then((value) async {
//                                 endTrip(value!, widget.getTripModel.id!);
//                               });

//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) {
//                                     return TripSummaryComplete(
//                                         getTripModel: widget.getTripModel);
//                                   },
//                                 ),
//                               );
// >>>>>>> vishwa_1

                              setState(() {
                                _markers.removeWhere((element) =>
                                    element.markerId.value.startsWith('ATM') ||
                                    element.markerId.value
                                        .startsWith('Restaurant') ||
                                    element.markerId.value
                                        .startsWith('Lodge') ||
                                    element.markerId.value.startsWith('Fuel') ||
                                    element.markerId.value
                                        .startsWith('currentLocation'));
                                // _markers.forEach((element) {
                                //   element.markerId.value.startsWith('ATM');
                                //   element.markerId.value
                                //       .startsWith('Restaurant');
                                //   element.markerId.value.startsWith('Lodge');
                                //   element.markerId.value
                                //       .startsWith('currentLocation');
                                //   element.markerId.value.startsWith('Fuel');
                                // });
                              });
                              // Navigator.of(context).pop();
                              // Navigator.of(context).pop();
                              // Navigator.of(context).pop();
                              // Navigator.of(context).push(route);
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  //Complete Trip
                  setState(() {
                    _markers.removeWhere((element) =>
                        element.markerId.value.startsWith('ATM') ||
                        element.markerId.value.startsWith('Restaurant') ||
                        element.markerId.value.startsWith('Lodge') ||
                        element.markerId.value.startsWith('Fuel') ||
                        element.markerId.value.startsWith('currentLocation'));
                    // _markers.forEach((element) {
                    //   element.markerId.value.startsWith('ATM');
                    //   element.markerId.value
                    //       .startsWith('Restaurant');
                    //   element.markerId.value.startsWith('Lodge');
                    //   element.markerId.value
                    //       .startsWith('currentLocation');
                    //   element.markerId.value.startsWith('Fuel');
                    // });
                  });
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text(
                    "Clear",
                    style: TextStyle(
                      color: Color(0xdd4E4E4E),
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text(
                    "End Trip",
                    style: TextStyle(
                      color: Color(0xdd4E4E4E),
                    ),
                  ),
                ),
                // popupmenu item 2
              ],
              color: Colors.white,
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.more_vert,
                color: Colors.orangeAccent,
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
              // setState(() {
              //   polygonLatLngs.add(point);
              //   _setPolygon();
              // });
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IgnorePointer(
              ignoring: chatDisable,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    chatDisable = true;
                  });
                  showToast(msg: 'loading chats');
                  UserSecureStorage.getToken().then(
                    (value) {
                      UserHttp.getNumber(value!).then(
                        (value1) {
                          UserHttp.getChats(widget.getTripModel.id!, value)
                              .then(
                            (value2) {
                              setState(() {
                                chatDisable = false;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ChatScreen(
                                      token: value,
                                      chatList: value2["chatDetails"],
                                      number: value1["mobile"],
                                      groupId: widget.getTripModel.id!,
                                      groupName: widget.getTripModel.tripName!,
                                      adminNumber: widget.getTripModel.mobile!,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
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
            ),
          ).paddingAll(14, 0, 0, 30),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 40,
              width: 40,
              child: FloatingActionButton(
                onPressed: () {
                  print('Current Location');
                  getCurrentLocationData().then((value) {
                    myController.animateCamera(
                      CameraUpdate.newLatLngZoom(value, 12),
                    );
                    bool checkIfExist = _markers.contains((element) =>
                        element.markerId == const MarkerId('currentLocation'));
                    if (checkIfExist) {
                      _markers.removeWhere((element) =>
                          element.markerId ==
                          const MarkerId('currentLocation'));
                    }
                    _markers.add(
                      Marker(
                        markerId: const MarkerId('currentLocation'),
                        position: value,
                        icon: currentLocationIcon,
                      ),
                    );
                    setState(() {});
                  });
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
      bottomNavigationBar: GestureDetector(
        onTap: () {
          setState(() {
            buttonController = !buttonController;
          });
          print(buttonController);
          UserSecureStorage.getToken().then((value) async {
            sendStatus(await getCurrentLocationData(), value!,
                widget.getTripModel.id!);
          });
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: kLargeMapButtonDecoration,
          child: Center(
            child: buttonController
                ? Image.asset(
                    "assets/images/google_maps/pause.png",
                    width: 20,
                  )
                : Image.asset(
                    "assets/images/google_maps/play.png",
                    width: 20,
                    color: Colors.white,
                  ),
          ),
        ),
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
