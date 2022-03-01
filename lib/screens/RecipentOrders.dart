import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/OrdersModel.dart';
import 'package:flutter_pos/screens/map_sample.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:flutter_pos/widget/not_login.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RecipentOrders extends StatefulWidget {
  const RecipentOrders({Key key}) : super(key: key);
  @override
  _RecipentOrdersState createState() => _RecipentOrdersState();
}

class _RecipentOrdersState extends State<RecipentOrders> {
  List<Order> orders = [];
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
                    getTransrlate(context, 'orders'),
                    minFontSize: 10,
                    maxFontSize: 16,
                    maxLines: 1,
                  )),
            ],
          ),
        ),
        // floatingActionButton: FlatButton(color: themeColor.getColor(),child: Text("Add Order",style: TextStyle(color: Colors.white)),onPressed: (){
        //   Nav.route(context, AddOrderPage());
        // },),
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
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            width: ScreenUtil.getWidth(
                                                context) /
                                                2.5,
                                            child: AutoSizeText(
                                              '${getTransrlate(context, 'OrderNO')}  #${orders[index].id} ',
                                              maxLines: 1,
                                              style:
                                              TextStyle(fontSize: 13),
                                            )),
                                        SizedBox(
                                          height: 15,
                                        ),   Container(
                                            width: ScreenUtil.getWidth(
                                                context) /
                                                2.5,
                                            child: AutoSizeText(
                                              '${getTransrlate(context, 'OrderDate')}  #${orders[index].createdAt} ',
                                              maxLines: 1,
                                              style:
                                              TextStyle(fontSize: 13),
                                            )),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(color: themeColor.getColor(),borderRadius: BorderRadius.circular(9.0) ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: AutoSizeText(
                                                    '${orders[index].readyToPack=='1'?"مغلف":"غير مغلف"} ',
                                                    maxLines: 1,
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                )),
                                            Container(
                                                decoration: BoxDecoration(color: themeColor.getColor(),borderRadius: BorderRadius.circular(9.0) ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: AutoSizeText(
                                                    '${orders[index].readyToDistribute=='1'?"جاهز للتوزيع":"غير جاهز للتوزيع"} ',
                                                    maxLines: 1,
                                                    style: TextStyle(color: Colors.white),

                                                  ),
                                                )),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              '${getTransrlate(context, 'OrderState')}  : ',
                                              maxLines: 1,
                                            ),
                                            Center(
                                              child: AutoSizeText(
                                                '${orders[index].nameEn}',
                                                textAlign:
                                                TextAlign.center,
                                                maxLines: 2,
                                                maxFontSize: 13,
                                                minFontSize: 10,
                                                style: TextStyle(color:themeColor.getColor()),

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
      API(context).get('recipentOrders').then((value) {
        if (value != null) {
          setState(() {
            orders = OrdersModel.fromJson(value).data;
          });
        }
      });
  }
}
