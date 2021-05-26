import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/user_info.dart';
import 'package:flutter_pos/screens/changePasswordPAge.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String name, email;
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  bool _isLoading = false;
  User userModal;
  String password;
  String _email, _f_name, _username, _password;

  submitForm() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    _isLoading = true;
    try {
      setState(() => _isLoading = false);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) => {
          setState(() {
            name = value.getString('user_name');
            email = value.getString('user_email');
          })
        });
    API(context).get('user/profile/info').then((value) {
      if (value != null) {
        if (value['status_code'] == 200) {
          setState(() {
            userModal = UserInformation.fromJson(value).data;
          });
        } else {
          showDialog(
              context: context,
              builder: (_) => ResultOverlay(value['message']));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

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
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              color: Colors.black12,
              width: ScreenUtil.getWidth(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name ?? " "),
                    Text(email ?? " "),
                  ],
                ),
              ),
            ),
            _isLoading
                ? Container(
                    // height: double.infinity,
                    // width: double.infinity,
                    color: Colors.white,
                    child: Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                themeColor.getColor()))))
                : userModal == null
                    ? Container()
                    : Container(
                        color: Colors.white,
                        child: Container(
                          color: Colors.white,
                          child: Container(
                            color: Color(0xffFFFFFF),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: Text(
                                      'الاسم',
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: TextFormField(
                                        initialValue: userModal.name,
                                        decoration: const InputDecoration(
                                          hintText: "أدخل الاسم",
                                        ),
                                        enabled: !_status,
                                        autofocus: !_status,
                                        onChanged: (String val) => _f_name = val,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Text(
                                        'البريد الالكترونى ',
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: TextFormField(
                                        initialValue: userModal.email,
                                        decoration: const InputDecoration(
                                            hintText: "ادخل البريد الالكترونى"),
                                        enabled: !_status,
                                        onSaved: (String val) => _email = val,
                                        onChanged: (String val) => _email = val,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Text(
                                        'رقم الهاتف ',
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: TextFormField(
                                        initialValue: "02010852852852",
                                        decoration: InputDecoration(
                                            hintText: "أدخل رقم الهاتف"),
                                        enabled: !_status,
                                        onSaved: (String val) => _username = val,
                                        onChanged: (String val) =>
                                            _username = val,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Text(
                                        'تاريخ الميلاد',
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: TextFormField(
                                        initialValue: "25-2-1990",
                                        decoration: InputDecoration(
                                            hintText: "أدخل تاريخ الميلاد"),
                                        enabled: !_status,
                                        onSaved: (String val) => _username = val,
                                        onChanged: (String val) =>
                                            _username = val,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Text(
                                        'الجنس',
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: TextFormField(
                                        initialValue: "25-2-1990",
                                        decoration: InputDecoration(
                                            hintText: " حدد الجنس"),
                                        enabled: !_status,
                                        onSaved: (String val) => _username = val,
                                        onChanged: (String val) =>
                                            _username = val,
                                      )),
                                  _status ? _getEditIcon() : _getActionButtons(),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Text(
                                        'كلمة المرور',
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: TextFormField(
                                        initialValue: "123456789",
                                        decoration: InputDecoration(
                                            hintText: "أدخل كلمة المرور"),
                                        enabled: !_status,
                                        obscureText: true,
                                        onSaved: (String val) => _username = val,
                                        onChanged: (String val) =>
                                        _username = val,
                                      )),
                                  _getChangePassword()
                                ],
                              ),
                            ),
                          ),
                        ))
          ]),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }
  Widget _getActionButtons() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Container(
                    width: ScreenUtil.getWidth(context) / 2.5,
                    padding: const EdgeInsets.all(10.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.orange)),
                    child: GestureDetector(
                      child: Center(
                        child: Text(
                          "حفظ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _status = true;
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      },
                    )),
              ),
              flex: 2,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                    width: ScreenUtil.getWidth(context) / 2.5,
                    padding: const EdgeInsets.all(10.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: GestureDetector(
                      child: Center(
                        child: Text(
                          "إلغاء",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _status = true;
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      },
                    )),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
  Widget _getEditIcon() {
    return Center(
      child: GestureDetector(
        child: Container(
          width: ScreenUtil.getWidth(context) / 2.5,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
          child: Center(
            child: AutoSizeText(
              getTransrlate(context, 'edit'),
              overflow: TextOverflow.ellipsis,
              maxFontSize: 14,
              maxLines: 1,
              minFontSize: 10,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
            ),
          ),
        ),
        onTap: () {
          setState(() {
            _status = false;
          });
        },
      ),
    );
  }
  Widget _getChangePassword() {
    return Center(
      child: GestureDetector(
        child: Container(
          width: ScreenUtil.getWidth(context) / 2.5,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
          child: Center(
            child: AutoSizeText(
              getTransrlate(context, 'changePassword'),
              overflow: TextOverflow.ellipsis,
              maxFontSize: 14,
              maxLines: 1,
              minFontSize: 10,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
            ),
          ),
        ),
        onTap: () {
          Nav.route(context, changePassword());
        },
      ),
    );
  }
}
