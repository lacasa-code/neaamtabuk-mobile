import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/order_model.dart';
import 'package:flutter_pos/screens/map_sample.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:flutter_pos/widget/not_login.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({Key key}) : super(key: key);
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order> orders = [Order(id: 1, approved: '',orderNumber: 1234)];
  @override
  void initState() {
    getOrders("1");
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
                Icons.local_shipping_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                  width: ScreenUtil.getWidth(context) / 2,
                  child: AutoSizeText(
                    getTransrlate(context, 'Myorders'),
                    minFontSize: 10,
                    maxFontSize: 16,
                    maxLines: 1,
                  )),
            ],
          ),
        ),
        body: !themeColor.isLogin
            ? Notlogin()
            : orders == null
                ? Center(child: Custom_Loading())
                : SingleChildScrollView(
                    child: Container(
                      padding:
                          EdgeInsets.all(ScreenUtil.getWidth(context) / 15),
                      child: Column(
                        children: [
                          orders.isEmpty
                              ? NotFoundProduct(
                                  title: getTransrlate(context, 'NoOrder'),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.all(1),
                                  primary: false,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: orders.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: ScreenUtil.getWidth(
                                                        context) /
                                                    2.5,
                                                child: AutoSizeText(
                                                  '${orders[index].orderNumber}رقم الطلب : ',
                                                  maxLines: 1,
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )),
                                            AutoSizeText(
                                              DateFormat('yyyy-MM-dd').format(
                                                  DateTime.tryParse(
                                                      orders[index].createdAt ??
                                                          '2020-10-10')),
                                              maxLines: 1,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        orders[index].orderDetails == null
                                            ? Container()
                                            : ListView.builder(
                                                padding: EdgeInsets.all(1),
                                                primary: false,
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: orders[index]
                                                    .orderDetails
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int i) {
                                                  return InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: ScreenUtil
                                                                    .getWidth(
                                                                        context) /
                                                                8,
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: orders[
                                                                          index]
                                                                      .orderDetails[
                                                                          i]
                                                                      .productImage
                                                                      .isNotEmpty
                                                                  ? orders[
                                                                          index]
                                                                      .orderDetails[
                                                                          i]
                                                                      .productImage[
                                                                          0]
                                                                      .image
                                                                  : ' ',
                                                              errorWidget:
                                                                  (context, url,
                                                                          error) =>
                                                                      Icon(
                                                                Icons.image,
                                                                color: Colors
                                                                    .black12,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            width: ScreenUtil
                                                                    .getWidth(
                                                                        context) /
                                                                2,
                                                            child: AutoSizeText(
                                                              "${themeColor.getlocal() == 'ar' ? orders[index].orderDetails[i].productName ?? orders[index].orderDetails[i].productNameEn : orders[index].orderDetails[i].productNameEn ?? orders[index].orderDetails[i].productName}",
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              minFontSize: 11,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            width: ScreenUtil.getWidth(context) / 1.5,
                                            child: AutoSizeText(
                                              'حالة التجهيز : جاهز ',
                                              maxLines: 1,
                                            )),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            width: ScreenUtil.getWidth(context) / 1.5,
                                            child: AutoSizeText(
                                              'حالة التغليف :غير جاهز ',
                                              maxLines: 1,
                                            )),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                AutoSizeText(
                                                  '${getTransrlate(context, 'OrderState')}  : ',
                                                  maxLines: 1,
                                                ),
                                                Container(
                                                    width: ScreenUtil.getWidth(
                                                            context) / 4,
                                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.blue)),
                                                    child: Center(
                                                      child: AutoSizeText(
                                                        'تم الاستلام',
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 2,
                                                        maxFontSize: 14,
                                                        minFontSize: 12,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Nav.route(context, MapSample());
                                              },
                                              child: AutoSizeText(
                                                '${getTransrlate(context, 'OrderTrack')} ',
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color:
                                                        themeColor.getColor(),
                                                    fontSize: 14,
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.black12,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ));
  }

  void getOrders(String from) {
    //   API(context).post('user/show/orders', {"from": from}).then((value) {
    //     if (value != null) {
    //       setState(() {
    //         orders = Order_model.fromJson(value).data;
    //       });
    //     }
    //   });
  }
}
