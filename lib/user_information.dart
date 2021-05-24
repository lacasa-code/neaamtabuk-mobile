import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String name,email;
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) => {
      setState((){
        name=value.getString('user_name');
        email=value.getString('user_email');
      })
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:Text('البيانات الشخصية'),),
    body: Column(
      children: [
        Container(color: Colors.black12,
        child: Column(
          children: [
            Text(name??" "),
            Text(email??" "),
          ],
        ),),
      ],
    ),);
  }
}
