import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/nearDonors.dart';
import 'package:flutter_pos/screens/map.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:flutter_pos/widget/not_login.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<NearDonor> orders;

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ProviderControl>(context);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              InkWell(
                onTap: () async {
                  await Nav.route(
                      context, MapPage('30', "37", " 30.431297", "37.773972",'10 k '));
                },
                child: Icon(
                  Icons.local_shipping_outlined,
                  color: Colors.white,
                ),
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

                                    return
                                      Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: ScreenUtil.getWidth(
                                                        context) /
                                                    2.5,
                                                child: AutoSizeText(
                                                  '#${orders[index].donation_number}',
                                                  maxLines: 1,
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        Container(
                                            width:
                                                ScreenUtil.getWidth(context) /
                                                    1.5,
                                            child: AutoSizeText(
                                              '${getTransrlate(context, 'Donation_name')} : ${orders[index].username}',
                                              style: TextStyle(
                                                  color: themeColor.getColor()),
                                              maxLines: 1,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            width:
                                                ScreenUtil.getWidth(context) /
                                                    1.5,
                                            child: AutoSizeText(
                                              '${getTransrlate(context, 'phone')} : ${orders[index].mobile} ',
                                              maxLines: 1,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        Row(
                                          children: [
                                            AutoSizeText(
                                              '${getTransrlate(context, 'OrderDate')}  : ',
                                              maxLines: 1,
                                            ),
                                            Center(
                                              child: AutoSizeText(
                                                '${orders[index].delivary_date}',
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
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              '${getTransrlate(context, 'category')}  : ',
                                              maxLines: 1,
                                            ),
                                            Center(
                                              child: AutoSizeText(
                                                '${orders[index].category}',
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
                                          height: 5,
                                        ),
                                        Container(
                                            width:
                                                ScreenUtil.getWidth(context) /
                                                    1.5,
                                            child: AutoSizeText(
                                              '${getTransrlate(context, 'distance')}  : ${double.tryParse(orders[index].distance).toStringAsFixed(4)} Km',
                                              maxLines: 1,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        orders[index].category_id == '1'
                                            ? Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,

                                                    children: [
                                                      AutoSizeText(
                                                        '${getTransrlate(context, 'NoOfmeals')}  : ',
                                                        maxLines: 1,
                                                      ),
                                                      Center(
                                                        child: AutoSizeText(
                                                          '${orders[index].number_of_meals}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          maxFontSize: 13,
                                                          minFontSize: 10,
                                                          style: TextStyle(
                                                              color: themeColor
                                                                  .getColor()),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      AutoSizeText(
                                                        '${getTransrlate(context, 'status_distribute')}  : ',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: themeColor
                                                                .getColor()),
                                                      ),
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              color: themeColor
                                                                  .getColor(),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          9.0)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: AutoSizeText(
                                                              '${orders[index].readyToDistribute == '1' ? getTransrlate(context, 'distribute') : getTransrlate(context, 'nondistribute')} ',
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,

                                                    children: [
                                                      AutoSizeText(
                                                        '${getTransrlate(context, 'status_pack')} :',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: themeColor
                                                                .getColor()),
                                                      ),
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              color: themeColor
                                                                  .getColor(),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          9.0)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: AutoSizeText(
                                                              '${orders[index].readyToPack == '1' ? getTransrlate(context, 'pack') : getTransrlate(context, 'nonpack')} ',
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    '${getTransrlate(context, 'desc')}  : ',
                                                    maxLines: 1,
                                                  ),
                                                  Container(
                                                    width: ScreenUtil.getWidth(context)/1.5,

                                                    child: AutoSizeText(
                                                      '${orders[index].description ?? "لا يوجد  "}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 2,
                                                      maxFontSize: 13,
                                                      minFontSize: 10,
                                                      style: TextStyle(
                                                          color: themeColor
                                                              .getColor()),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        orders[index].delivary_date!=null?  ! DateTime.tryParse(orders[index].delivary_date).isBefore(DateTime.now())?Container():
                                        InkWell(
                                          onTap: () {
                                            Nav.route(
                                                context,
                                                MapPage(
                                                    orders[index].status_id,
                                                    orders[index].id,
                                                    orders[index].latitude,
                                                    orders[index].longitude,
                                                    orders[index].distance,
                                                ));
                                          },
                                          child: AutoSizeText(
                                            '${getTransrlate(context, 'OrderTrack')} ',
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: themeColor.getColor(),
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        ):Container(),
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

  void getOrders() {
    API(context).get('nearDonors').then((value) {
      if (value != null) {
        setState(() {
          orders = NearDonors.fromJson(value).data;
        });
      }
    });
  }
}
