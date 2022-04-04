import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/utils/shared_prefs_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  ProviderControl themeColor;
  // Provider_Data _providerData;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 0), () => _auth());
  }

  @override
  Widget build(BuildContext context) {
    themeColor = Provider.of<ProviderControl>(context);
    // _providerData = Provider.of<Provider_Data>(context);
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
          // image: DecorationImage(
          //   image: new ExactAssetImage('assets/images/splashscreen.png'),
          //   fit: BoxFit.cover,
          // ),
          color: Colors.white,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // height: ScreenUtil.getHeight(context) / 2,
                  // width: ScreenUtil.getWidth(context) / 1.5,
                  child: Image.asset(
                    'assets/images/logoIcon.png',
                  ),
                ),
                Container(
                  // height: ScreenUtil.getHeight(context) / 2,
                  // width: ScreenUtil.getWidth(context) / 1.5,
                  child: Image.asset(
                    'assets/images/logoText.png',
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
    var sharedPreferences =
        Provider.of<SharedPrefsProvider>(context, listen: false);
    final SharedPreferences prefs = await sharedPreferences.getInstance();

    API(context, Check: false).get('isValidToken').then((value) async {
      if (value != null) {
        if (value['status'] == true) {
          themeColor.setLogin(true);
          // var user = value['data'];
          // prefs.setString("user_email", "${user['email']}");
          // prefs.setString("user_name", "${user['name']}");
          // prefs.setInt("user_id", user['id']);
          themeColor.setLogin(true);
          Nav.routeReplacement(context, Home());
        } else {
          themeColor.setLogin(false);
          SharedPreferences.getInstance().then((prefs) {
            prefs.clear();
          });
          Nav.routeReplacement(context, LoginPage());
        }
      }
    });
  }
}
