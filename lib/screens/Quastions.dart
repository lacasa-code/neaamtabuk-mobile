import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/productCarPage.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../model/cart_category.dart';
import '../model/manufacturers.dart';
import '../model/origins.dart';
import '../service/api.dart';
import '../utils/screen_size.dart';

class Qeastionsdialog extends StatefulWidget {
  const Qeastionsdialog({Key key}) : super(key: key);

  @override
  _QeastionsdialogState createState() => _QeastionsdialogState();
}

class _QeastionsdialogState extends State<Qeastionsdialog> {

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 4),
              height: 72,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Color(0xffCCCCCC),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                  top: 8,
                  left: 24,
                  right: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'جميع الأسئلة',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff7B7B7B)),
                    ),
                    IconButton(
                        icon: Icon(Icons.close,
                            size: 35, color: Color(0xff7B7B7B)),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icons/User Icon.svg',color: Colors.grey,height: 35,),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'هل المنتج متوافق مع كامري 2014 ؟',
                                      maxLines: 5,
                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                    ),
                                    Text(
                                      '25-6-2020 بواسطة أحمد',
                                      style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Row(
                              children: [
                                Icon(Icons.message_outlined,color: Colors.grey,size: 35,),
                                SizedBox(width: 10,),
                                Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: ScreenUtil.getWidth(context)/1.6,
                                        child: Text(
                                          'نعم المنتج متوافق مع الموديل يجب التأكد من التركيب بشكل سليم في مركز معتمد لتجنب التلفيات اثناء تركيب المنتج',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 5,
                                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        '25-6-2020 بواسطة أحمد',
                                        style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(height: 1,color: Colors.grey,)
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 25,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                        },
                        child: Container(
                          width: ScreenUtil.getWidth(context)/2.5,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:  Colors.grey
                              )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit_outlined,color: Colors.black,),
                              SizedBox(width: 5,),
                              Container(
                                width: ScreenUtil.getWidth(context)/4,
                                child: AutoSizeText(
                                  'كتابة سؤال',
                                  overflow: TextOverflow.ellipsis,
                                  maxFontSize: 14,
                                  maxLines: 1,
                                  minFontSize: 10,
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

}
