import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/cart_model.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/screens/Address_Page.dart';
import 'package:flutter_pos/screens/category/productCategory.dart';
import 'package:flutter_pos/screens/checkoutPage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/Cart/product_cart.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'MyCars/myCars.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int checkboxType = 0;

  @override
  void initState() {
    Provider.of<Provider_Data>(context, listen: false).getCart(context) ;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final _cart_model = Provider.of<Provider_Data>(context).cart_model;

    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: () {
              Nav.route(
                  context,
                  CheckOutPage(
                    carts: _cart_model,
                  ));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 12),
              padding: const EdgeInsets.all(12.0),
              color: Colors.lightGreen,
              child: Center(
                  child: Text(
                    'إتمام عملية الشراء',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: themeColor.getColor(),
            padding: const EdgeInsets.only(top: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: ScreenUtil.getHeight(context) / 10,
                    width: ScreenUtil.getWidth(context) / 3,
                    fit: BoxFit.contain,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Nav.route(context, MyCars());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/car2.svg',
                        fit: BoxFit.contain,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        themeColor.getCar_made(),
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context, builder: (_) => SearchOverlay());
                  },
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  ),
                  color: Color(0xffE4E4E4),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child:themeColor.isLogin? Column(
                children: [
                  _cart_model == null
                      ? Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ))
                      : _cart_model.data==null?Container():SingleChildScrollView(
                          child: _cart_model.data.orderDetails.isEmpty
                              ? Container(
                                  height: ScreenUtil.getHeight(context) / 1.5,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/reload.svg",
                                        width: ScreenUtil.getWidth(context) / 3,
                                        color: Colors.black12,
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        'لا يوجد منتجات',
                                        style: TextStyle(color: Colors.black45,fontSize: 25),
                                      ),
                                      Text(
                                        'في عربة التسوق',
                                        style: TextStyle(color: Colors.black45,fontSize: 25),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'عربة التسوق (${_cart_model.cartTotal})',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Nav.route(context, Shipping_Address());
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                color: Colors.orange,
                                              ),
                                              Container(
                                                  width:
                                                      ScreenUtil.getWidth(context) /
                                                          1.3,
                                                  child: Text(
                                                    'توصيل إلى: مبنى 15، تبوك، شارع الأمير سلمان',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 14),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 35),
                                        child: Container(
                                          height: 1,
                                          color: Colors.black12,
                                        ),
                                      ),
                                      ListView.builder(
                                        primary: false,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.all(1),
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: _cart_model.data.orderDetails.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ProductCart(themeColor: themeColor,carts: _cart_model.data.orderDetails[index]);
                                        },
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: AutoSizeText(
                                                  "المجموع",
                                                  maxLines: 1,
                                                  minFontSize: 20,
                                                  maxFontSize: 25,
                                                  style: TextStyle(
                                                      color: themeColor.getColor(),
                                                      fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                              Container(
                                                child: AutoSizeText(
                                                  " ${_cart_model.data.orderTotal} ${getTransrlate(context, 'Currency')}",
                                                  maxLines: 1,
                                                  minFontSize: 20,
                                                  maxFontSize: 25,
                                                  style: TextStyle(
                                                      color: themeColor.getColor(),
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 35),
                                        child: Container(
                                          height: 1,
                                          color: Colors.black12,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  ),
                                ),
                        )
                ],
              ): Center(
                child: Container(
                  height: ScreenUtil.getHeight(context) / 1.5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/ic_user_profile.svg",
                        width: ScreenUtil.getWidth(context) / 3,
                        color: Colors.black12,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'لا يوجد لديك حساب',
                        style: TextStyle(color: Colors.black45,fontSize: 25),
                      ),
                      Text(
                        'برجاء تسجيل دخول',
                        style: TextStyle(color: Colors.black45,fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }





}
