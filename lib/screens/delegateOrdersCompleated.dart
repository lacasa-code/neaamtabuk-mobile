import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/nearDonors.dart';
import 'package:flutter_pos/model/order_model.dart';
import 'package:flutter_pos/screens/account/addOrder.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:flutter_pos/widget/not_login.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/DelegateOrders.dart';

class DelegateCompleated extends StatefulWidget {
  const DelegateCompleated({Key key}) : super(key: key);

  @override
  _DelegateCompleatedState createState() => _DelegateCompleatedState();
}

class _DelegateCompleatedState extends State<DelegateCompleated> {
  List<DelegateOrder> orders;

  @override
  void initState() {
    getOrders();
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
                    getTransrlate(context, 'ordersCompleated'),
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: ScreenUtil.getWidth(
                                                        context) /
                                                    2.5,
                                                child: AutoSizeText(
                                                  '#${orders[index].donationNumber}',
                                                  maxLines: 1,
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              'Username  : ',
                                              maxLines: 1,
                                            ),
                                            Center(
                                              child: AutoSizeText(
                                                '${orders[index].donationUsername}',
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                maxFontSize: 13,
                                                minFontSize: 10,
                                                style: TextStyle(
                                                    color:
                                                        themeColor.getColor()),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              'Email  : ',
                                              maxLines: 1,
                                            ),
                                            Center(
                                              child: AutoSizeText(
                                                '${orders[index].donationEmail}',
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                maxFontSize: 13,
                                                minFontSize: 10,
                                                style: TextStyle(
                                                    color:
                                                        themeColor.getColor()),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              'Mobile  : ',
                                              maxLines: 1,
                                            ),
                                            Center(
                                              child: AutoSizeText(
                                                '${orders[index].donationMobile}',
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                maxFontSize: 13,
                                                minFontSize: 10,
                                                style: TextStyle(
                                                    color:
                                                        themeColor.getColor()),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              '${getTransrlate(context, 'desc')} : ',
                                              maxLines: 1,
                                            ),
                                            Center(
                                              child: AutoSizeText(
                                                '${orders[index].description??''}',
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                maxFontSize: 13,
                                                minFontSize: 10,
                                                style: TextStyle(
                                                    color:
                                                    themeColor.getColor()),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 15,
                                        ),

                                        Container(
                                            width:
                                                ScreenUtil.getWidth(context) /
                                                    1.5,
                                            child: AutoSizeText(
                                              '${orders[index].distance??''} km',
                                              style: TextStyle(
                                                  color: themeColor.getColor()),
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              '${getTransrlate(context, 'OrderState')}  : ',
                                              maxLines: 1,
                                            ),
                                            Center(
                                              child: AutoSizeText(
                                                '${orders[index].status}',
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                maxFontSize: 13,
                                                minFontSize: 10,
                                                style: TextStyle(
                                                    color:
                                                        themeColor.getColor()),
                                              ),
                                            ),
                                          ],
                                        ),
                                        orders[index].close!=null?Container():    Center(
                                          child: Container(
                                            height: 40,
                                            width:
                                                ScreenUtil.getWidth(context) /
                                                    2,
                                            margin: EdgeInsets.only(
                                                top: 12, bottom: 0),
                                            child: FlatButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        1.0),
                                              ),
                                              color: themeColor.getColor(),
                                              onPressed: () async {
                                                API(context).Put(
                                                    'closeAt/${orders[index].id}',
                                                    {}).then((value) {
                                                  print(value);
                                                  if (value['status'] == true) {
                                                    getOrders();

                                                    showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            ResultOverlay(
                                                                '${value['message']}'));
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            ResultOverlay(
                                                                '${value['message']}'));
                                                  }
                                                });
                                              },
                                              child: Center(
                                                child: Text(
                                                  "قفل الطلب",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.black12,
                                        ),
                                        SizedBox(
                                          height: 15,
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

  void getOrders() {
    API(context).get('delegateOrders').then((value) {
      if (value != null) {
        setState(() {
          orders = DelegateOrders.fromJson(value).data;
        });
      }
    });
  }
}
