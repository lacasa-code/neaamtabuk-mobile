import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_pos/screens/about_page.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/screens/account/user_information.dart';
import 'package:flutter_pos/screens/contact_page.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/utils/Provider/home_provider.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/shared_prefs_provider.dart';
import 'package:flutter_pos/utils/tab_provider.dart';
import 'package:flutter_pos/widget/bottom_navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key key, this.homeTabIndex}) : super(key: key);
  final int homeTabIndex;

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> _pages;
  @override
  void initState() {
    _pages = [
      UserInfo(),
      ContactPage(),
      ChangeNotifierProvider<HomeProvider>(
        create: (_) => HomeProvider(
          currentTabIndex: widget.homeTabIndex,
        ),
        child: Home(),
      ),
      Setting(),
      Container(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ProviderControl>(context, listen: false);
    return Consumer<TabProvider>(builder: (context, snap, __) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: _pages[snap.index],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          //Floating action button on Scaffold
          onPressed: () => snap.toHome(),
          child: ImageIcon(
            AssetImage(
              'assets/icons/home.png',
            ),
            color: theme.getColor(),
          ), //icon inside button
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //floating action button position to center
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            onTap: (i) => snap.changeIndex(context, theme, i),
            type: BottomNavigationBarType.fixed,
            backgroundColor: theme.getColor(),
            currentIndex: snap.index,
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: ImageIcon(
                  AssetImage('assets/icons/user.png'),
                  color: Colors.white,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: ImageIcon(
                  AssetImage('assets/icons/phone.png'),
                  color: Colors.white,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: ImageIcon(
                  AssetImage('assets/icons/phone.png'),
                  color: Colors.transparent,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: ImageIcon(
                  AssetImage('assets/icons/logOut.png'),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: BottomAppBar(
        //   //bottom navigation bar on scaffold
        //   color: theme.getColor(),
        //   shape: CircularNotchedRectangle(), //shape of notch
        //   notchMargin:
        //       5, //notche margin between floating button and bottom appbar
        //   child: Row(
        //     //children inside bottom appbar
        //     mainAxisSize: MainAxisSize.max,
        //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[
        //       SizedBox(
        //         width: ScreenUtil().setWidth(35),
        //       ),
        //       IconButton(
        //         icon: ImageIcon(
        //           AssetImage('assets/icons/user.png'),
        //           color: Colors.white,
        //         ),
        //         onPressed: () {},
        //       ),
        //       SizedBox(
        //         width: ScreenUtil().setWidth(35),
        //       ),
        //       IconButton(
        //         icon: ImageIcon(
        //           AssetImage('assets/icons/phone.png'),
        //           color: Colors.white,
        //         ),
        //         onPressed: () {},
        //       ),
        //       SizedBox(
        //         width: ScreenUtil().setWidth(35),
        //       ),
        //       IconButton(
        //         icon: Icon(
        //           Icons.info_outline,
        //           color: Colors.white,
        //         ),
        //         onPressed: () {},
        //       ),
        //       SizedBox(
        //         width: ScreenUtil().setWidth(35),
        //       ),
        //       IconButton(
        //         icon: ImageIcon(
        //           AssetImage('assets/icons/logOut.png'),
        //           color: Colors.white,
        //         ),
        //         onPressed: () {},
        //       ),
        //       SizedBox(
        //         width: ScreenUtil().setWidth(35),
        //       ),
        //     ],
        //   ),
        // ),
      );
    });
  }
}
