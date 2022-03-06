import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_pos/model/direction_model.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';



class MapPage extends StatefulWidget {

  String donation_id;
  String longitude;
  String latitude;

  MapPage(this.donation_id, this.longitude, this.latitude);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController _googleMapController;
var  initialCameraPosition ;
  static const kGoogleApiKey = "AIzaSyCExg6JM8XtlBiccaYYssvALQujX9NA3xs";

  Marker _origin;
  Marker _destination;
  Directions _info;
  @override
  void initState() {
    setState(() {
      _destination=Marker(
          markerId: MarkerId('Place'),
          position:
          LatLng(double.parse(widget.latitude), double.parse(widget.longitude)));
    });
    getLocation();

    super.initState();
  }
  _onMapCreated(GoogleMapController controller) async {
    initialCameraPosition = CameraPosition(
        zoom: 11.5,
        target: LatLng(37.77, 37.77)
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(getTransrlate(context, 'LocationSelected'))),
        backgroundColor: Provider.of<Provider_control>(context).getColor(),
        actions: <Widget>[],
      ),        body: Stack(
          children: [
            Positioned.fill(
              child: GoogleMap(
                myLocationEnabled: true,
                compassEnabled: false,
                tiltGesturesEnabled: false,
                zoomControlsEnabled: true,
                mapType: MapType.normal,
                markers: {
                  if(_origin!=null)_origin,
                  if(_destination!=null)_destination
                },
                polylines: {
                  if (_info != null)
                    Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: Colors.red,
                      width: 5,
                      points: _info.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                },
                initialCameraPosition: initialCameraPosition,
                onMapCreated: (controller)=>_onMapCreated(controller),
              ),
            ),
            if (_info != null)
              Positioned(
                top: 50.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.yellowAccent,
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
                      Text(
                        '${_info.totalDuration}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${_info.totalDistance}}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(initialCameraPosition)
          // _info != null
          //     ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
          //     : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
@override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }
  DirectionsRepository() async {
    String url ='https://maps.googleapis.com/maps/api/directions/json?origin=${_origin.position.latitude},${_origin.position.longitude}&destination=${_destination.position.latitude},${_destination.position.longitude}&key=$kGoogleApiKey';
    print(url);
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      print(response.body);
      setState(() {
        _info= Directions.fromMap(jsonDecode(response.body));

      });
    } catch (exception, stackTrace) {
      showDialog(
        context: context,
        builder: (_) => ResultOverlay(
            "${getTransrlate(context, 'ConnectionFailed')}"),
      );
    } finally {}  }

  Future<void> getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      initialCameraPosition = CameraPosition(
          zoom: 11.5,
          target: LatLng(_locationData.latitude, _locationData.latitude)
      );
      _origin=Marker(
          markerId: MarkerId('start'),
          position:
          LatLng(_locationData.latitude, _locationData.latitude));
    });
    DirectionsRepository();
  }

}

