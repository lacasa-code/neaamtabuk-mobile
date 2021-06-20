import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/screens/Maintenance.dart';
import 'package:flutter_pos/screens/login.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API {
  BuildContext context;
  bool Check=true ;

  API(this.context,{Check}){
    if(Check==null){
       this.Check=true ;
    }else{
      this.Check=Check;
    }
  }

  String deviceName;
  String deviceVersion;
  String identifier;

  get(String url) async {
    final  full_url = Uri.parse(
        '${GlobalConfiguration().getString('api_base_url')}$url');
    //print(full_url);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      http.Response response = await http.get(full_url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString('token') ?? identifier}',
        //'Accept-Language': Provider.of<Provider_control>(context).getlocal(),
      });
      return getAction(response);
    } catch (exception,stackTrace) {
      print("exception >>>>>>>>>>>>>>>>>>= ${exception}");
      // await Sentry.captureException(
      //   exception,
      //   stackTrace: stackTrace,
      // );
    } finally {}
  }

  post(String url, Map<String, dynamic> body) async {
    final  full_url = Uri.parse(
        '${GlobalConfiguration().getString('api_base_url')}$url');

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //print("body =${body}");

    try {
      http.Response response = await http.post(full_url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${prefs.getString('token') ?? identifier}',
            // 'locale': Provider.of<Provider_control>(context).getlocal(),
          },
          body: json.encode(body));
      return getAction(response);
    } catch (e) {} finally {}
  }

  Put(String url, Map<String, dynamic> body) async {
    final  full_url = Uri.parse(
        '${GlobalConfiguration().getString('api_base_url')}$url');
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      http.Response response = await http.put(full_url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${prefs.getString('token') ?? identifier}',
            //'locale': Provider.of<Provider_control>(context).getlocal(),
          },
          body: json.encode(body));
      return getAction(response);
    } catch (e) {} finally {}
  }

  Delete(String url) async {
    final  full_url = Uri.parse(
        '${GlobalConfiguration().getString('api_base_url')}$url');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      http.Response response = await http.delete(
        full_url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token') ?? identifier}',
          // 'locale': Provider.of<Provider_control>(context).getlocal(),
        },
      );
      return getAction(response);
    } catch (e) {} finally {}
  }


  getAction(http.Response response) {
   if(Check) {
    // print(jsonDecode(response.body));
     if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: jsonDecode(response.body),
            ));
      } else if (response.statusCode == 401) {
        Nav.route(context, LoginPage());
      } else {
        return jsonDecode(response.body);
      }
    }else {
     return jsonDecode(response.body);
   }
  }

}
