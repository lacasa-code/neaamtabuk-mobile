import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/screens/login.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/register/register_form.dart';

import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: themeColor.getColor(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/logo.png',
            height: ScreenUtil.getHeight(context) / 10,
            width: ScreenUtil.getWidth(context) / 4,
            fit: BoxFit.contain,
            //color: themeColor.getColor(),
          ) ,
          leading: Container(),
        ),
       // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical : 30,horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: 1,width: ScreenUtil.getWidth(context)/4,color: Colors.black12,),
                      Text(getTransrlate(context, 'AreadyAccount'),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),
                      Container(height: 1,width: ScreenUtil.getWidth(context)/4,color: Colors.black12,)
                    ],
                  ),
                ),
              ),
              RegisterForm(),
              routeLoginWidget(themeColor, context),
              SizedBox(height: 50,)

              //SocialRegisterButtons(themeColor: themeColor)
            ],
          ),
        ),
      ),
    );
  }

  Widget routeLoginWidget(Provider_control themeColor, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20, bottom: 12),
      child: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical : 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 1,width: ScreenUtil.getWidth(context)/4,color: Colors.black12,),
                  Text(getTransrlate(context, 'haveanaccount'),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),
                  Container(height: 1,width: ScreenUtil.getWidth(context)/4,color: Colors.black12,)
                ],
              ),
            ),
          ),
          FlatButton(
            minWidth: ScreenUtil.getWidth(context),
            shape: RoundedRectangleBorder(
                borderRadius:  BorderRadius.circular(1.0),
                side: BorderSide(color: Colors.black26)
            ),
            child: Text(
              getTransrlate(context, 'login'),
              style: TextStyle(
                fontSize: 14,
                color: themeColor.getColor(),
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Nav.routeReplacement(context, LoginPage());
            },
          )
        ],
      ),
    );
  }
}
