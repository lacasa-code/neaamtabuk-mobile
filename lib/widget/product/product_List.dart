import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/ProductPage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    Key key,
    @required this.themeColor,
    this.product,
  }) : super(key: key);

  final Provider_control themeColor;
  final Product product;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          //width: ScreenUtil.getWidth(context) / 2,
          margin: EdgeInsets.only(left: 16, top: 8, right: 12, bottom: 2),
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 5.0,
                        spreadRadius: 1,
                        offset: Offset(0.0, 2)),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: ScreenUtil.getWidth(context) / 4,
                    child: CachedNetworkImage(
                      imageUrl: (widget.product.photo.isEmpty)
                          ? 'http://arabimagefoundation.com/images/defaultImage.png'
                          : widget.product.photo[0].image,
                      errorWidget: (context, url, error) => Icon(Icons.image,color: Colors.black12,),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      //width: ScreenUtil.getWidth(context) / 1.7,
                      padding: EdgeInsets.only(left: 10, top: 2, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          AutoSizeText(
                            widget.product.name,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF5D6A78),
                              fontWeight: FontWeight.w300,
                            ),
                            minFontSize: 11,
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: double.parse('3.5'),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: ScreenUtil.getWidth(context)/3.2,
                                child: AutoSizeText(
                                  "${widget.product.price} ريال ",
                                  maxLines: 1,
                                  minFontSize: 20,
                                  maxFontSize: 25,
                                  style: TextStyle(
                                      color: widget.themeColor.getColor(),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 6,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  API(context).post('add/to/cart',{
                                    "product_id":widget.product.id,
                                    "quantity":1
                                  }).then((value) {
                                    if (value != null) {
                                      if (value['status_code'] == 200) {
                                        showDialog(
                                            context: context,
                                            builder: (_) => ResultOverlay(
                                                value['message']));
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (_) => ResultOverlay(
                                                value['message']));
                                      }
                                    }
                                  });
                                },
                                icon: Icon(CupertinoIcons.cart,
                                    color: Colors.black,),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                onPressed: () {
                                  print(widget.product.inWishlist);
                                  API(context).post('user/add/wishlist',{
                                    "product_id":widget.product.id
                                  }).then((value) {
                                    if (value != null) {
                                      if (value['status_code'] == 200) {
                                        setState(() {
                                          widget.product.inWishlist="1";

                                        });
                                        showDialog(
                                            context: context,
                                            builder: (_) => ResultOverlay(
                                                value['message']));
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (_) => ResultOverlay(
                                                value['message']));
                                      }
                                    }
                                  });
                                },
                                icon:
                                Icon(
                                  widget.product.inWishlist=="0"?
                                  Icons.favorite_border:Icons.favorite,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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

  bool onLikeTapped() {
    // API(context)
    //     .post('wishlist', {"product_id": widget.product.id}).then((value) => {
    //           if (value['status'] != 'error')
    //             {
    //               setState(() {
    //                 widget.product.w = false;
    //               }),
    //               Scaffold.of(context).showSnackBar(SnackBar(
    //                   backgroundColor: mainColor,
    //                   content: Text(value['message'])))
    //             }
    //           else
    //             {
    //               setState(() {
    //                 widget.product.is_wishlisted = true;
    //               }),
    //               Scaffold.of(context).showSnackBar(SnackBar(
    //                   backgroundColor: mainColor,
    //                   content: Text(value['message'])))
    //             }
    //         });
  }
}
