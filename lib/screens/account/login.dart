import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/screens/account/register_page.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/login/login_form.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(

        appBar: AppBar(
          title: InkWell(
            onTap: (){
              Phoenix.rebirth(context);
            },
            child: Image.asset(
              'assets/images/logo.png',
              height: ScreenUtil.getHeight(context) / 10,
              width: ScreenUtil.getWidth(context) / 4,
              fit: BoxFit.contain,
              //color: themeColor.getColor(),
            ),
          ) ,
          leading: Container(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical : 30,horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(height: 1,width: ScreenUtil.getWidth(context)/4,color: Colors.black12,),
                        Text(getTransrlate(context, 'login'),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),
                        Container(height: 1,width: ScreenUtil.getWidth(context)/4,color: Colors.black12,)
                      ],
                    ),
                  ),
                ),
                LoginForm(),
                routeLoginWidget(themeColor, context),

              ],
            ),
          ),
        ));
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
                  Container(child: Text(getTransrlate(context, 'RegisterNew'),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),)),
                  Container(height: 1,width: ScreenUtil.getWidth(context)/4,color: Colors.black12,)
                ],
              ),
            ),
          ),
          FlatButton(minWidth: ScreenUtil.getWidth(context),
            shape: RoundedRectangleBorder(
              borderRadius:  BorderRadius.circular(1.0),
              side: BorderSide(color: Colors.black26)
            ),
            child: Text(
              getTransrlate(context, 'AreadyAccount'),
              style: TextStyle(
                fontSize: 14,
                color: themeColor.getColor(),
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Nav.routeReplacement(context, RegisterPage());
            },
          )
        ],
      ),
    );
  }

}
