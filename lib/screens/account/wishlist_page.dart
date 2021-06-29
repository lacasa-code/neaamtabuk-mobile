import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/wishlist_model.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/not_login.dart';
import 'package:flutter_pos/widget/product/Wish_List_item.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  const WishList({Key key}) : super(key: key);

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List<WishListItem> wishList;
  int checkboxValue;

  @override
  void initState() {
    getwWISHlIST();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Container(
                width: ScreenUtil.getWidth(context) / 2,
                child: AutoSizeText(
                  'قائمة المنتجات المفضلة',
                  minFontSize: 10,
                  maxFontSize: 16,
                  maxLines: 1,
                )),
          ],
        ),
      ),
      body:!themeColor.isLogin?Notlogin(): Container(
        child: wishList == null
            ? Container()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: wishList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wish_List(
                              wishList,
                              themeColor,
                              wishList[index],
                            ),
                          ),
                          Positioned(
                             left:  themeColor.local=='ar'?10:null,
                             right: themeColor.local!='ar'?10:null,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      API(context).post('user/removeitem/wishlist',
                                          {"product_id": wishList[index].productId}).then((value) {
                                        if (value != null) {
                                          if (value['status_code'] == 200) {
                                            showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    ResultOverlay(value['message']));
                                            getwWISHlIST();
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    ResultOverlay('${value['message']??''}\n${value['errors']}'));
                                          }
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                    )),
                                SizedBox(height: 25,),
                                InkWell(
                                  onTap: () {
                                    API(context).post('add/to/cart', {
                                      "product_id": wishList[index].productId,
                                      "quantity": 1
                                    }).then((value) {
                                      if (value != null) {
                                        if (value['status_code'] == 200) {
                                          showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  ResultOverlay(value['message']));
                                          Provider.of<Provider_Data>(context,listen: false).getCart(context);
                                          API(context).post('user/removeitem/wishlist',
                                              {"product_id": wishList[index].productId}).then((value) {
                                            if (value != null) {
                                              if (value['status_code'] == 200) {
                                                getwWISHlIST();
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        ResultOverlay('${value['message']??''}\n${value['errors']}'));
                                              }
                                            }
                                          });
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  ResultOverlay(value['message']));
                                        }
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.orange)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Icon(CupertinoIcons.cart, color: Colors.orange),
                                        Container(
                                          width: ScreenUtil.getWidth(context) / 5,
                                          child: AutoSizeText(
                                            '${getTransrlate(context, 'ADDtoCart')}',
                                            minFontSize: 10,
                                            maxFontSize: 16,
                                            maxLines: 1,
                                            style: TextStyle(color: Colors.orange),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          )

                        ],
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }

  void getwWISHlIST() {
    API(context).get('user/get/wishlist').then((value) {
      if (value != null) {
        setState(() {
          wishList = Wishlist_model.fromJson(value).data;
        });
      }
    });
  }
}
