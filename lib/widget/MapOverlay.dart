import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/neerRecipentModel.dart';
import 'package:flutter_pos/screens/delegateOrders.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/register/register_form_model.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapOverlay extends StatefulWidget {
  Model model;
  MapOverlay(this.model);

  @override
  State<StatefulWidget> createState() => MapOverlayState();
}

class MapOverlayState extends State<MapOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  GoogleMapController _googleMapController;
  TextEditingController addressController = TextEditingController();

  var initialCameraPosition ;
  Marker _origin;
  Location location = new Location();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {

    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {

    });
    getLocation();

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<Provider_control>(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("${getTransrlate(context, "LocationSelected")}"),
                      initialCameraPosition==null?Custom_Loading():  Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          height: ScreenUtil.getWidth(context)/2,
                          child: GoogleMap(
                            myLocationEnabled: true,
                            compassEnabled: true,
                            tiltGesturesEnabled: false,
                            zoomControlsEnabled: false,
                            mapType: MapType.normal,
                            onLongPress: _addMarker,
                            onTap: _addMarker,
                            markers: {
                              if (_origin != null) _origin,
                            },
                            initialCameraPosition: initialCameraPosition,
                            onMapCreated: (controller) =>
                            _googleMapController = controller,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyTextFormField(
                          controller: addressController,
                          labelText: getTransrlate(context, 'AddressTitle'),
                          hintText: getTransrlate(context, 'AddressTitle'),
                          isEmail: true,
                          enabled: false,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return getTransrlate(context, 'requiredempty');
                            }
                            return null;
                          },
                          onSaved: (String value) {
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          width: ScreenUtil.getWidth(context),
                          margin: EdgeInsets.only(top: 12, bottom: 0),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(1.0),
                            ),
                            color: Colors.green,
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: Text(
                              getTransrlate(context, 'SaveAddress'),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
Location location=new Location();
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
      initialCameraPosition=CameraPosition(
          zoom: 15,
          target: LatLng(_locationData.latitude, _locationData.latitude));
    });
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 15,
        target: LatLng(_locationData.latitude, _locationData.latitude))));
    _addMarker(LatLng(_locationData.latitude, _locationData.latitude));

  }

  void _addMarker(LatLng pos) async {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
      });
      final coordinates = new Coordinates(
          pos.latitude, pos.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(
          coordinates);
      var first = addresses.first;
      addressController.text="${first.locality??''}, ${first.adminArea??''},${first.subLocality??''}, ${first.subAdminArea??''},${first.addressLine??''}, ${first.featureName??''},${first.thoroughfare??''}, ${first.subThoroughfare??''}";
 setState(() {
   widget.model.latitude="${pos.latitude}";
   widget.model.longitude="${pos.longitude}";
   widget.model.address = addressController.text;
 });

  }

  @override
  void dispose() {
    _googleMapController.dispose();
  }
}
