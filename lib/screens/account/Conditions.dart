import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';

class Conditions extends StatelessWidget {
  const Conditions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            width: ScreenUtil.getWidth(context) / 2,
            child: AutoSizeText(
              '${getTransrlate(context, 'Conditions')}',
              minFontSize: 10,
              maxFontSize: 16,
              maxLines: 1,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${getTransrlate(context, 'General_conditions')}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "${getTransrlate(context, 'Regular_user')}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '${getTransrlate(context, 'How_use_app')}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "${getTransrlate(context, 'usage_User')}  ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '${getTransrlate(context, 'Replies_User')}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "${getTransrlate(context, 'webContant')}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
