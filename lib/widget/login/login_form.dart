import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/screens/account/lost_password.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/login/login_form_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ResultOverlay.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  Model_login model = Model_login();
  bool passwordVisible = true;
  String CountryNo = '';
  bool isloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ProviderControl>(context);

    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyTextFormField(
                    intialLabel: '',
                    istitle: true,
                    keyboard_type: TextInputType.emailAddress,
                    hintText: 'mail',
                    prefix: ImageIcon(
                      AssetImage(
                        'assets/icons/email.png',
                      ),
                    ),
                    // hintText: getTransrlate(context, 'mail'),
                    isPhone: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return getTransrlate(context, 'requiredempty');
                      } else if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
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
                    istitle: true,

                    intialLabel: '',
                    hintText: 'password',
                    prefix: ImageIcon(
                      AssetImage(
                        'assets/icons/lock.png',
                      ),
                    ),
                    keyboard_type: TextInputType.multiline,
                    // hintText: getTransrlate(context, 'password'),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black26,
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
                      if (value.isEmpty) {
                        return "${getTransrlate(context, 'requiredempty')}";
                      } else if (value.length < 7) {
                        return "${getTransrlate(context, 'requiredlength')}";
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onSaved: (String value) {
                      model.password = value;
                    },
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: InkWell(
                          onTap: () {
                            Nav.route(context, LostPassword());
                          },
                          child: AutoSizeText(
                            getTransrlate(context, 'LostPassword'),
                            style: TextStyle(
                              color: Color(0xff5BBA7D),
                            ),
                          ))),
                  Container(
                    height: 42,
                    width: ScreenUtil.getWidth(context),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff2CA649),
                          Color(0xff2CA649),
                          Color(0xff4BB146),
                          Color(0xff4BB146),
                          Color(0xff66BA44),
                          Color(0xff77C042),
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(top: 25, bottom: 12),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(1.0),
                      ),
                      // color: themeColor.getColor(),
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          setState(() => isloading = true);
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          API(context, Check: false).post('login', {
                            'email': model.email,
                            'password': model.password,
                          }).then((value) {
                            print(value);
                            setState(() => isloading = false);
                            if (value != null) {
                              if (value['status'] == true) {
                                print("${value['access_token']}");
                                var user = value['data'];
                                prefs.setString(
                                    "token", "${value['access_token']}");
                                prefs.setString(
                                    "role_id", "${user['role_id']}");
                                prefs.setString(
                                    "user_email", "${user['email']}");
                                prefs.setString(
                                    "address", "${user['address']}");
                                prefs.setString("lat", "${user['latitude']}");
                                prefs.setString("lang", "${user['longitude']}");
                                prefs.setString(
                                    "user_name", "${user['username']}");
                                prefs.setInt("user_id", user['id']);
                                themeColor.setLogin(true);
                                Phoenix.rebirth(context);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ResultOverlay('${value['message']}'));
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
              !isloading
                  ? Container()
                  : Container(
                      color: Colors.white,
                      height: ScreenUtil.getHeight(context) / 2,
                      width: ScreenUtil.getWidth(context),
                      child: Custom_Loading()),
            ],
          )),
    );
  }
}
