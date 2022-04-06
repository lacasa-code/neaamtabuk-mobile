import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/utils/tab_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as util;
import 'package:flutter_pos/main.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ProviderControl>(context);

    return WillPopScope(
      onWillPop: () async {
        Provider.of<TabProvider>(context, listen: false).toHome();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            getTransrlate(context, 'About'),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: util.ScreenUtil().setSp(17)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton(
                itemBuilder: (_) => [
                  CheckedPopupMenuItem(
                    value: 'ar',
                    checked: themeColor.local == 'ar',
                    child: Text(
                      'العربية',
                    ),
                  ),
                  CheckedPopupMenuItem(
                    value: 'en',
                    checked: themeColor.local == 'en',
                    child: Text(
                      'English',
                    ),
                  ),
                ],
                child: Icon(
                  Icons.language,
                  color: themeColor.getColor(),
                ),
                onSelected: (v) {
                  if (themeColor.local == v) {
                    return;
                  }
                  themeColor.setLocal(v);
                  MyApp.setlocal(context, Locale(themeColor.getlocal(), ''));
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setString('local', themeColor.local);
                  });
                },
              ),
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        // appBar: buildAppBar(themeColor),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/logoIcon.png',
                      width: ScreenUtil.getWidth(context) / 2,
                    ),
                    // height: ScreenUtil.getHeight(context) / 4,
                  ),
                  Positioned(
                    bottom: -util.ScreenUtil().setWidth(30),
                    child: Container(
                      child: Image.asset(
                        'assets/images/logoText.png',
                        width: ScreenUtil.getWidth(context) / 2,
                      ),
                      // height: ScreenUtil.getHeight(context) / 4,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: util.ScreenUtil().setHeight(25),
              ),
              aboutItem(themeColor),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(ProviderControl themeColor) {
    return AppBar(
      title: Text(
        "${getTransrlate(context, 'About')}",
      ),
    );
  }

  Widget aboutItem(ProviderControl themeColor) {
    return Container(
      // margin: EdgeInsets.only(bottom: 16, left: 8, right: 8, top: 8),
      // width: ScreenUtil.getWidth(context),
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(12),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey.withOpacity(.2),
      //         blurRadius: 9.0, // soften the shadow
      //         spreadRadius: 0.0, //extend the shadow
      //         offset: Offset(
      //           0.0, // Move to right 10  horizontally
      //           1.0, // Move to bottom 10 Vertically
      //         ),
      //       )
      //     ]),
      child: Container(
        padding: EdgeInsets.only(left: 12, top: 6, right: 12, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "الفكرة",
                style: TextStyle(
                  color: themeColor.getColor(),
                  fontWeight: FontWeight.bold,
                  fontSize: util.ScreenUtil().setSp(15),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  text:
                      " بدأت بمبادرة من صاحب السمو الملكي الأمير فهد بن سلطان أمير منطقة تبوك يحفظه الله بهدف حفظ النعمة من الهدر وذلك بإنشاء جمعية خيرية لحفظ النعم بكوادر شابة متعلمة تطبق وتدير هذا العمل المبارك في منطقة تبوك بطريقة احترافية متطورة.",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: util.ScreenUtil().setSp(15),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "من نحن",
                  style: TextStyle(
                    color: themeColor.getColor(),
                    fontWeight: FontWeight.bold,
                    fontSize: util.ScreenUtil().setSp(15),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  text:
                      "مؤسسة خيرية غير ربحية متخصصة في الغذاء والكساء والأثاث، هدفها الأساسي هو حفظ النعم.",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: util.ScreenUtil().setSp(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
