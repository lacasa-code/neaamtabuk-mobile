import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/review.dart';
import 'package:flutter_pos/screens/product/writerate.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../model/cart_category.dart';
import '../../model/manufacturers.dart';
import '../../model/origins.dart';
import '../../service/api.dart';
import '../../utils/screen_size.dart';

class Ratedialog extends StatefulWidget {
  Ratedialog(this.reviews, this.id);

  Reviews reviews;
  int id;

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
                  widget.reviews == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(height: 5),
                              widget.reviews.avgValuations == null
                                  ? Container()
                                  : Row(
                                      children: [
                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating: double.parse('${widget.reviews.avgValuations ?? 0}'),
                                          itemSize: 25.0,
                                          minRating: 0.5,
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
                                          "${widget.reviews.avgValuations ?? 0}/5 ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        Text(
                                          " (${widget.reviews.reviewsCount} تقييم ) ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                              SizedBox(height: 15),
                              widget.reviews.reviewsData.isEmpty
                                  ? Container(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/reload.svg",
                                      width:
                                      ScreenUtil.getWidth(context) /
                                          3,
                                      color: Colors.black12,
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      getTransrlate(context, 'EmptyRate'),
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 25),
                                    ),
                                  ],
                                ),
                              )
                                  :  ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: widget.reviews.reviewsData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating: widget
                                              .reviews.reviewsData[index].evaluationValue
                                              .toDouble(),
                                          itemSize: 20.0,
                                          minRating: 0.5,
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
                                        SizedBox(height: 5),
                                        Text(
                                          widget.reviews.reviewsData[index]
                                              .bodyReview,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          '${widget.reviews.reviewsData[index].createdAt} بواسطة ${widget.reviews.reviewsData[index].userName}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 1,
                                          color: Colors.black12,
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 25,
                              ),
                               Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    WriteRatedialog(widget.id)).then((value) {
                                              API(context).get('home/review/product/${widget.id}').then((value) {
                                                setState(() {
                                                  widget.reviews = Review_model.fromJson(value).data;
                                                });
                                              });
                                            });
                                          },
                                          child: Container(
                                            width:
                                                ScreenUtil.getWidth(context) /
                                                    2.5,
                                            padding: const EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.edit_outlined,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  width: ScreenUtil.getWidth(
                                                          context) /
                                                      4,
                                                  child: AutoSizeText(
                                                    'كتابة تقييم',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxFontSize: 14,
                                                    maxLines: 1,
                                                    minFontSize: 10,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
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
          ],
        ),
      ),
    );
  }
}
