import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:provider/provider.dart';

class Alerts extends StatefulWidget {
  String message;

  Alerts(this.message);

  @override
  State<StatefulWidget> createState() => AlertsState();
}

class AlertsState extends State<Alerts>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: ScreenUtil.getWidth(context),

            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(height: 25,color: Colors.orange,),
                SizedBox(height: 15,),
               Custom_Loading(),
                Container(width: ScreenUtil.getWidth(context)/2,
                  child: Text(
                    '${widget.message??''}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: themeColor.getColor(),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,),
                  ),
                ),
                SizedBox(height: 15),

                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                      color: Colors.orange,
                      child: Text(getTransrlate(context, 'close'),
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
                SizedBox(height: 45),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
