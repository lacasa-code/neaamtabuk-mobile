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
  bool passwordVisible = false;
  bool loading = false;

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
                  keyboard_type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'Email'),
                  // hintText: getTransrlate(context, 'Email'),
                  isPhone: true,
                  enabled: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'Email');
                    }else if (!RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                        .hasMatch(value)) {
                      return getTransrlate(context, 'invalidemail');
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
                  keyboard_type: TextInputType.visiblePassword,
                  labelText: getTransrlate(context, 'password'),
                  // hintText: getTransrlate(context, 'password'),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                  keyboard_type: TextInputType.visiblePassword,
                  labelText: getTransrlate(context, 'NewPassword'),
                  // hintText: getTransrlate(context, 'NewPassword'),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                      return getTransrlate(context, 'requiredempty');
                    } else if (value.length < 8) {
                      return getTransrlate(context, 'PasswordShorter');
                    } else if (!value.contains(new RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                      return "Uppercase,Lowercase,Number and Special Character";
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
                  keyboard_type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'ConfirmPassword'),
                  // hintText: getTransrlate(context, 'ConfirmPassword'),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                      return getTransrlate(context, 'requiredempty');
                    } else if (value!=newPassword) {
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
                      child: loading?FlatButton(
                        minWidth: ScreenUtil.getWidth(context) / 2.5,
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:Container(
                            height: 30,
                            child: Center(
                                child: CircularProgressIndicator(
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>( Colors.white),
                                )),
                          ),
                        ),
                        onPressed: () async {
                        },
                      ): GestureDetector(
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 2.5,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(border: Border.all(color: Colors.green)),
                          child: Center(
                            child: AutoSizeText(
                              getTransrlate(context, 'save'),
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 14,
                              maxLines: 1,
                              minFontSize: 10,
                              style:
                              TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                            ),
                          ),
                        ),
                        onTap: ()  {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            //setState(() => _isLoading = true);
                            setState(() => loading = true);

                            API(context).post('user/change/password', {
                              "email": email,
                              "current_password": oldPassword,
                              "new_password": newPassword,
                              "new_password_confirmation":ConfirmPassword,
                            }).then((value) {
                              if (value != null) {
                                setState(() => loading = false);

                                if (value['status_code'] == 200) {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (_) =>
                                          ResultOverlay(value['message']));

                                } else {
                                  showDialog(

                                      context: context,
                                      builder: (_) =>
                                          ResultOverlay(value['errors'], icon: Icon(
                                            Icons.info_outline,
                                            color: Colors.yellow,
                                            size: 80,
                                          )));
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

