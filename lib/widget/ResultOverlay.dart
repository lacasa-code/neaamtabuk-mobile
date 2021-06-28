import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:provider/provider.dart';

class ResultOverlay extends StatefulWidget {
  String message;
  Widget icon;

  ResultOverlay(this.message,{this.icon});

  @override
  State<StatefulWidget> createState() => ResultOverlayState();
}

class ResultOverlayState extends State<ResultOverlay>
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
      alignment: Alignment.bottomCenter,
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
                widget.icon??  Icon(
                Icons.info_outline,
                  size: 80,
                  color: Colors.lightGreen,
                ),
                Container(width: ScreenUtil.getWidth(context)/2,
                  child: Text(
                    '${widget.message}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: themeColor.getColor(),
                        fontSize: 16,
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
