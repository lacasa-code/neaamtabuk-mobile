import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/main.dart';
import 'package:flutter_pos/screens/about_page.dart';
import 'package:flutter_pos/screens/account/user_information.dart';
import 'package:flutter_pos/screens/contact_page.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/item_hidden_menu.dart';

import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


// ignore: must_be_immutable
class HiddenMenu extends StatefulWidget {
  @override
  _HiddenMenuState createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> {
  bool isconfiguredListern = false;
  int id;
  String username, name, role_id, photo;
  String am_pm;

  @override
  void initState() {
    am_pm = new DateFormat('a').format(new DateTime.now());
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        id = prefs.getInt('user_id');
        name = prefs.getString('user_name');
        role_id = prefs.getString('role_id');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ProviderControl>(context);
    return Drawer(
      child: Container(
        color: themeColor.getColor(),
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/trkar_logo_white (copy).png',
                        fit: BoxFit.contain,
                        //color: themeColor.getColor(),
                      ),
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      //  getTransrlate(context, 'welcome'),
                      am_pm == 'am'
                          ? getTransrlate(context, 'good_morning')
                          : getTransrlate(context, 'good_night'),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    AutoSizeText(
                      "${getTransrlate(context, 'Username')} :  ${name}" ,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ) ,
                    SizedBox(height: 10,),

                    Row(
                      children: [
                        AutoSizeText(
                          " ${getTransrlate(context, 'AccountType')} : " ,
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),

                        Container(
                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(9.0) ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              " ${role_id=='1'?"${getTransrlate(context, 'Donor')}":role_id=='2'?"${getTransrlate(context, 'representative')}":"${getTransrlate(context, 'Beneficiary')}"}" ,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: themeColor.getColor(),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (scroll) {
                    scroll.disallowGlow();
                    return false;
                  },
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Nav.route(context, UserInfo());
                        },
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Icons.person,
                            size: 25,
                            color: Colors.white,
                          ),
                          name: getTransrlate(context, 'ProfileSettings'),
                          baseStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w800),
                          colorLineSelected: Colors.white,
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Nav.route(context, ContactPage());
                        },
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Icons.call,
                            size: 25,
                            color: Colors.white,
                          ),
                          name: getTransrlate(context, 'contact'),
                          baseStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w800),
                          colorLineSelected: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Nav.route(context, Setting());

                        },
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Icons.info_outline,
                            size: 25,
                            color: Colors.white,
                          ),
                          name: getTransrlate(context, 'About'),
                          baseStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w800),
                          colorLineSelected: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          themeColor.setLogin(false);
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.clear();
                          themeColor.isLogin
                              ? Nav.routeReplacement(context, Home())
                              : Nav.route(context, LoginPage());
                        },
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Icons.exit_to_app,
                            size: 19,
                          color: Colors.white,

                        ), name: themeColor.isLogin
                            ? getTransrlate(context, 'Logout')
                              : getTransrlate(context, 'login'),
                          baseStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w800),
                          colorLineSelected: Colors.white,
                        ),
                      ),
                      Container(
                          height: 28,
                          margin: EdgeInsets.only(left: 24, right: 48),
                          child: Divider(
                            color: Colors.white.withOpacity(0.5),
                          )),
                      Container(
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (scroll) {
                            scroll.disallowGlow();
                            return false;
                          },
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0.0),
                            children: <Widget>[
                              InkWell(
                                onTap: () async {
                                  await themeColor.local == 'ar'
                                      ? themeColor.setLocal('en')
                                      : themeColor.setLocal('ar');
                                  MyApp.setlocal(context,
                                      Locale(themeColor.getlocal(), ''));
                                  SharedPreferences.getInstance()
                                      .then((prefs) {
                                    prefs.setString(
                                        'local', themeColor.local);
                                  });
                                },
                                child: ItemHiddenMenu(
                                  icon: Icon(
                                    Icons.language,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  name: Provider.of<ProviderControl>(context)
                                              .local ==
                                          'ar'
                                      ? 'English'
                                      : 'عربى',
                                  baseStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.w800),
                                  colorLineSelected: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getTransrlate(context, 'version') + ' 1.0.0',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ])),
      ),
    );
  }


}
