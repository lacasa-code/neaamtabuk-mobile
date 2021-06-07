import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_pos/screens/login.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/register/register_form.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
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
      padding: EdgeInsets.only( right: 36, left: 48),
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
                  Text(getTransrlate(context, 'or'),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/facebook.svg',height: 30,width: 30,),
                  SizedBox(width: 5),
                  Text(
                   "دخول عن طريق فيسبوك",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              loginWithFB(context);
              },
          ),
          SizedBox(height: 15,),
          FlatButton(

            minWidth: ScreenUtil.getWidth(context),
            shape: RoundedRectangleBorder(
                borderRadius:  BorderRadius.circular(1.0),
                side: BorderSide(color: Colors.black26)
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/google-icon.svg',height: 20,width: 20,),
                  SizedBox(width: 5),
                  Text(
                    "دخول عن طريق جوجل",
                    style: TextStyle(
                      fontSize: 14,
                      color: themeColor.getColor(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              login(context);
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical : 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 1,width: ScreenUtil.getWidth(context)/4.5,color: Colors.black12,),
                  Text(getTransrlate(context, 'haveanaccount'),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),
                  Container(height: 1,width: ScreenUtil.getWidth(context)/4.5,color: Colors.black12,)
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                getTransrlate(context, 'login'),
                style: TextStyle(
                  fontSize: 14,
                  color: themeColor.getColor(),
                  fontWeight: FontWeight.w500,
                ),
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
  login(BuildContext context) async{
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try{
      await _googleSignIn.signIn();
      print(_googleSignIn.currentUser);

    } catch (err){
      print(err);
    }
  }
  loginWithFB(BuildContext context) async {

    final facebookLogin = FacebookLogin();
    facebookLogin.logOut();
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profil = JSON.jsonDecode(graphResponse.body);
        print(graphResponse.body);
        break;

      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }

  }
}
