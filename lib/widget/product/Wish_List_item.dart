import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/model/wishlist_model.dart';
import 'package:flutter_pos/screens/ProductPage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: 150,
          width: ScreenUtil.getWidth(context) / 3.5,
          child: CachedNetworkImage(
            imageUrl: "https://cdn-sharing.adobecc.com/content/storage/id/urn:aaid:sc:US:aa5b859b-f4c9-4193-83b0-cb574fc1500e;revision=0?component_id=9825019b-2773-4a38-9b61-cc032ec031d0&api_key=CometServer1&access_token=1621970493_urn%3Aaaid%3Asc%3AUS%3Aaa5b859b-f4c9-4193-83b0-cb574fc1500e%3Bpublic_e5d839e4fa057eb8319d09ed7bbc0970247e6a00",
            errorWidget: (context, url, error) => Icon(Icons.error),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    AutoSizeText(
                      widget.product.productName,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF5D6A78),
                        fontWeight: FontWeight.w300,
                      ),
                      minFontSize: 11,
                    ),
                    IconButton(onPressed: (){
                      API(context).post('user/removeitem/wishlist',{
                        "id":widget.product.id
                      }).then((value) {
                        if (value != null) {
                          if (value['status_code'] == 200) {
                            showDialog(
                                context: context,
                                builder: (_) => ResultOverlay(
                                    value['message']));
                            getWishList();
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) => ResultOverlay(
                                    value['message']));
                          }
                        }
                      });
                    }, icon: Icon(Icons.close,color: Colors.grey,))
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
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
                        Container(
                          width: 50,
                          child: AutoSizeText(
                            "33",
                            maxLines: 1,
                            minFontSize: 20,
                            maxFontSize: 25,
                            style: TextStyle(
                                color: widget.themeColor.getColor(),
                                fontWeight: FontWeight.w400),
                          ),
                        ),

                      ],
                    ),

                    InkWell(
                        onTap: (){
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
                      child: Container(
                        width: ScreenUtil.getWidth(context) / 3.5,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Icon(Icons.add_shopping_cart,
                                color:Colors.orange),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'أضف للعربة',style: TextStyle(color:Colors.orange),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
        )
      ],
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
