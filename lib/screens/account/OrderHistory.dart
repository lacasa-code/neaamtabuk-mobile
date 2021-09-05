import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/duration.dart';
import 'package:flutter_pos/model/order_model.dart';
import 'package:flutter_pos/screens/account/orderdetails.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:flutter_pos/widget/not_login.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List<Order> orders;
  Duration_order dropdownValue = Duration_order(' آخر 6 شهور ', 6);
  List<Duration_order> durations = [
    Duration_order(' آخر  شهر ', 1),
    Duration_order(' آخر 3 شهور ', 3),
    Duration_order(' آخر 6 شهور ', 6),
    Duration_order(' آخر 12 شهور ', 12)
  ];

  @override
  void initState() {
    setState(() {
      dropdownValue=durations[0];
    });
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
        body:!themeColor.isLogin?Notlogin(): orders == null
            ? Center(child: Custom_Loading())
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(ScreenUtil.getWidth(context) / 15),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26)),
                          child: DropdownButton<Duration_order>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_drop_down_outlined),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo'),
                            onChanged: (Duration_order newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                              getOrders("${newValue.lenght}");
                            },
                            items: durations
                                .map<DropdownMenuItem<Duration_order>>(
                                    (Duration_order value) {
                              return DropdownMenuItem<Duration_order>(
                                value: value,
                                child: Text("${value.name}"),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      orders.isEmpty?NotFoundProduct(title: getTransrlate(context, 'NoOrder'),):  ListView.builder(
                        padding: EdgeInsets.all(1),
                        primary: false,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: orders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 1,
                                  color: Colors.black12,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width:
                                            ScreenUtil.getWidth(context) / 2.5,
                                        child: AutoSizeText(
                                          '${getTransrlate(context, 'OrderNO')} ${orders[index].orderNumber}-${orders[index].id}',
                                          maxLines: 1,
                                        )),
                                    AutoSizeText(
                                      DateFormat('yyyy-MM-dd').format(
                                          DateTime.parse(
                                              orders[index].createdAt)),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                orders[index].orderDetails == null
                                    ? Container()
                                    : ListView.builder(
                                        padding: EdgeInsets.all(1),
                                        primary: false,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            orders[index].orderDetails.length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          return Container(
                                            padding: EdgeInsets.all(4),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: ScreenUtil.getWidth(
                                                          context) /
                                                      8,
                                                  child: CachedNetworkImage(
                                                    imageUrl: orders[index]
                                                            .orderDetails[i]
                                                            .productImage
                                                            .isNotEmpty
                                                        ? orders[index]
                                                            .orderDetails[i]
                                                            .productImage[0]
                                                            .image
                                                        : ' ',
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
                                                      Icons.image,
                                                      color: Colors.black12,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: ScreenUtil.getWidth(
                                                      context) /
                                                      2,
                                                  child: AutoSizeText(
                                                    orders[index]
                                                        .orderDetails[i]
                                                        .productName,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    minFontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                Container(
                                    width: ScreenUtil.getWidth(context) / 1.5,
                                    child: AutoSizeText(
                                      '${getTransrlate(context, 'total')}  : ${orders[index].orderTotal} ${getTransrlate(context, 'Currency')}',
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
                                            width:
                                                ScreenUtil.getWidth(context) /
                                                   4,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue)),
                                            child: Center(
                                              child: AutoSizeText(
                                                '${orders[index].orderStatus}',
                                                maxLines: 1,
                                                maxFontSize: 20,
                                                minFontSize: 14,
                                              ),
                                            )),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Nav.route(
                                            context,
                                            Orderdetails(
                                              order: orders[index],
                                            ));
                                      },
                                      child: AutoSizeText(
                                        '${getTransrlate(context, 'OrderDitails')} ',
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.underline),
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
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ));
  }

  void getOrders(String from) {
    API(context).post('user/show/orders', {"from": from}).then((value) {
      if (value != null) {
        setState(() {
          orders = Order_model.fromJson(value).data;
        });
      }
    });
  }
}
