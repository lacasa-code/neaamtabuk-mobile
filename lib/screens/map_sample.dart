
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
class MapSample extends StatefulWidget {

MapSample();

  @override
  MapSampleState createState() => MapSampleState();
}
class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(33.738045, 73.084488);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  static const kGoogleApiKey = "AIzaSyAALm9ApAqso6kmCh0uc2O_E0wFMmbm1K0";
  BitmapDescriptor customIcon;
  LocationData myLocation;
  final Set<Polyline>_polyline={};
  Map<PolylineId, Polyline> polylines = { };
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  Marker m;
  PolylinePoints polylinePoints = PolylinePoints();
  PolylineResult result ;
  List<LatLng> latlng = List();
  LatLng _new = LatLng(33.738045, 73.084488);
  LatLng _news = LatLng(33.567997728, 72.635997456);



  _onMapCreated(GoogleMapController controller) {

    _controller.complete(controller);
    latlng.add(_new);
    latlng.add(_news);
 setState(() {
   _markers.add(Marker(markerId: MarkerId('start'),position: LatLng(33.738045, 73.084488)));
   _markers.add(Marker(markerId: MarkerId('end'),position: LatLng(33.567997728, 72.635997456)));
   _polyline.add(Polyline(
     polylineId: PolylineId(_lastMapPosition.toString()),
     visible: true,
     //latlng is List<LatLng>
     points: latlng,
     color: Colors.red,
   )
   );
 });
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }


  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/images/logo.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      heroTag: 'location',
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Provider.of<Provider_control>(context).getColor(),
      child: Icon(
        icon,
        size: 36.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text(getTransrlate(context, 'LocationSelected'))),
        backgroundColor: Provider.of<Provider_control>(context).getColor(),
        actions: <Widget>[
        ],
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 9.0,
        ),
        mapType: _currentMapType,
        markers: _markers,
        polylines: _polyline,
        onCameraMove: _onCameraMove,
      ),
    );
  }
  getUserLocationAddress(LatLng latLng) async {
    //call this async method from whereever you need
    try {
      final coordinates = new Coordinates(
          latLng.latitude, latLng.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(
          coordinates);
      var first = addresses.first;

        //address_shiping=new Addresses(city:first.adminArea,address:first.addressLine,);

      return first;

    } catch (e) {
      print(e);
    }

  }
  getUserLocation() async {
  //   print('fooooo');
  //   //call this async method from whereever you need
  //   String error;
  //   Location location = new Location();
  //   try {
  //   //  myLocation = await location.getLocation();
  //   } on PlatformException catch (e) {
  //     if (e.code == 'PERMISSION_DENIED') {
  //       error = 'please grant permission';
  //       print(error);
  //     }
  //     if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
  //       error = 'permission denied- please enable it from app settings';
  //       print(error);
  //     }
  //     myLocation = null;
  //   }
  //
  //   LatLng latLng=new LatLng(myLocation.latitude, myLocation.longitude);
  //   setState(() {
  //     _markers.add(Marker(markerId: MarkerId('1'), icon: customIcon, position:latLng ));
  //   });
  //   _goToPosition1(myLocation.latitude, myLocation.longitude);
  //   getUserLocationAddress(latLng);
   }
  getUserinformation() async {
    //call this async method from whereever you need
    String error;
    Location location = new Location();

    //
    // LatLng latLng=new LatLng(widget.address_shiping.lat, widget.address_shiping.lang);
    // setState(() {
    //   _markers.add(Marker(markerId: MarkerId('1'), icon: customIcon, position:latLng ));
    // });
    // _goToPosition1(widget.address_shiping., widget.address_shiping.lang);
    // getUserLocationAddress(latLng);
  }


    _navigateAndDisplaySelection(BuildContext context) async {

    // address_shiping= await Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => EditAddressPage(address_shiping))
    // );
    Navigator.pop(context);


  }

}