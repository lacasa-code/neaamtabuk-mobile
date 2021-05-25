import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/cart_model.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/screens/category/productCategory.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'MyCars/myCars.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<OrderDetails> carts;
  Cart_model _cart_model;
  int checkboxType = 0;

  @override
  void initState() {
    API(context).post('show/cart', {}).then((value) {
      if (value != null) {
        setState(() {
          _cart_model = Cart_model.fromJson(value);
          carts = _cart_model.data.orderDetails;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            carts == null
                ? Container()
                : SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'عربة التسوق (${carts.length})',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.orange,
                                ),
                                Container(
                                    width: ScreenUtil.getWidth(context) / 1.3,
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
                            itemCount: carts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            ScreenUtil.getWidth(context) / 3.5,
                                        child: CachedNetworkImage(
                                          imageUrl: carts[index]
                                                  .productImage
                                                  .isNotEmpty
                                              ? carts[index]
                                                  .productImage[0]
                                                  .image
                                              : '',
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            API(context).post(
                                                'delete/from/cart', {
                                              "order_id": carts[index].orderId,
                                              "product_id": carts[index].productId
                                            }).then((value) {
                                              if (value != null) {
                                                if (value['status_code'] ==
                                                    200) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          ResultOverlay(value[
                                                              'message']));
                                                  getCart();
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          ResultOverlay(value[
                                                              'message']));
                                                }
                                              }
                                            });
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.grey,
                                          )),
                                    ],
                                  ),
                                  Container(
                                    color: Colors.white,
                                    //width: ScreenUtil.getWidth(context) / 1.7,
                                    padding: EdgeInsets.only(
                                        left: 10, top: 2, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        AutoSizeText(
                                          carts[index].productName,
                                          maxLines: 3,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          minFontSize: 11,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: ScreenUtil.getWidth(context) / 2.5,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,  crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                                children: [
                                                  Container(
                                                    child: AutoSizeText(
                                                      "الكمية",
                                                      maxLines: 1,
                                                      minFontSize: 20,
                                                      maxFontSize: 25,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .start,  crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey)),
                                                        height: 50,
                                                        width: 50,
                                                        child: Center(
                                                            child: IconButton(
                                                          icon: Icon(Icons.add,
                                                              color: Colors.grey),
                                                              onPressed: (){
                                                               setState(() {
                                                                 carts[index].quantity++;
                                                               });
                                                              },
                                                        )),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey)),
                                                        height: 50,
                                                        width: 50,
                                                        child: Center(
                                                            child: Text(
                                                                "${carts[index].quantity}")),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey)),
                                                        width: 50,
                                                        height: 50,
                                                        child: Center(
                                                            child: IconButton(
                                                          icon: Icon(
                                                            Icons.remove,
                                                            color: Colors.grey,
                                                          ),
                                                              onPressed: (){
                                                                setState(() {
                                                                 if(carts[index].quantity!=1) {
                                                                   carts[index].quantity--;
                                                                 }
                                                                });
                                                              },
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: ScreenUtil.getWidth(context) / 2.5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Container(
                                                    child: AutoSizeText(
                                                      "السعر",
                                                      maxLines: 1,
                                                      minFontSize: 20,
                                                      maxFontSize: 25,
                                                      style: TextStyle(

                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: AutoSizeText(
                                                      " ${carts[index].price} ريال",
                                                      maxLines: 1,
                                                      minFontSize: 20,
                                                      maxFontSize: 25,
                                                      style: TextStyle(
                                                          color: themeColor
                                                              .getColor(),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                                          child: Container(height: 1,color: Colors.black12,),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Container(
                                    child: AutoSizeText(
                                      "السعر",
                                      maxLines: 1,
                                      minFontSize: 20,
                                      maxFontSize: 25,
                                      style: TextStyle(
                                          color: themeColor
                                              .getColor(),
                                          fontWeight:
                                          FontWeight.w400),
                                    ),
                                  ),
                                  Container(
                                    child: AutoSizeText(
                                      " ${_cart_model.data.orderTotal} ريال",
                                      maxLines: 1,
                                      minFontSize: 20,
                                      maxFontSize: 25,
                                      style: TextStyle(
                                          color: themeColor
                                              .getColor(),
                                          fontWeight:
                                          FontWeight.bold),
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

                          Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(12.0),
                            color: Colors.lightGreen,
                            child: Center(
                                child: Text(
                                  'إتمام عملية الشراء',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Colors.white),
                                )),
                          ),

                          SizedBox(height: 30,)
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  getList(List<PartCategories> partCategories) {
    return carts == null
        ? Container()
        : ListView.builder(
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.all(1),
            physics: NeverScrollableScrollPhysics(),
            itemCount: partCategories.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Nav.route(
                        context,
                        ProductCategory(
                          id: partCategories[index].id,
                          name: partCategories[index].categoryName,
                        ));
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              partCategories[index].categoryName,
                              maxLines: 1,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 15,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16, top: 16, left: 16),
                          child: Container(
                            height: 1,
                            color: Colors.black12,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  void getCart() {
    API(context).post('show/cart', {}).then((value) {
      if (value != null) {
        setState(() {
          _cart_model = Cart_model.fromJson(value);
          carts = _cart_model.data.orderDetails;
        });
      }
    });
  }
}
