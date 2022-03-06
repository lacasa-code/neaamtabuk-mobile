import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';

import 'package:provider/provider.dart';
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
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      appBar: buildAppBar(themeColor),
      body:  SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
        child: Image.asset('assets/images/logo.png',width: ScreenUtil.getWidth(context)/2),
              height: ScreenUtil.getHeight(context)/4,
              ),
            aboutItem(),

          ],

        ),
      ),
    );
  }

  AppBar buildAppBar(Provider_control themeColor) {
    return AppBar(
      brightness: Brightness.light,
      elevation: 0,
      centerTitle: true,
      title: Text(
       "${getTransrlate(context, 'About')}",
      ),
      leading: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Icon(
          Icons.chevron_left,
          color: themeColor.getColor(),
        ),
      ),
    );
  }

  Widget aboutItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 16, left: 8, right: 8, top: 8),
      width: ScreenUtil.getWidth(context),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 9.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ]),
      child: Container(
        padding: EdgeInsets.only(left: 12, top: 6,right: 12, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "الفكرة",
              style: TextStyle(color: Colors.green),
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.bottomRight,
              child: RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  text:" بدأت بمبادرة من صاحب السمو الملكي الأمير فهد بن سلطان أمير منطقة تبوك يحفظه الله بهدف حفظ النعمة من الهدر وذلك بإنشاء جمعية خيرية لحفظ النعم بكوادر شابة متعلمة تطبق وتدير هذا العمل المبارك في منطقة تبوك بطريقة احترافية متطورة.",
                  style: TextStyle(
                    color: Colors.black,
                       fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Text(
              "من نحن",
              style: TextStyle(color: Colors.green),
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.bottomRight,
              child: RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  text: "مؤسسة خيرية غير ربحية متخصصة في الغذاء والكساء والأثاث، هدفها الأساسي هو حفظ النعم.",
                  style: TextStyle(
                    color: Colors.black,
                       fontWeight: FontWeight.w400),
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
