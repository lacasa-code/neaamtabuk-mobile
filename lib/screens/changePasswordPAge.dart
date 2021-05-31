import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class changePassword extends StatefulWidget {
  const changePassword({Key key}) : super(key: key);

  @override
  _changePasswordState createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  String email,oldPassword,newPassword,ConfirmPassword;
  final _formKey = GlobalKey<FormState>();

  void initState() {
    SharedPreferences.getInstance().then((value) => {
      setState(() {
        email = value.getString('user_email');
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset("assets/icons/User Icon.svg",color: Colors.white,height: 25,),
            SizedBox(width: 10,),
            Text('البيانات الشخصية'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child:email==null?Container(): Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextFormField(
                  intialLabel: email??' ',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'Email'),
                  hintText: getTransrlate(context, 'Email'),
                  isPhone: true,
                  enabled: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'Email');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    email=value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.visiblePassword,
                  labelText: getTransrlate(context, 'password'),
                  hintText: getTransrlate(context, 'password'),
                  isPassword: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'password');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    oldPassword=value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.visiblePassword,
                  labelText: getTransrlate(context, 'NewPassword'),
                  hintText: getTransrlate(context, 'NewPassword'),
                  isPassword: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'NewPassword');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    newPassword=value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'ConfirmPassword'),
                  hintText: getTransrlate(context, 'ConfirmPassword'),
                  isPassword: true,
                  validator: (String value) {
                    if (value!=newPassword) {
                      return getTransrlate(context, 'Passwordmatch');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    ConfirmPassword=value;
                  },
                ),


                SizedBox(height: 25 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: GestureDetector(
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 2.5,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
                          child: Center(
                            child: AutoSizeText(
                              getTransrlate(context, 'save'),
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 14,
                              maxLines: 1,
                              minFontSize: 10,
                              style:
                              TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                            ),
                          ),
                        ),
                        onTap: ()  {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            //setState(() => _isLoading = true);
                            API(context).post('user/forget/password', {
                              "email": email,
                              "current_password": oldPassword,
                              "new_password": newPassword,
                              "new_password_confirmation":ConfirmPassword,
                            }).then((value) {
                              if (value != null) {
                                if (value['status_code'] == 200) {
                                  showDialog(
                                      context: context,
                                      builder: (_) =>
                                          ResultOverlay(value['message']));

                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) =>
                                          ResultOverlay(value['message']));
                                }
                              }
                            });
                          }
                        },
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 2.5,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: AutoSizeText(
                              getTransrlate(context, 'close'),
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 14,
                              maxLines: 1,
                              minFontSize: 10,
                              style:
                              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

