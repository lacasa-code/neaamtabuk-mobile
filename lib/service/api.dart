import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/screens/Maintenance.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API {
  BuildContext context;

  API(this.context) {
    getDeviceDetails();
  }
  String deviceName;
  String deviceVersion;
  String identifier;

  get(String url) async {
    final String full_url =
        '${GlobalConfiguration().getString('api_base_url')}$url';

    print(full_url);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      http.Response response = await http.get(full_url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString('token') ?? identifier}',
        //'Accept-Language': Provider.of<Provider_control>(context).getlocal(),
      });
      print(response.body);
      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: response.body,
            ));
      } else if (response.statusCode == 404) {
        Nav.route(
            context,
            Maintenance(
              erorr: full_url + '\n' + response.body,
            ));
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      //Nav.route(context, Maintenance());
    } finally {}
  }

  post(String url, Map<String, dynamic> body) async {
    final String full_url =
        '${GlobalConfiguration().getString('api_base_url')}$url';

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print("body =${body}");

    try {
      http.Response response = await http.post(full_url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${prefs.getString('token') ?? identifier}',
            // 'locale': Provider.of<Provider_control>(context).getlocal(),
          },
          body: json.encode(body));
      print("body =${jsonDecode(response.body)}");

      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: jsonDecode(response.body),
            ));
      } else if (response.statusCode == 404) {
        Nav.route(
            context,
            Maintenance(
              erorr: jsonDecode(response.body),
            ));
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {} finally {}
  }

  Put(String url, Map<String, dynamic> body) async {
    final String full_url =
        '${GlobalConfiguration().getString('api_base_url')}$url';

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
      print(jsonDecode(response.body));
      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: jsonDecode(response.body),
            ));
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {} finally {}
  }

  Delete(String url) async {
    final String full_url =
        '${GlobalConfiguration().getString('api_base_url')}$url';
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
      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: jsonDecode(response.body),
            ));
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {} finally {}
  }

  Future<String> getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android

      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    return identifier;
  }
}
