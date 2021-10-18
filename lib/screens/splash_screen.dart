import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Provider_control themeColor;
  Provider_Data _provider_data;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => _auth());
  }

  @override
  Widget build(BuildContext context) {
    themeColor = Provider.of<Provider_control>(context);
    _provider_data = Provider.of<Provider_Data>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: themeColor.getColor(),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      backgroundColor: themeColor.getColor(),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          image: DecorationImage(
            image: new ExactAssetImage('assets/images/splashscreen.png'),
            fit: BoxFit.cover,
          ),
          color: Color(0xff27332F),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: ScreenUtil.getHeight(context) / 2,
                  width: ScreenUtil.getWidth(context) / 1.5,
                  child: Image.asset(
                    'assets/images/splashscreen-trkar-logo-white.gif',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _auth() async {
    //themeColor.setCar_made(getTransrlate(context, 'selectCar'));
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();
    API(context,Check: false).post('check/valid/session', {}).then((value) async {

      if (value != null) {

        if (value['status_code'] == 200) {
          themeColor.setLogin(true);
          var user = value['data'];
          if (user.containsKey('vendor_details')) {
            prefs.setInt(
                "complete", user['vendor_details']['complete']);
            prefs.setString("vendor", 'vendor');

          }

          prefs.setString("user_email", "${user['email']}");
          prefs.setString("user_name", "${user['name']}");
       //   prefs.setString("token", "${user['token']}");
          prefs.setInt("user_id", user['id']);


          Nav.routeReplacement(context, Home());

        } else {
          themeColor.setLogin(false);
          themeColor.setComplete(1);
          SharedPreferences.getInstance().then((prefs) {
            prefs.clear();
          });
          Nav.routeReplacement(context, Home());

        }
      }
    });
  }
}
