import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_pos/utils/screen_size.dart';

class Custom_Loading extends StatelessWidget {
  const Custom_Loading({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getHeight(context) / 4,
      width: ScreenUtil.getWidth(context) / 1.5,
      child: Lottie.network(
        'https://assets3.lottiefiles.com/packages/lf20_rtw7dx9w.json',
      ),
    );
  }
}
