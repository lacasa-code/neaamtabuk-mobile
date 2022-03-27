import 'dart:async';
import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_pos/model/neerRecipentModel.dart';
import 'package:flutter_pos/model/direction_model.dart';
import 'package:flutter_pos/screens/delegateOrders.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/widget/OrderOverlay.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  String donation_id;
  String longitude;
  String latitude;
  String status_id;
  String dist;

  MapPage(
    this.status_id,
    this.donation_id,
    this.latitude,
    this.longitude,
    this.dist,
  );

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController _googleMapController;
  var initialCameraPosition =
      CameraPosition(zoom: 15.5, target: LatLng(30.44, 30.4));
  static const kGoogleApiKey = "AIzaSyCExg6JM8XtlBiccaYYssvALQujX9NA3xs";
  Marker _origin;
  Marker _destination;
  Directions _info;
  LocationData myLocation;

  int id;

  @override
  void initState() {
    SharedPreferences.getInstance().then((pref) => {
          setState(() {
            id = pref.getInt('user_id');
          }),
        });
print('f');
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   setState(() {
    //     initialCameraPosition = CameraPosition(
    //         zoom: 11.5,
    //         target: LatLng(currentLocation.latitude, currentLocation.latitude));
    //     _origin = Marker(
    //         markerId: MarkerId('start'),
    //         position:
    //         LatLng(currentLocation.latitude, currentLocation.latitude));
    //   });
    //
    //   DirectionsRepository();
    // });
    setState(() {
      _destination = Marker(
          markerId: MarkerId('Place'),
          position: LatLng(
              double.parse(widget.latitude), double.parse(widget.longitude)));
    });
    getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<Provider_control>(context);
    return Scaffold(
      appBar: AppBar(
        //  title: Center(child: Text(getTransrlate(context, 'LocationSelected'))),
        backgroundColor: theme.getColor(),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: initialCameraPosition == null
                ? Custom_Loading()
                : GoogleMap(
                    myLocationEnabled: true,
                    compassEnabled: true,
                    tiltGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    markers: {
                      if (_origin != null) _origin,
                      if (_destination != null) _destination
                    },
                    polylines: {
                      if (_info != null)
                        Polyline(
                          polylineId: const PolylineId('طريق الى المستفيد'),
                          color: theme.getColor(),
                          width: 5,
                          points: _info.polylinePoints
                              .map((e) => LatLng(e.latitude, e.longitude))
                              .toList(),
                        ),
                    },
                    initialCameraPosition: initialCameraPosition,
                    onMapCreated: (controller) =>
                        _googleMapController = controller,
                  ),
          ),
          if (_info != null)
            Positioned(
              top: 10.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (_origin != null)
                          TextButton(
                            onPressed: () => _googleMapController.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: _origin.position,
                                  zoom: 14.5,
                                  tilt: 50.0,
                                ),
                              ),
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.green,
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            child: Text('${getTransrlate(context, 'representative')}'),
                          ),
                        SizedBox(
                          width: 50,
                        ),
                        if (_destination != null)
                          TextButton(
                            onPressed: () => _googleMapController.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: _destination.position,
                                  zoom: 14.5,
                                  tilt: 50.0,
                                ),
                              ),
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.blue,
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            child:Text('${widget.status_id=="4"?getTransrlate(context, 'Donor'):getTransrlate(context, 'Beneficiary')}'),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '${getTransrlate(context, 'Time')}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                //  color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${_info.totalDuration}',
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                fontSize: 18.0,
                                //  color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            Text(
                              '${getTransrlate(context, 'distance')}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                //  color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${double.parse(widget.dist).toStringAsFixed(4)}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                //  color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            bottom: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 12, bottom: 0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(9.0),
                    ),
                    color: theme.getColor(),
                    onPressed: () async {
                      _launchMaps(LatLng(_origin.position.latitude,_origin.position.longitude));
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${getTransrlate(context, 'GotoGoogleMap')}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                widget.status_id == "4"
                    ? Container(
                        margin: EdgeInsets.only(top: 12, bottom: 0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(9.0),
                          ),
                          color: theme.getColor(),
                          onPressed: () async {
                            API(context).post(
                                'orderDelegate/${widget.donation_id}',
                                {}).then((value) {
                              print(value);
                              if (value['status'] == true) {

                                setState(() {
                                  widget.status_id = "3";
                                });
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ResultOverlay('${value['message']}')).whenComplete(() {
                                  Navigator.pop(context);
                                  Nav.routeReplacement(context, Delegate());
                                });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ResultOverlay('${value['message']}'));
                              }
                            });
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${getTransrlate(context, 'RequestAccept')}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : widget.status_id != "1"
                    ?  Container(
                        margin: EdgeInsets.only(top: 12, bottom: 0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(9.0),
                          ),
                          color: theme.getColor(),
                          onPressed: () async {
                            API(context).post(
                                'status/${widget.donation_id}',
                                {
                                  "status_id":"1"
                                }).then((value) {
                              print(value);
                              if (value['status'] == true) {

                                setState(() {
                                  widget.status_id = "1";
                                });
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ResultOverlay('${value['message']}')).whenComplete(() {
                                  Navigator.pop(context);
                                  Nav.routeReplacement(context, Delegate());
                                });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ResultOverlay('${value['message']}'));
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${getTransrlate(context, 'received')}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ) :Container(
                        margin: EdgeInsets.only(top: 12, bottom: 0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(9.0),
                          ),
                          color: theme.getColor(),
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (_) => OrderOverlay(
                                      donation_id: widget.donation_id,
                                    ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${getTransrlate(context, 'distribution')}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          // CameraUpdate.newCameraPosition(initialCameraPosition)
          _info != null
              ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
              : CameraUpdate.newCameraPosition(initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  DirectionsRepository() async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_origin.position.latitude},${_origin.position.longitude}&destination=${_destination.position.latitude},${_destination.position.longitude}&key=$kGoogleApiKey';
    print(url);
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      print(response.body);
      setState(() {
        _info = Directions.fromMap(jsonDecode(response.body));
      });
    } catch (exception, stackTrace) {
      showDialog(
        context: context,
        builder: (_) =>
            ResultOverlay("${getTransrlate(context, 'ConnectionFailed')}"),
      );
    } finally {}
  }

  void _addMarker(LatLng pos) async {
    setState(() {
      _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
    });
    DirectionsRepository();
  }

  getUserLocation() async {
    String error;
    Location location = new Location();
    try {
      //myLocation = await location.getLocation();
      var _locationData = await  Geolocator.getCurrentPosition();

      _goToPosition1(LatLng(_locationData.latitude, _locationData.longitude));
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        print(error);
      }
      myLocation = null;
    }
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  void _goToPosition1(LatLng latLng) {
    setState(() {
      initialCameraPosition = CameraPosition(zoom: 15, target: latLng);
    });
    _addMarker(latLng);
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition));

  }


  _launchMaps(LatLng latLng) async {
    String googleUrl =
        'comgooglemaps://?center=${latLng.latitude},${latLng.longitude}';
    String appleUrl =
        'https://maps.apple.com/?sll=${latLng.latitude},${latLng.longitude}';
    if (await canLaunch("comgooglemaps://")) {
      print('launching com googleUrl');
      await launch(googleUrl);
    } else if (await canLaunch(appleUrl)) {
      print('launching apple url');
      await launch(appleUrl);
    } else {
      throw 'Could not launch url';
    }
  }
}
