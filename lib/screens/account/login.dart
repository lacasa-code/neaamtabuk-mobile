import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
    final themeColor = Provider.of<ProviderControl>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/trkar_logo_white (copy).png',
                fit: BoxFit.contain,
                //color: themeColor.getColor(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Text(
                getTransrlate(context, 'login'),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
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

  Widget routeLoginWidget(ProviderControl themeColor, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20, bottom: 12),
      child: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${getTransrlate(
                        context,
                        'dont_have_account',
                      )} ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Nav.routeReplacement(context, RegisterPage());
                        },
                      text: '${getTransrlate(
                        context,
                        'create_account',
                      )} ',
                      style: TextStyle(
                        color: Color(0xff78C693),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // child: Container(
              //     child: Text(
              //   getTransrlate(context, 'RegisterNew'),
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontWeight: FontWeight.bold,
              //   ),
              // )),
            ),
          ),
        ],
      ),
    );
  }
}
