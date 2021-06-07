import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/ProductPage.dart';
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
          width: ScreenUtil.getWidth(context) / 2.5,
          margin: EdgeInsets.only(left: 6, top: 8, right: 6, bottom: 2),
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
                        color: Colors.black12,
                        blurRadius: 2.0,
                        spreadRadius: 1,
                        offset: Offset(0.0, 1)),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: CachedNetworkImage(
                      width: ScreenUtil.getWidth(context) / 2,
                      imageUrl: (widget.product.photo.isEmpty)
                          ? 'http://arabimagefoundation.com/images/defaultImage.png'
                          : widget.product.photo[0].image,
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) => Icon(Icons.image,color: Colors.black12,),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: ScreenUtil.getWidth(context) / 2.1,
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AutoSizeText(
                          widget.product.name,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF5D6A78),
                            fontWeight: FontWeight.w300,
                          ),
                          minFontSize: 11,
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
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
                            SizedBox(
                              width: 6,
                            ),
                            Container(
                              width: ScreenUtil.getWidth(context)/6.7,
                              child: AutoSizeText(

                                "${widget.product.price??0} ${getTransrlate(context, 'Currency')}",
                                maxLines: 1,
                                minFontSize: 14,
                                maxFontSize: 25,
                                style: TextStyle(
                                    color: widget.themeColor.getColor(),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
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
                                      ServiceData.getCart(context);

                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (_) => ResultOverlay(
                                              value['message']));
                                    }
                                  }
                                });
                              },
                              icon: Icon(CupertinoIcons.cart,size: 30,
                                  color: Colors.black,),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            IconButton(
                              onPressed: () {
                                widget.product.inWishlist==0?
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
                                }):API(context).post('user/removeitem/wishlist',{
                                  "product_id":widget.product.id
                                })
                                    .then((value) {
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
                              icon: Icon(
                               widget.product.inWishlist=="0"?
                               Icons.favorite_border:Icons.favorite,
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
