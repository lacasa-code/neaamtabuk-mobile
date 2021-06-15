import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/MyCars/myCars.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AppBarCustom extends StatefulWidget {
  const AppBarCustom({Key key}) : super(key: key);

  @override
  _AppBarCustomState createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Container(
      color: themeColor.getColor(),
      padding: const EdgeInsets.only(top: 35),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: ScreenUtil.getHeight(context) / 10,
              width: ScreenUtil.getWidth(context) / 3,
              fit: BoxFit.contain,
            ),
          ),
          FlatButton(
            onPressed: () {
              Nav.route(context, MyCars());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/icons/car2.svg',
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  themeColor.getCar_made(),
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(context: context, builder: (_) => SearchOverlay());
            },
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            color: Color(0xffE4E4E4),
          ),
        ],
      ),
    );
  }
}
