import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/model/direction_model.dart';
import 'package:flutter_pos/model/neerRecipentModel.dart';
import 'package:flutter_pos/screens/delegateOrders.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/screens/tab_screen.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/home_provider.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/utils/shared_prefs_provider.dart';
import 'package:flutter_pos/utils/tab_provider.dart';
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
  String donationId;
  String donationlongitude;
  String donationLatitude;
  String statusId;
  String dist;
  final String donationName;

  MapPage({
    Key key,
    this.statusId,
    this.donationId,
    this.donationLatitude,
    this.donationlongitude,
    this.dist,
    this.donationName,
  }) : super(key: key);

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
  Set<Marker> _recipentMarkers = {};
  int id;
  var isInit = true;
  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    _googleMapController.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    // print(l1.toString());
    // print(l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
      check(u, c);
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((pref) => {
          setState(() {
            id = pref.getInt('user_id');
          }),
        });
    print('f');
    if (widget.statusId == '1') {
      API(context).get('nearRecipent').then((value) {
        log('response :: ${value ?? 'null '}');
        if (value != null) {
          List<NearRecipent> recipent = NearRecipentModel.fromJson(value).data;
          if (recipent.isNotEmpty) {
            Set<Marker> apiRecipentMarkers = {};
            for (var i = 0; i < recipent.length; i++) {
              var singleMarker = Marker(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => OrderOverlay(
                      donation_id: widget.donationId,
                    ),
                  );
                },
                markerId: MarkerId('Place'),
                position: LatLng(
                  double.parse(recipent[i].latitude),
                  double.parse(recipent[i].longitude),
                ),
                infoWindow: InfoWindow(
                    title: recipent[i].username,
                    snippet:
                        '${getTransrlate(context, 'family_members')}: ${recipent[i].family_members}  ${getTransrlate(context, 'phone')} : ${recipent[i].mobile}'),
              );
              apiRecipentMarkers.add(singleMarker);
            }
            setState(() {
              _recipentMarkers = apiRecipentMarkers;
            });
          }
        }
      });
    }
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
    // getUserLocation();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      var prefs =
          Provider.of<SharedPrefsProvider>(context, listen: false).prefs;
      setState(() {
        _origin = Marker(
          markerId: MarkerId('myLocation'),
          position: LatLng(
            double.parse(prefs.getString('lat') ?? '0.0'),
            double.parse(prefs.getString('lang') ?? '0.0'),
          ),
          infoWindow: InfoWindow(title: prefs.getString('user_name')),
        );
        _destination = Marker(
          markerId: MarkerId('Place'),
          position: LatLng(
            double.parse(widget.donationLatitude),
            double.parse(widget.donationlongitude),
          ),
          infoWindow: InfoWindow(title: widget.donationName),
        );
      });
      directionsRepository();

      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ProviderControl>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //  title: Center(child: Text(getTransrlate(context, 'LocationSelected'))),
        // backgroundColor: theme.getColor(),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: ImageIcon(
            AssetImage(
              'assets/icons/arrowBack.png',
            ),
          ),
          color: theme.getColor(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          getTransrlate(
            context,
            'OrderTrack',
          ),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Visibility(
            visible: widget.statusId != '1',
            child: Container(
              height: ScreenUtil.getHeight(context) * 0.07,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${getTransrlate(context, 'Beneficiary')} : ${double.tryParse(widget.dist ?? '0.0').toStringAsFixed(4)} Km',
                    style: TextStyle(fontSize: 15, color: Color(0xff6AC088)),
                  ),
                  Text(
                    '${getTransrlate(context, 'representative')} : ${_info?.totalDuration ?? ''}',
                    style: TextStyle(fontSize: 15, color: Color(0xff6AC088)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: initialCameraPosition == null
                      ? Custom_Loading()
                      : GoogleMap(
                          myLocationEnabled: true,
                          compassEnabled: true,
                          tiltGesturesEnabled: false,
                          // zoomControlsEnabled: false,
                          // mapType: MapType.satellite,
                          markers: {
                            if (_origin != null) _origin,
                            if (_destination != null) _destination,
                            if (_recipentMarkers.isNotEmpty) ..._recipentMarkers
                          },
                          // polylines: {
                          //   if (_info != null)
                          //     Polyline(
                          //       polylineId:
                          //           const PolylineId('طريق الى المستفيد'),
                          //       color: theme.getColor(),
                          //       width: 5,
                          //       points: _info.polylinePoints
                          //           .map((e) => LatLng(e.latitude, e.longitude))
                          //           .toList(),
                          //     ),
                          // },
                          initialCameraPosition: initialCameraPosition,
                          onMapCreated: (controller) {
                            setState(() {
                              _googleMapController = controller;
                              LatLngBounds bound;
                              if (_origin.position.latitude >
                                      _destination.position.latitude &&
                                  _origin.position.longitude >
                                      _destination.position.longitude) {
                                bound = LatLngBounds(
                                    southwest: _destination.position,
                                    northeast: _origin.position);
                              } else if (_origin.position.longitude >
                                  _destination.position.longitude) {
                                bound = LatLngBounds(
                                    southwest: LatLng(_origin.position.latitude,
                                        _destination.position.longitude),
                                    northeast: LatLng(
                                        _destination.position.latitude,
                                        _origin.position.longitude));
                              } else if (_origin.position.latitude >
                                  _destination.position.latitude) {
                                bound = LatLngBounds(
                                    southwest: LatLng(
                                        _destination.position.latitude,
                                        _origin.position.longitude),
                                    northeast: LatLng(_origin.position.latitude,
                                        _destination.position.longitude));
                              } else {
                                bound = LatLngBounds(
                                    southwest: _origin.position,
                                    northeast: _destination.position);
                              }

                              CameraUpdate u2 =
                                  CameraUpdate.newLatLngBounds(bound, 50);
                              controller.animateCamera(u2).then((void v) {
                                check(u2, controller);
                              });

                              // _controller./
                            });
                          },
                        ),
                ),
                /*   if (_info != null)
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
                                  onPressed: () =>
                                      _googleMapController.animateCamera(
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
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  child: Text(
                                      '${getTransrlate(context, 'representative')}'),
                                ),
                              SizedBox(
                                width: 50,
                              ),
                              if (_destination != null)
                                TextButton(
                                  onPressed: () =>
                                      _googleMapController.animateCamera(
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
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  child: Text(
                                      '${widget.statusId == "4" ? getTransrlate(context, 'Donor') : getTransrlate(context, 'Beneficiary')}'),
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
                  ),*/
                // Positioned(
                // bottom: 15,
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Container(
                //       margin: EdgeInsets.only(top: 12, bottom: 0),
                //       child: FlatButton(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: new BorderRadius.circular(9.0),
                //         ),
                //         color: theme.getColor(),
                //         onPressed: () async {
                //           _launchMaps(LatLng(_origin.position.latitude,
                //               _origin.position.longitude));
                //         },
                //         child: Center(
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Text(
                //               "${getTransrlate(context, 'GotoGoogleMap')}",
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 fontSize: 16,
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.w400,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     widget.status_id == "4"
                //         ? Container(
                //             margin: EdgeInsets.only(top: 12, bottom: 0),
                //             child: FlatButton(
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: new BorderRadius.circular(9.0),
                //               ),
                //               color: theme.getColor(),
                //               onPressed: () async {
                //                 API(context).post(
                //                     'orderDelegate/${widget.donation_id}',
                //                     {}).then((value) {
                //                   print(value);
                //                   if (value['status'] == true) {
                //                     setState(() {
                //                       widget.status_id = "3";
                //                     });
                //                     showDialog(
                //                             context: context,
                //                             builder: (_) => ResultOverlay(
                //                                 '${value['message']}'))
                //                         .whenComplete(() {
                //                       Navigator.pop(context);
                //                       Nav.routeReplacement(context, Delegate());
                //                     });
                //                   } else {
                //                     showDialog(
                //                         context: context,
                //                         builder: (_) =>
                //                             ResultOverlay('${value['message']}'));
                //                   }
                //                 });
                //               },
                //               child: Center(
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Text(
                //                     "${getTransrlate(context, 'RequestAccept')}",
                //                     textAlign: TextAlign.center,
                //                     style: TextStyle(
                //                       fontSize: 16,
                //                       color: Colors.white,
                //                       fontWeight: FontWeight.w400,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           )
                //         : widget.status_id != "1"
                //             ? Container(
                //                 margin: EdgeInsets.only(top: 12, bottom: 0),
                //                 child: FlatButton(
                //                   shape: RoundedRectangleBorder(
                //                     borderRadius: new BorderRadius.circular(9.0),
                //                   ),
                //                   color: theme.getColor(),
                //                   onPressed: () async {
                //                     API(context).post(
                //                         'status/${widget.donation_id}',
                //                         {"status_id": "1"}).then((value) {
                //                       print(value);
                //                       if (value['status'] == true) {
                //                         setState(() {
                //                           widget.status_id = "1";
                //                         });
                //                         showDialog(
                //                                 context: context,
                //                                 builder: (_) => ResultOverlay(
                //                                     '${value['message']}'))
                //                             .whenComplete(() {
                //                           Navigator.pop(context);
                //                           Nav.routeReplacement(context, Delegate());
                //                         });
                //                       } else {
                //                         showDialog(
                //                             context: context,
                //                             builder: (_) => ResultOverlay(
                //                                 '${value['message']}'));
                //                       }
                //                     });
                //                   },
                //                   child: Padding(
                //                     padding: const EdgeInsets.all(8.0),
                //                     child: Text(
                //                       "${getTransrlate(context, 'received')}",
                //                       style: TextStyle(
                //                         fontSize: 16,
                //                         color: Colors.white,
                //                         fontWeight: FontWeight.w400,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               )
                //             : Container(
                //                 margin: EdgeInsets.only(top: 12, bottom: 0),
                //                 child: FlatButton(
                //                   shape: RoundedRectangleBorder(
                //                     borderRadius: new BorderRadius.circular(9.0),
                //                   ),
                //                   color: theme.getColor(),
                //                   onPressed: () async {
                //                     showDialog(
                //                         context: context,
                //                         builder: (_) => OrderOverlay(
                //                               donation_id: widget.donation_id,
                //                             ));
                //                   },
                //                   child: Padding(
                //                     padding: const EdgeInsets.all(8.0),
                //                     child: Text(
                //                       "${getTransrlate(context, 'distribution')}",
                //                       style: TextStyle(
                //                         fontSize: 16,
                //                         color: Colors.white,
                //                         fontWeight: FontWeight.w400,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //   ],
                // ),
                // )
              ],
            ),
          ),
          Container(
            height: ScreenUtil.getHeight(context) * 0.17,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 42,
                  width: ScreenUtil.getWidth(context) * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff2CA649),
                        Color(0xff2CA649),
                        Color(0xff4BB146),
                        Color(0xff4BB146),
                        Color(0xff66BA44),
                        Color(0xff77C042),
                      ],
                    ),
                  ),
                  margin: EdgeInsets.only(top: 12, bottom: 0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(9.0),
                    ),
                    onPressed: () async {
                      _launchMaps(LatLng(_origin.position.latitude,
                          _origin.position.longitude));
                    },
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
                widget.statusId == "4"
                    ? Container(
                        height: 42,
                        width: ScreenUtil.getWidth(context) * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff2CA649),
                              Color(0xff2CA649),
                              Color(0xff4BB146),
                              Color(0xff4BB146),
                              Color(0xff66BA44),
                              Color(0xff77C042),
                            ],
                          ),
                        ),
                        margin: EdgeInsets.only(top: 12, bottom: 0),
                        child: FlatButton(
                          onPressed: () async {
                            API(context).post(
                                'orderDelegate/${widget.donationId}',
                                {}).then((value) {
                              print(value);
                              if (value['status'] == true) {
                                setState(() {
                                  widget.statusId = "3";
                                });
                                showDialog(
                                    context: context,
                                    builder: (_) => ResultOverlay(
                                          '${value['message']}',
                                          success: true,
                                        )).whenComplete(() {
                                  Navigator.pop(context);
                                  Nav.routeReplacement(
                                    context,
                                    MultiProvider(
                                      providers: [
                                        ChangeNotifierProvider(
                                          create: (_) => TabProvider(),
                                        ),
                                        ChangeNotifierProvider(
                                          create: (_) =>
                                              HomeProvider(currentTabIndex: 1),
                                        ),
                                      ],
                                      child: TabScreen(homeTabIndex: 1),
                                    ),
                                  );
                                  // Nav.routeReplacement(context, Delegate());
                                });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ResultOverlay('${value['message']}'));
                              }
                            });
                          },
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
                      )
                    : widget.statusId != "1"
                        ? Container(
                            height: 42,
                            width: ScreenUtil.getWidth(context) * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff2CA649),
                                  Color(0xff2CA649),
                                  Color(0xff4BB146),
                                  Color(0xff4BB146),
                                  Color(0xff66BA44),
                                  Color(0xff77C042),
                                ],
                              ),
                            ),
                            margin: EdgeInsets.only(top: 12, bottom: 0),
                            child: FlatButton(
                              onPressed: () async {
                                API(context).post('status/${widget.donationId}',
                                    {"status_id": "1"}).then((value) {
                                  print(value);
                                  if (value['status'] == true) {
                                    setState(() {
                                      widget.statusId = "1";
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (_) => ResultOverlay(
                                              '${value['message']}',
                                              success: true,
                                            )).whenComplete(() {
                                      // Provider.of<HomeProvider>(context,
                                      //         listen: false)
                                      //     .changeTabIndex(1);
                                      Navigator.pop(context);
                                      Nav.routeReplacement(
                                        context,
                                        MultiProvider(
                                          providers: [
                                            ChangeNotifierProvider(
                                              create: (_) => TabProvider(),
                                            ),
                                            ChangeNotifierProvider<
                                                HomeProvider>(
                                              create: (_) => HomeProvider(
                                                  currentTabIndex: 1)
                                                ..changeTabIndex(1),
                                            ),
                                          ],
                                          child: TabScreen(homeTabIndex: 1),
                                        ),
                                      );
                                    });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => ResultOverlay(
                                            '${value['message']}'));
                                  }
                                });
                              },
                              child: Text(
                                "${getTransrlate(context, 'received')}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 42,
                            width: ScreenUtil.getWidth(context) * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff2CA649),
                                  Color(0xff2CA649),
                                  Color(0xff4BB146),
                                  Color(0xff4BB146),
                                  Color(0xff66BA44),
                                  Color(0xff77C042),
                                ],
                              ),
                            ),
                            margin: EdgeInsets.only(top: 12, bottom: 0),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(9.0),
                              ),
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (_) => OrderOverlay(
                                          donation_id: widget.donationId,
                                        ));
                              },
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
              ],
            ),
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      //   onPressed: () => _googleMapController.animateCamera(
      //     // CameraUpdate.newCameraPosition(initialCameraPosition)
      //     _info != null
      //         ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
      //         : CameraUpdate.newCameraPosition(initialCameraPosition),
      //   ),
      //   child: const Icon(Icons.center_focus_strong),
      // ),
    );
  }

  directionsRepository() async {
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
    // setState(() {
    //   _origin = Marker(
    //     markerId: const MarkerId('origin'),
    //     infoWindow: const InfoWindow(title: 'Origin'),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    //     position: pos,
    //   );
    // });
    directionsRepository();
  }

  getUserLocation() async {
    String error;
    Location location = new Location();
    try {
      //myLocation = await location.getLocation();
      var permission = await Geolocator.requestPermission();
      var _locationData = await Geolocator.getCurrentPosition();

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
    _googleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition));
  }

  _launchMaps(LatLng latLng) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${latLng.latitude},${latLng.longitude}';
    String appleUrl =
        'https://maps.apple.com/?sll=${latLng.latitude},${latLng.longitude}';
    if (Platform.isAndroid) {
      print('launching com googleUrl');
      await launch(googleUrl);
    } else if (Platform.isIOS) {
      print('launching apple url');
      await launch(appleUrl);
    } else {
      throw 'Could not launch url';
    }
  }
}
