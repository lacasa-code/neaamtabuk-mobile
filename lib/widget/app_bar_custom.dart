import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:provider/provider.dart';

class AppBarCustom extends StatelessWidget {
  bool isback;
  String title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  AppBarCustom({
    this.isback = false,
    this.title,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ProviderControl>(context);
    return Container(
      height: ScreenUtil.getHeight(context) / 7,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 35),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          !isback
              ? IconButton(
                  onPressed: () {
                    scaffoldKey.currentState.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: themeColor.getColor(),
                    size: 20,
                  ),
                  color: themeColor.getColor(),
                )
              : IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                  color: themeColor.getColor(),
                ),
          title != null
              ? Container(
                  width: ScreenUtil.getWidth(context) / 4,
                  child: AutoSizeText(
                    '${title}',
                    maxLines: 2,
                    maxFontSize: 15,
                    minFontSize: 10,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: themeColor.getColor()),
                  ),
                )
              : InkWell(
                  onTap: () {
                    Phoenix.rebirth(context);
                  },
                  child: Image.asset(
                    'assets/images/trkar_logo_white (copy).png',
                    width: ScreenUtil.getWidth(context) / 2,
                    fit: BoxFit.contain,
                  ),
                ),
          Container()
        ],
      ),
    );
  }
}
