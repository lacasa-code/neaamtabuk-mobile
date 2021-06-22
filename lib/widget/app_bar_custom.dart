import 'package:auto_size_text/auto_size_text.dart';
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
    bool isback ;
    String title ;
     AppBarCustom({this.isback=false,this.title});

  @override
  _AppBarCustomState createState() => _AppBarCustomState();

}

class _AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Container(
      height: ScreenUtil.getHeight(context) / 7,

      color: themeColor.getColor(),
      padding: const EdgeInsets.only(top: 35),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
         ! widget.isback?Container():IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25,
            ),
            color: Color(0xffE4E4E4),
          ),
         widget.title!=null? Container(
           width: ScreenUtil.getWidth(context) / 4,
           child: AutoSizeText(
             '${widget.title}',
             maxLines: 2,
             maxFontSize: 15,
             minFontSize: 10,
             overflow: TextOverflow.ellipsis,
             style: TextStyle(color: Colors.white),
           ),
         ):Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: ScreenUtil.getHeight(context) / 10,
              width: ScreenUtil.getWidth(context) / 4,
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
                Icon(CupertinoIcons.car_detailed,color: Colors.white,),
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
