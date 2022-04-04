import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/OrdersModel.dart';
import 'package:flutter_pos/model/donorOrdersModel.dart';
import 'package:flutter_pos/screens/account/addOrder.dart';
import 'package:flutter_pos/screens/account/edit_volunteer.dart';
import 'package:flutter_pos/screens/widgets/orders_text_widget.dart';
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
    final themeColor = Provider.of<ProviderControl>(context);
    return Scaffold(
        // appBar: AppBar(
        //   title: Row(
        //     children: [
        //       Icon(
        //         Icons.local_shipping_outlined,
        //         color: Colors.white,
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Container(
        //           width: ScreenUtil.getWidth(context) / 2,
        //           child: AutoSizeText(
        //             getTransrlate(context, 'orders'),
        //             minFontSize: 10,
        //             maxFontSize: 16,
        //             maxLines: 1,
        //           )),
        //     ],
        //   ),
        // ),
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
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.0,
                                          color: themeColor.getColor(),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              OrderTextWidget(
                                                title:
                                                    '${getTransrlate(context, 'OrderNO').split('!')[0]}: ',
                                                description:
                                                    '#${orders[index].donation_number}',
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      AutoSizeText(
                                                        '${getTransrlate(context, 'category')}  : ',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Center(
                                                        child: AutoSizeText(
                                                          '${orders[index].category ?? ''}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          maxFontSize: 13,
                                                          minFontSize: 10,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      AutoSizeText(
                                                        '${getTransrlate(context, 'OrderDate')}  : ',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Center(
                                                        child: AutoSizeText(
                                                          '${orders[index].delivary_date?.substring(0, 10)?.replaceAll('-', '/') ?? ''}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          maxFontSize: 13,
                                                          minFontSize: 10,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      AutoSizeText(
                                                        '${getTransrlate(context, 'OrderState')}  : ',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Center(
                                                        child: AutoSizeText(
                                                          '${orders[index].status}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          maxFontSize: 13,
                                                          minFontSize: 10,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                          ),
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
                                                          orders[index]
                                                                      .description ==
                                                                  null
                                                              ? Container()
                                                              : Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    AutoSizeText(
                                                                      '${getTransrlate(context, 'desc')}  : ',
                                                                      maxLines:
                                                                          1,
                                                                    ),
                                                                    Container(
                                                                      width: ScreenUtil.getWidth(
                                                                              context) /
                                                                          1.5,
                                                                      child:
                                                                          AutoSizeText(
                                                                        '${orders[index].description}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        maxLines:
                                                                            2,
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            10,
                                                                        style: TextStyle(
                                                                            color:
                                                                                themeColor.getColor()),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                        ],
                                                      ),
                                                    )
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AutoSizeText(
                                                              '${getTransrlate(context, 'NoOfmeals')} : ',
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            AutoSizeText(
                                                              '${orders[index].number_of_meals ?? ''}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              maxLines: 2,
                                                              maxFontSize: 13,
                                                              minFontSize: 10,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
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
                                                              '${getTransrlate(context, 'status_distribute')}  : ',
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            AutoSizeText(
                                                              '${orders[index].readyToDistribute == '1' ? getTransrlate(context, 'distribute') : getTransrlate(context, 'nondistribute')} ',
                                                              // '${orders[index].number_of_meals ?? ''}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              maxLines: 2,
                                                              maxFontSize: 13,
                                                              minFontSize: 10,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
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
                                                              '${getTransrlate(context, 'status_pack')}  : ',
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            AutoSizeText(
                                                              '${orders[index].readyToPack == '1' ? getTransrlate(context, 'pack') : getTransrlate(context, 'nonpack')} ',
                                                              // '${orders[index].number_of_meals ?? ''}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              maxLines: 2,
                                                              maxFontSize: 13,
                                                              minFontSize: 10,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
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
                                          orders[index].status_id != '4'
                                              ? Container()
                                              : Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        Nav.route(
                                                          context,
                                                          EditVolunteerPage(
                                                            orders[index],
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        color:
                                                            Color(0xff69C088),
                                                        padding:
                                                            EdgeInsets.all(3),
                                                        child: ImageIcon(
                                                          AssetImage(
                                                            'assets/icons/edit.png',
                                                          ),
                                                          color: Colors.white,
                                                        ),
                                                        // decoration:
                                                        // BoxDecoration(
                                                        // ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        API(context).post(
                                                            "deleteDonate/${orders[index].donorId}",
                                                            {}).then((value) {
                                                          if (value != null) {
                                                            showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (_) =>
                                                                        ResultOverlay(
                                                                            '${value['message']}'))
                                                                .whenComplete(
                                                                    () {});
                                                          }
                                                          getOrders();
                                                        });
                                                      },
                                                      child: Container(
                                                        color:
                                                            Color(0xffFA6B6B),
                                                        padding:
                                                            EdgeInsets.all(3),
                                                        child: ImageIcon(
                                                          AssetImage(
                                                            'assets/icons/delete.png',
                                                          ),
                                                          color: Colors.white,
                                                        ),
                                                        // decoration:
                                                        // BoxDecoration(
                                                        // ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                          /*
                                              PopupMenuButton<int>(
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      value: 1,
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50)),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          Nav.route(
                                                              context,
                                                              EditVolunteerPage(
                                                                  orders[
                                                                      index]));
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                                "${getTransrlate(context, 'edit')}"),
                                                            Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              color: Colors
                                                                  .black54,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      value: 2,
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50)),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          API(context).post(
                                                              "deleteDonate/${orders[index].donorId}",
                                                              {}).then((value) {
                                                            if (value != null) {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (_) =>
                                                                      ResultOverlay(
                                                                          '${value['message']}')).whenComplete(
                                                                  () {});
                                                            }
                                                            getOrders();
                                                          });
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                                "${getTransrlate(context, 'Delete')}"),
                                                            Icon(
                                                              CupertinoIcons
                                                                  .delete,
                                                              color: Colors
                                                                  .black54,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                */
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
