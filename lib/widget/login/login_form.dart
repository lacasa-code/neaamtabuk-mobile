import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/Account.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_pos/widget/login/login_form_model.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  Model_login model = Model_login();
  bool passwordVisible = false;
  String CountryNo = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Container(
      padding: EdgeInsets.only(top: 24, right: 42, left: 42),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            MyTextFormField(
              intialLabel: 'asd@asd.com',
              Keyboard_Type: TextInputType.emailAddress,
              labelText: getTransrlate(context, 'Email'),
              hintText: getTransrlate(context, 'Email'),
              isPhone: true,
              validator: (String value) {
                if (value.isEmpty) {
                  return getTransrlate(context, 'Email');
                } else if (!RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                    .hasMatch(value)) {
                  return getTransrlate(context, 'invalidemail');
                }
                _formKey.currentState.save();
                return null;
              },
              onSaved: (String value) {
                model.email = value;
              },
            ),
            MyTextFormField(
              intialLabel: '123123123',
              labelText: getTransrlate(context, 'password'),
              hintText: getTransrlate(context, 'password'),
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: themeColor.getColor(),
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              isPassword: passwordVisible,
              validator: (String value) {
                if (value.length < 7) {
                  return getTransrlate(context, 'password' + '< 7');
                }
                _formKey.currentState.save();
                return null;
              },
              onSaved: (String value) {
                model.password = value;
              },
            ),
            Container(
              height: 42,
              width: ScreenUtil.getWidth(context),
              margin: EdgeInsets.only(top: 32, bottom: 12),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                ),
                color: themeColor.getColor(),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    //setState(() => _isLoading = true);
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    API(context).post('user/login', {
                      'email': model.email,
                      'password': model.password,
                    }).then((value) {
                      if (value != null) {
                        if (value['status_code'] == 200) {
                          var user = value['data'];
                          prefs.setString("user_email", user['email']);
                          prefs.setString("user_name", user['name']);
                          prefs.setString("token", user['token']);
                          prefs.setInt("user_id", user['id']);
                          themeColor.setLogin(true);
                          Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (_) => Account()), (r) => false);
                        }
                      }
                    });
                  }
                },
                child: Text(
                  getTransrlate(context, 'login'),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
