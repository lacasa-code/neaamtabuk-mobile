import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Provider_control themeColor;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => _auth());
  }

  @override
  Widget build(BuildContext context) {
    themeColor = Provider.of<Provider_control>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: themeColor.getColor(),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      backgroundColor: themeColor.getColor(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: ScreenUtil.getHeight(context) / 2,
                width: ScreenUtil.getWidth(context) / 1.5,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                'Card Net Powered By 7lSoft',
                style: TextStyle(
                    fontWeight: FontWeight.w800, color: themeColor.getColor()),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _auth() async {
    // API(context).get('profile').then((value) {
    //   if(value!=null){
    //     if(value['status']!='error'){
    //       themeColor.setLogin(true);
    //     }
    //     else{
    //       themeColor.setLogin(false);
    //       SharedPreferences.getInstance().then((prefs) {
    //         prefs.clear();
    //       });
    //     }
    //   }
    // });
    Nav.routeReplacement(context, Home());
  }
}
