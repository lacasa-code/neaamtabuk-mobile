import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/wishlist_model.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class Wish_List extends StatefulWidget {
  List<WishListItem> wishList;
  Provider_control themeColor;
  WishListItem product;
  Wish_List(this.wishList, this.themeColor, this.product);

  @override
  _Wish_ListState createState() => _Wish_ListState();
}

class _Wish_ListState extends State<Wish_List> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,

      child: Row(

        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: ScreenUtil.getWidth(context) / 4,
            child: CachedNetworkImage(
              imageUrl:widget.product.photo==null?' ':widget.product.photo.isNotEmpty?widget.product.photo[0].image:" ",
              errorWidget: (context, url, error) => Icon(Icons.image,color: Colors.black12,),
            ),
          ),
          Expanded(
            child: Container(
              //width: ScreenUtil.getWidth(context) / 1.7,
              padding: EdgeInsets.only(left: 5, top: 10, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: ScreenUtil.getWidth(context) / 2.5,
                        height: 50,
                        child: AutoSizeText(
                          widget.product.productName,
                          maxLines: 2,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 16,
                            color: Color(0xFF5D6A78),
                            fontWeight: FontWeight.w300,
                          ),
                          minFontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              width: ScreenUtil.getWidth(context) / 5,
                              child: RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: widget.product.avg_valuations.toDouble(),
                                itemSize: 14.0,
                                minRating: 1,
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
                            ),
                          ),
                          Container(
                            width: ScreenUtil.getWidth(context) / 5,
                            child: AutoSizeText(
                              "${widget.product.product_price} ${getTransrlate(context, 'Currency')} ",
                              maxLines: 1,
                              minFontSize: 14,
                              maxFontSize: 16,
                              style: TextStyle(
                                  color: widget.themeColor.getColor(),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void getWishList() {
    API(context).get('user/get/wishlist').then((value) {
      if (value != null) {
        setState(() {
          widget.wishList = Wishlist_model.fromJson(value).data;
        });
      }
    });
  }
}
