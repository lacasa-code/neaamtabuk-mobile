import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/productCarPage.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../model/cart_category.dart';
import '../model/manufacturers.dart';
import '../model/origins.dart';
import '../service/api.dart';
import '../utils/screen_size.dart';

class Ratedialog extends StatefulWidget {
  const Ratedialog({Key key}) : super(key: key);

  @override
  _RatedialogState createState() => _RatedialogState();
}

class _RatedialogState extends State<Ratedialog> {

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
                      'التقييمات',
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: double.parse('3.5'),
                        itemSize: 25.0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 1,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(
                        "3.5/5 ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        " (15 تقييم ) ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 25),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            RatingBar.builder(
                              ignoreGestures: true,
                              initialRating: double.parse('3.5'),
                              itemSize: 25.0,
                              minRating: 5,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            Text(
                              'منتج جيد الصناعة ويعتمد عليه أنصح به',
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                            Text(
                              '25-6-2020 بواسطة أحمد',
                              style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey),
                            ),
                            Container(height: 1,color: Colors.grey,)
                          ],
                        ),

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
                                  'كتابة تقييم',
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
