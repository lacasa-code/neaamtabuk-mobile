import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/tab_screen.dart';
import 'package:flutter_pos/utils/tab_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as util;
import 'package:flutter/services.dart';
import 'package:flutter_pos/screens/about_page.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/screens/account/user_information.dart';
import 'package:flutter_pos/screens/contact_page.dart';
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
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: util.ScreenUtil().setHeight(70),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/logoIcon.png',
                        // width: ScreenUtil.getWidth(context) / 2,
                      ),
                      // height: ScreenUtil.getHeight(context) / 4,
                    ),
                    Positioned(
                      right: -util.ScreenUtil().setWidth(80),
                      left: -util.ScreenUtil().setWidth(80),
                      bottom: -util.ScreenUtil().setWidth(110),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Image.asset(
                            'assets/images/logoText.png',
                            // width: ScreenUtil.getWidth(context) / 2,
                          ),
                          // height: ScreenUtil.getHeight(context) / 4,
                        ),
                      ),
                    ),
                  ],
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
          Nav.routeReplacement(
            context,
            ChangeNotifierProvider<TabProvider>(
              create: (_) => TabProvider(),
              child: TabScreen(),
            ),
          );
          // Nav.routeReplacement(context, Home());
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
