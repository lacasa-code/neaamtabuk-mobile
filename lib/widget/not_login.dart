import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Notlogin extends StatelessWidget {
  const Notlogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          height: ScreenUtil.getHeight(context) / 1.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/account.svg",
                width: ScreenUtil.getWidth(context) / 3,
                color: Colors.black12,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'لا يوجد لديك حساب',
                style: TextStyle(color: Colors.black45,fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'برجاء تسجيل دخول',
                style: TextStyle(color: Colors.black45,fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
