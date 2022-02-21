import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/register/register_form_vendor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VolunteerPage extends StatefulWidget {
  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  String email, facebook_id;
  Provider_control themeColor;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  SingingCharacter _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    themeColor = Provider.of<Provider_control>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: themeColor.getColor(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/trkar_logo_white (copy).png',
            fit: BoxFit.fill,
            height: 50,
            //color: themeColor.getColor(),
          ),
        ),
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: ScreenUtil.getWidth(context) / 4,
                        color: Colors.black12,
                      ),
                      Text(
                        getTransrlate(context, 'placeorder'),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 1,
                        width: ScreenUtil.getWidth(context) / 4,
                        color: Colors.black12,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      MyTextFormField(
                        labelText: getTransrlate(context, 'name'),
                        hintText: getTransrlate(context, 'name'),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "${getTransrlate(context, 'requiredempty')}";
                          } else if (value.length <= 2) {
                            return "${getTransrlate(context, 'requiredlength')}";
                          }
                          return null;
                        },
                        onSaved: (String value) {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(" هل الطعام جاهز للتوزيع ؟")),
                      Container(
                        width: ScreenUtil.getWidth(context),
                        height: ScreenUtil.getHeight(context) / 10,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: ScreenUtil.getWidth(context) / 2.5,
                              child: ListTile(
                                title: Text('لا'),
                                leading: Radio<SingingCharacter>(
                                  value: SingingCharacter.lafayette,
                                  groupValue: _character,
                                  activeColor: themeColor.getColor(),

                                  onChanged: (SingingCharacter value) {
                                    setState(() {
                                      _character = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: ScreenUtil.getWidth(context) / 2.5,
                              child: ListTile(
                                title: Text('نعم'),
                                leading: Radio<SingingCharacter>(
                                  value: SingingCharacter.jefferson,
                                  activeColor: themeColor.getColor(),
                                  groupValue: _character,
                                  onChanged: (SingingCharacter value) {
                                    setState(() {
                                      _character = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(" هل الطعام جاهز للتغليف ؟")),
                      Container(
                        width: ScreenUtil.getWidth(context),
                        height: ScreenUtil.getHeight(context) / 10,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: ScreenUtil.getWidth(context) / 2.5,
                              child: ListTile(
                                title: Text('لا'),
                                leading: Radio<SingingCharacter>(
                                  value: SingingCharacter.lafayette,
                                  activeColor: themeColor.getColor(),
                                  groupValue: _character,
                                  onChanged: (SingingCharacter value) {
                                    setState(() {
                                      _character = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: ScreenUtil.getWidth(context) / 2.5,
                              child: ListTile(
                                title: Text('نعم'),
                                leading: Radio<SingingCharacter>(
                                  value: SingingCharacter.jefferson,
                                  activeColor: themeColor.getColor(),
                                  groupValue: _character,
                                  onChanged: (SingingCharacter value) {
                                    setState(() {
                                      _character = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        width: ScreenUtil.getWidth(context),
                        margin: EdgeInsets.only(
                            top: 12, bottom: 0, right: 16, left: 16),
                        padding: EdgeInsets.only(right: 16, left: 16),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(1.0),
                          ),
                          color: themeColor.getColor(),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              setState(() => _isLoading = true);
                              register(themeColor);
                            }
                          },
                          child: Text(
                            getTransrlate(context, 'placeorder'),
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
              ),
              SizedBox(
                height: 50,
              )

              //SocialRegisterButtons(themeColor: themeColor)
            ],
          ),
        ),
      ),
    );
  }

  Widget routeLoginWidget(Provider_control themeColor, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 36, left: 48),
      child: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4,
                    color: Colors.black12,
                  ),
                  Text(
                    getTransrlate(context, 'or'),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4,
                    color: Colors.black12,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4.5,
                    color: Colors.black12,
                  ),
                  Text(
                    getTransrlate(context, 'haveanaccount'),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4.5,
                    color: Colors.black12,
                  )
                ],
              ),
            ),
          ),
          FlatButton(
            minWidth: ScreenUtil.getWidth(context),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.0),
                side: BorderSide(color: Colors.black26)),
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

  register(Provider_control themeColor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    API(context).post('login/facebook',
        {'facebook_id': facebook_id, 'email': email}).then((value) {
      if (!value.containsKey('errors')) {
        var user = value['data'];
        prefs.setString("user_email", user['email']);
        prefs.setString("user_name", user['name']);
        prefs.setString("token", user['token']);
        prefs.setInt("user_id", user['id']);
        themeColor.setLogin(true);
        Phoenix.rebirth(context);
      } else {
        showDialog(
            context: context,
            builder: (_) =>
                ResultOverlay('${value['message']}\n${value['errors']}'));
      }
    });
  }
}

enum SingingCharacter { lafayette, jefferson }
