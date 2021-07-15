import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/product/ProductPage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key key,
    @required this.themeColor,
    this.product,
  }) : super(key: key);

  final Provider_control themeColor;
  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ServiceData = Provider.of<Provider_Data>(context);

    return Stack(
      children: <Widget>[
        Container(
          // width: ScreenUtil.getWidth(context) / 2.5,
          //margin: EdgeInsets.only(left: 12, top: 12, bottom: 12,right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () {
              Nav.route(
                  context,
                  ProductPage(
                    product: widget.product,
                  ));
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 5.0,
                    spreadRadius: 1,
                    offset: Offset(0.0, 2)),
              ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CachedNetworkImage(
                    width: ScreenUtil.getWidth(context) / 2,
                    height: ScreenUtil.getHeight(context) / 5,
                    imageUrl: (widget.product.photo.isEmpty)
                        ? 'http://arabimagefoundation.com/images/defaultImage.png'
                        : widget.product.photo[0].image,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) => Icon(
                      Icons.image,
                      color: Colors.black12,
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: ScreenUtil.getWidth(context) / 2.1,
                    padding: EdgeInsets.only(left: 5, top: 10, right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: ScreenUtil.getWidth(context) / 2.2,
                          child: AutoSizeText(
                            widget.product.name,
                            maxLines: 1,
                            style: TextStyle(
                              color: Color(0xFF5D6A78),
                              fontWeight: FontWeight.w300,
                            ),
                            minFontSize: 13,
                            maxFontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: ScreenUtil.getWidth(context) /6,

                              child: RatingBar.builder(
                                ignoreGestures: true,
                                initialRating:
                                    widget.product.avgValuations.toDouble(),
                                itemSize: ScreenUtil.getWidth(context) / 40,
                                minRating: 0.5,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                            ),
                          AutoSizeText(
                              widget.product.producttypeId == 2?"": "${widget.product.action_price} ${getTransrlate(context, 'Currency')} ",
                            maxLines: 1,
                            maxFontSize: 12,
                            style: TextStyle(
                                color:Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                          ],
                        ),
                        widget.product.producttypeId == 2
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "الحد الادنى : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,fontSize: 11),
                                ),
                                Text(
                                  '${widget.product.noOfOrders ?? ' '} ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,fontSize: 12,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Text(
                              '${widget.product.holesalePrice ?? ' '} ${getTransrlate(context, 'Currency')} ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: 11,
                                  color: Colors.black),
                            ),
                          ],
                        )
                            : Container(
                          //  width: ScreenUtil.getWidth(context) / 4,
                            child: widget.product.discount == 0
                                ? Container(child:  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                " ",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),)
                                : Container(

                                  // width: ScreenUtil.getWidth(context) / 2,
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                     children: [
                                      SizedBox(width: 10,),

                                       Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 5),
                                         child: Text(
                                           " ${widget.product.price} ",
                                           style: TextStyle(
                                             decoration: TextDecoration.lineThrough,
                                             fontSize: 12,
                                             fontWeight: FontWeight.bold,
                                             color: Colors.red,
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                API(context).post('add/to/cart', {
                                  "product_id": widget.product.id,
                                  "quantity": 1
                                }).then((value) {
                                  if (value != null) {
                                    print(value);
                                    if (value['status_code'] == 200) {
                                      showDialog(
                                          context: context,
                                          builder: (_) =>
                                              ResultOverlay(value['message'],
                                                  icon: Icon(
                                                    Icons.check_circle_outline,
                                                    color: Colors.green,
                                                    size: 80,

                                                  )));
                                      ServiceData.getCart(context);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (_) => ResultOverlay(
                                              '${value['message'] ?? ''}\n${value['errors'] ?? ""}',
                                              icon: Icon(
                                                Icons.info_outline,
                                                color: Colors.yellow,
                                                size: 80,
                                              )));
                                    }
                                  }
                                });
                              },
                              icon: Icon(
                                CupertinoIcons.cart,
                                size: 30,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            IconButton(
                              onPressed: () {
                                print(widget.product.inWishlist);
                                widget.product.inWishlist == 0
                                    ? API(context).post('user/add/wishlist', {
                                        "product_id": widget.product.id
                                      }).then((value) {
                                        if (value != null) {
                                          if (value['status_code'] == 200) {
                                            setState(() {
                                              widget.product.inWishlist = 1;
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (_) => ResultOverlay(
                                                    value['message'],
                                                    icon: Icon(
                                                      Icons.check_circle_outline,
                                                      size: 80,

                                                      color: Colors.green,
                                                    )));
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (_) => ResultOverlay(
                                                      '${value['data'] ?? ""}',
                                                      icon: Icon(
                                                        Icons.info_outline,
                                                        size: 80,

                                                        color: Colors.yellow,
                                                      ),
                                                    ));
                                          }
                                        }
                                      })
                                    : API(context).post(
                                        'user/removeitem/wishlist', {
                                        "product_id": widget.product.id
                                      }).then((value) {
                                        if (value != null) {
                                          if (value['status_code'] == 200) {
                                            setState(() {
                                              widget.product.inWishlist = 0;
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (_) => ResultOverlay(
                                                    value['message'],
                                                    icon: Icon(
                                                      Icons.check_circle_outline,
                                                      color: Colors.green,
                                                      size: 80,

                                                    )));
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (_) => ResultOverlay(
                                                    value['data'],
                                                    icon: Icon(
                                                      Icons.info_outline,
                                                      color: Colors.yellow,
                                                      size: 80,

                                                    )));
                                          }
                                        }
                                      });
                              },
                              icon: Icon(
                                widget.product.inWishlist == 0
                                    ? Icons.favorite_border
                                    : Icons.favorite,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
