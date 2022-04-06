import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:provider/provider.dart';

class ResultOverlay extends StatefulWidget {
  final String message;
  final Widget icon;

  ResultOverlay(this.message, {this.icon});

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
    final themeColor = Provider.of<ProviderControl>(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
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
                    SizedBox(
                      height: 15,
                    ),
                    widget.icon ??
                        Stack(
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Image.asset(
                                'assets/icons/circle.png',
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              top: 0,
                              child: Image.asset(
                                'assets/icons/X_Mark.png',
                              ),
                            ),
                          ],
                        ),
                    Container(
                      width: ScreenUtil.getWidth(context) / 2,
                      child: Text(
                        '${widget.message ?? ''}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themeColor.getColor(),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff2CA649),
                                Color(0xff2CA649),
                                Color(0xff4BB146),
                                Color(0xff4BB146),
                                Color(0xff66BA44),
                                Color(0xff77C042),
                              ],
                            ),
                          ),
                          child: Text(
                            getTransrlate(
                              context,
                              'close',
                            ),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(height: 45),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
