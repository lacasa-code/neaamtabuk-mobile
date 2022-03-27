import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/OrdersModel.dart';
import 'package:flutter_pos/model/donorOrdersModel.dart';
import 'package:flutter_pos/screens/account/addOrder.dart';
import 'package:flutter_pos/screens/account/edit_volunteer.dart';
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

class DonorOrders extends StatefulWidget {
  const DonorOrders({Key key}) : super(key: key);

  @override
  _DonorOrdersState createState() => _DonorOrdersState();
}

class _DonorOrdersState extends State<DonorOrders> {
  List<DonorOrder> orders;

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
                    getTransrlate(context, 'orders'),
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

                      child: Column(
                        children: [
                          orders == null
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
                                    return Container(
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(8.0),

                                      decoration: BoxDecoration(
                                          color:orders[index].category_id=='1'?Colors.black12:orders[index].category_id=='2'?Colors.red[100]:Colors.green[100] ,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(.2),
                                              blurRadius: 9.0, // soften the shadow
                                              spreadRadius: 0.0, //extend the shadow
                                              offset: Offset(
                                                0.0, // Move to right 10  horizontally
                                                1.0, // Move to bottom 10 Vertically
                                              ),
                                            )
                                          ]),                                        child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                  width:
                                                      ScreenUtil.getWidth(context) /
                                                          2.5,
                                                  child: AutoSizeText(
                                                    '${getTransrlate(context, 'OrderNO')}  #${orders[index].donation_number} ',
                                                    maxLines: 1,
                                                    style: TextStyle(fontSize: 13),
                                                  )),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                  width:
                                                      ScreenUtil.getWidth(context) /
                                                          2.5,
                                                  child: AutoSizeText(
                                                    '${getTransrlate(context, 'category')}  ${orders[index].category} ',
                                                    maxLines: 1,
                                                    style: TextStyle(fontSize: 13),
                                                  )),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      AutoSizeText(
                                                        '${getTransrlate(context, 'OrderDate')}  : ',
                                                        maxLines: 1,
                                                      ),
                                                      Center(
                                                        child: AutoSizeText(
                                                          '${orders[index].delivary_date??''}',
                                                          textAlign: TextAlign.center,
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
                                                ],
                                              ),

                                              SizedBox(
                                                height: 10,
                                              ),

                                              orders[index].category_id != '1'
                                                  ? Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          orders[index].description ==
                                                                  null
                                                              ? Container()
                                                              : Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    AutoSizeText(
                                                                      '${getTransrlate(context, 'desc')}  : ',
                                                                      maxLines: 1,
                                                                    ),
                                                                    Container(
                                                                      width: ScreenUtil.getWidth(context)/1.5,

                                                                      child:
                                                                          AutoSizeText(
                                                                        '${orders[index].description}',
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        maxLines: 2,
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            10,
                                                                        style: TextStyle(
                                                                            color: themeColor
                                                                                .getColor()),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                        ],
                                                      ),
                                                    )
                                                  : Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            AutoSizeText(
                                                              '${getTransrlate(context, 'NoOfmeals')}  : ',
                                                              maxLines: 1,
                                                            ),
                                                            AutoSizeText(
                                                              '${orders[index].number_of_meals??''}',
                                                              textAlign:
                                                              TextAlign
                                                                  .start,
                                                              maxLines: 2,
                                                              maxFontSize: 13,
                                                              minFontSize: 10,
                                                              style: TextStyle(
                                                                  color: themeColor
                                                                      .getColor()),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),

                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: AutoSizeText(
                                                                '${getTransrlate(context, 'status_distribute')}  : ',
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: themeColor
                                                                        .getColor()),
                                                              ),
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
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: AutoSizeText(
                                                                '${getTransrlate(context, 'status_pack')} :',
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: themeColor
                                                                        .getColor()),
                                                              ),
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
                                                    ),

                                              SizedBox(
                                                height: 10,
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
                                                          color: themeColor
                                                              .getColor()),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 1,
                                                color: Colors.black12,
                                              ),
                                            ],
                                          ),
                                          orders[index].status_id!='4'?Container():PopupMenuButton<int>(
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                value: 1,
                                                child: InkWell(
                                                  borderRadius: BorderRadius.all(Radius.circular(50)),

                                                  onTap: (){
                                                    Navigator.pop(context);
                                                    Nav.route(context, EditVolunteerPage(orders[index]));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Text("${getTransrlate(context,'edit')}"),
                                                      Icon(
                                                        Icons.edit_outlined,
                                                        color: Colors.black54,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 2,
                                                child:  InkWell(
                                                  borderRadius: BorderRadius.all(Radius.circular(50)),

                                                  onTap: (){
                                                    Navigator.pop(context);
                                                    API(context)
                                                        .post("deleteDonate/${orders[index].donorId}",{})
                                                        .then((value) {
                                                      if (value != null) {
                                                        showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                ResultOverlay('${value['message']}')).whenComplete(() {

                                                        });
                                                      }
                                                      getOrders();
                                                    });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Text("${getTransrlate(context,'Delete')}"),
                                                      Icon(
                                                        CupertinoIcons.delete,
                                                        color: Colors.black54,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
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

  void getOrders() {
    API(context).get('donorOrders').then((value) {
      if (value != null) {
        setState(() {
          orders = DonorOrdersModel.fromJson(value).data;
        });
      }
    });
  }
}
