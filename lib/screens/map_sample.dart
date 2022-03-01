import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_pos/model/RecipentModel.dart';
import 'package:flutter_pos/screens/delegateOrders.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapSample extends StatefulWidget {
  MapSample(this.donation_id,this.longitude, this.latitude);

  int donation_id;
  String longitude;
  String latitude;

  @override
  MapSampleState createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = LatLng(30, 30);
  MapType _currentMapType = MapType.normal;
  static const kGoogleApiKey = "AIzaSyAALm9ApAqso6kmCh0uc2O_E0wFMmbm1K0";
  BitmapDescriptor customIcon;
  LocationData myLocation;
  final Set<Polyline> _polyline = {};
  Map<PolylineId, Polyline> polylines = {};
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  Marker m;
  PolylinePoints polylinePoints = PolylinePoints();
  PolylineResult result;
  Recipent trakers;
  List<LatLng> latlng = List();
  Position currentLocation;
  List<Recipent> recipent;

  _onMapCreated(GoogleMapController controller) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    _controller.complete(controller);

    currentLocation = await locateUser();

    setState(() {
      latlng.add(LatLng(currentLocation.latitude, currentLocation.latitude));
      latlng.add(LatLng(
          double.parse(widget.latitude), double.parse(widget.longitude)));
      _markers.add(Marker(
          markerId: MarkerId('start'),
          position:
              LatLng(currentLocation.latitude, currentLocation.latitude)));
      _markers.add(Marker(
          markerId: MarkerId('end'),
          position: LatLng(
              double.parse(widget.latitude), double.parse(widget.longitude))));
      _polyline.add(Polyline(
        polylineId: PolylineId("1"),
        visible: true,
        //latlng is List<LatLng>
        points: latlng,
        color: Colors.red,
      ));
    });
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition();
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
  void initState() {
    API(context).get('nearRecipent').then((value) {
      if (value != null) {
        setState(() {
          recipent = RecipentModel.fromJson(value).data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text(getTransrlate(context, 'LocationSelected'))),
        backgroundColor: Provider.of<Provider_control>(context).getColor(),
        actions: <Widget>[],
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _lastMapPosition,
                zoom: 9.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              polylines: _polyline,
              onCameraMove: _onCameraMove,
            ),
          ),
          Container(
            height: 200,
            color: Colors.white,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: Text(
                          "${getTransrlate(context, 'nearRecipent')}",
                        )),
                  ),
                  recipent == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 10.0, bottom: 10),
                          child: DropdownSearch<Recipent>(
                            maxHeight: 120,
                            dropdownBuilder: (context, item) {
                              return item == null
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(" ${item?.username} "),
                                    );
                            },
                            validator: (Recipent item) {
                              if (item == null) {
                                return "${getTransrlate(context, 'requiredempty')}";
                              } else
                                return null;
                            },
                            items: recipent,
                            popupItemBuilder: _customPopupItemBuilderExample,
                            //  onFind: (String filter) => getData(filter),
                            onChanged: (Recipent u) {
                              setState(() {
                                trakers = u;
                                widget.latitude = trakers.latitude;
                                widget.longitude = trakers.longitude;
                              });
                            },
                            itemAsString: (Recipent u) => " ${u.username} ",
                          )),
                  trakers == null
                      ? Container()
                      : Container(
                          height: 40,
                          //width: ScreenUtil.getWidth(context),
                          margin: EdgeInsets.only(top: 12, bottom: 0),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(1.0),
                            ),
                            color: themeColor.getColor(),
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                API(context).post('order', {
                                  'donation_id': widget.donation_id,
                                  'recipient_id': trakers.id,
                                  'status_id': 1,
                                }).then((value) {
                                  print(value);
                                  if (value['status'] == true) {
                                    Navigator.pop(context);
                                    Nav.routeReplacement(context, Delegate());

                                    showDialog(
                                        context: context,
                                        builder: (_) => ResultOverlay(
                                            '${value['message']}'));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => ResultOverlay(
                                            '${value['message']}'));

                                  }
                                });
                              }
                            },
                            child: Text(
                              getTransrlate(context, 'placeorder'),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  getUserLocationAddress(LatLng latLng) async {
    //call this async method from whereever you need
    try {
      final coordinates = new Coordinates(latLng.latitude, latLng.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
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

  Widget _customPopupItemBuilderExample(
      BuildContext context, Recipent item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.username ?? ''),
        subtitle: Text(item?.address?.toString() ?? ''),
        leading: CircleAvatar(
          child: Text("${item?.distance?.toString() ?? ''}K"),
        ),
      ),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // address_shiping= await Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => EditAddressPage(address_shiping))
    // );
    Navigator.pop(context);
  }
}
