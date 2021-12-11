import 'dart:async';
import 'package:cst/services/api.dart';
import 'package:cst/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Future<List> mapdata;
  List<Marker> citymarkers = [];
  List<Marker> revmarkers = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    Future<List> getmapdata() async {
      final prefs = await SharedPreferences.getInstance();
      final long = prefs.getDouble('longitude') ?? 80.70;
      final lat = prefs.getDouble('lattitude') ?? 7.90;
      final zoom = prefs.getDouble('zoom') ?? 7.5;
      var loc = [];
      await fetchMap().then((items) {
        for (var each in items) {
          var item = [];
          item.add(each.city);
          item.add(each.long);
          item.add(each.lat);
          item.add(each.count);
          loc.add(item);
        }
      });
      await _islocationon();
      return Future<List>.value([long, lat, zoom, loc]);
    }

    mapdata = getmapdata();
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'disabled';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'disabled';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 'disabled';
    }

    return await Geolocator.getCurrentPosition();
  }

  _createMarkers(markers) {
    for (var mark in markers) {
      citymarkers.add(Marker(
        point: LatLng(mark[2], mark[1]),
        builder: (context) => IconButton(
          icon: const Icon(Icons.circle_rounded),
          color: Colors.blue,
          iconSize: 15.0,
          onPressed: () {
            alert() {
              return showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(mark[0]),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('Patient count = ' + mark[3].toString())
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }

            alert();
          },
        ),
      ));
    }
    revmarkers = citymarkers.reversed.toList();
  }

  _islocationon() async {
    var currentLocation = await _determinePosition();
    if (currentLocation == 'disabled') {
      alert() {
        return showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Can not access the Location'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: const <Widget>[
                      Text('Please turn on your location')
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }

      alert();
    } else {
      citymarkers.add(Marker(
        point: LatLng(currentLocation.latitude, currentLocation.longitude),
        builder: (context) => IconButton(
            icon: const Icon(Icons.location_on),
            color: Colors.red,
            iconSize: 23.0,
            onPressed: () {
              alert() {
                return showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Your Location"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              }

              alert();
            }),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Covid Map'),
            ),
            drawer: NavigationDrawerWidget(),
            body: FutureBuilder<List>(
                future: mapdata,
                builder: (context, profD) {
                  if (profD.data != null) {
                    _createMarkers(profD.data![3]);
                    return Column(children: <Widget>[
                      MapBoxPlaceSearchWidget(
                        popOnSelect: false,
                        apiKey:
                            'pk.eyJ1IjoiaW1hc2hhOTMiLCJhIjoiY2t1dXNmb2pjMWV3azJub2QzeHhxdnRreCJ9.t5SN1m6yAvDiGANFJyAowA',
                        searchHint: 'Search by city name',
                        onSelected: (place) {
                          var mapZoom = 10.0;
                          setMapdata() async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setDouble('longitude', place.center[0]);
                            prefs.setDouble('lattitude', place.center[1]);
                            prefs.setDouble('zoom', mapZoom);
                          }

                          setMapdata();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MapPage()),
                          );
                        },
                        context: context,
                      ),
                      Expanded(
                        child: FlutterMap(
                          options: MapOptions(
                              center: LatLng(profD.data![1], profD.data![0]),
                              minZoom: 7.5,
                              zoom: profD.data![2]),
                          layers: [
                            TileLayerOptions(
                              urlTemplate:
                                  "https://api.mapbox.com/styles/v1/imasha93/ckww81aglflfv14ocr8mmy1rd/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaW1hc2hhOTMiLCJhIjoiY2t1dXNmb2pjMWV3azJub2QzeHhxdnRreCJ9.t5SN1m6yAvDiGANFJyAowA",
                              additionalOptions: {
                                'accessToken':
                                    'pk.eyJ1IjoiaW1hc2hhOTMiLCJhIjoiY2t1dXNmb2pjMWV3azJub2QzeHhxdnRreCJ9.t5SN1m6yAvDiGANFJyAowA',
                                'id': 'mapbox.mapbox-streets-v7',
                              },
                            ),
                            MarkerLayerOptions(markers: revmarkers),
                          ],
                        ),
                      ),
                    ]);
                  } else {
                    return const Text("Loading...",
                        textScaleFactor: 2,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center);
                  }
                })));
  }
}
