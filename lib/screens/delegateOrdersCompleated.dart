import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/nearDonors.dart';
import 'package:flutter_pos/model/order_model.dart';
import 'package:flutter_pos/screens/account/addOrder.dart';
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

import '../model/DelegateOrders.dart';

class DelegateCompleated extends StatefulWidget {
  const DelegateCompleated({Key key}) : super(key: key);

  @override
  _DelegateCompleatedState createState() => _DelegateCompleatedState();
}

class _DelegateCompleatedState extends State<DelegateCompleated> {
  List<DelegateOrder> orders;
  var isLoading = false;
  Future<void> onRefresh() async {
    getOrders();
  }

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ProviderControl>(context);
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: !themeColor.isLogin
          ? Notlogin()
          : orders == null
              ? Center(child: Custom_Loading())
              : SingleChildScrollView(
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
                              itemBuilder: (BuildContext context, int index) {
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      OrderTextWidget(
                                        title:
                                            '${getTransrlate(context, 'OrderNO').split('!')[0]}: ',
                                        description:
                                            '#${orders[index].donationNumber}',
                                      ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Container(
                                      //         width: ScreenUtil.getWidth(
                                      //                 context) /
                                      //             2.5,
                                      //         child: AutoSizeText(
                                      //           '#${orders[index].donation_number}',
                                      //           maxLines: 1,
                                      //           style:
                                      //               TextStyle(fontSize: 13),
                                      //         )),
                                      //   ],
                                      // ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      OrderTextWidget(
                                        description:
                                            orders[index].donationUsername,
                                        title: '${getTransrlate(
                                          context,
                                          'Donation_name',
                                        )} : ',
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      OrderTextWidget(
                                        width:
                                            ScreenUtil.getWidth(context) / 1.5,
                                        description:
                                            orders[index].donationMobile,
                                        title: '${getTransrlate(
                                          context,
                                          'phone',
                                        )} : ',
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      OrderTextWidget(
                                        width:
                                            ScreenUtil.getWidth(context) / 1.5,
                                        description:
                                            orders[index].delivary_date,
                                        title: '${getTransrlate(
                                          context,
                                          'OrderDate',
                                        )} : ',
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      OrderTextWidget(
                                        width:
                                            ScreenUtil.getWidth(context) / 1.5,
                                        description: orders[index].category,
                                        title: '${getTransrlate(
                                          context,
                                          'category',
                                        )} : ',
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      orders[index].category_id == '1'
                                          ? Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    AutoSizeText(
                                                      '${getTransrlate(context, 'NoOfmeals')} : ',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    AutoSizeText(
                                                      '${orders[index].number_of_meals ?? ''}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 2,
                                                      maxFontSize: 13,
                                                      minFontSize: 10,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
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
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    AutoSizeText(
                                                      '${orders[index].readyToDistribute == '1' ? getTransrlate(context, 'distribute') : getTransrlate(context, 'nondistribute')} ',
                                                      // '${orders[index].number_of_meals ?? ''}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 2,
                                                      maxFontSize: 13,
                                                      minFontSize: 10,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xff1ca04a),
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
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    AutoSizeText(
                                                      '${orders[index].readyToPack == '1' ? getTransrlate(context, 'pack') : getTransrlate(context, 'nonpack')} ',
                                                      // '${orders[index].number_of_meals ?? ''}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 2,
                                                      maxFontSize: 13,
                                                      minFontSize: 10,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xff1ca04a),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                  '${getTransrlate(context, 'desc')}  : ',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Container(
                                                  width: ScreenUtil.getWidth(
                                                          context) /
                                                      1.6,
                                                  child: AutoSizeText(
                                                    '${orders[index].description ?? "لا يوجد  "}',
                                                    textAlign: TextAlign.start,
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
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          AutoSizeText(
                                            '${getTransrlate(context, 'OrderState')}  : ',
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Center(
                                            child: AutoSizeText(
                                              '${orders[index].status}',
                                              textAlign: TextAlign.center,
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
                                      SizedBox(
                                        height: 5,
                                      ),
                                      // Row(
                                      //   children: [
                                      //     AutoSizeText(
                                      //       '${getTransrlate(context, 'OrderState')}  : ',
                                      //       maxLines: 1,
                                      //     ),
                                      //     Center(
                                      //       child: AutoSizeText(
                                      //         '${orders[index].status}',
                                      //         textAlign: TextAlign.center,
                                      //         maxLines: 2,
                                      //         maxFontSize: 13,
                                      //         minFontSize: 10,
                                      //         style: TextStyle(
                                      //             color:
                                      //                 themeColor.getColor()),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      orders[index].close != null
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                // height: 42,
                                                width: ScreenUtil.getWidth(
                                                        context) *
                                                    0.4,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(9),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xff2CA649),
                                                      Color(0xff2CA649),
                                                      Color(0xff4BB146),
                                                      Color(0xff4BB146),
                                                      Color(0xff66BA44),
                                                      Color(0xff77C042),
                                                    ],
                                                  ),
                                                ),
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: TextButton(
                                                  onPressed: () async {
                                                    API(context).Put(
                                                        'closeAt/${orders[index].id}',
                                                        {}).then((value) {
                                                      print(value);
                                                      if (value['status'] ==
                                                          true) {
                                                        getOrders();

                                                        showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              ResultOverlay(
                                                            '${value['message']}',
                                                            success: true,
                                                          ),
                                                        );
                                                      } else {
                                                        showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                ResultOverlay(
                                                                    '${value['message']}'));
                                                      }
                                                    });
                                                  },
                                                  child: AutoSizeText(
                                                    "${getTransrlate(context, 'closeOrder')}",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                      // Center(
                                      //   child: Container(
                                      //     height: 40,
                                      //     width:
                                      //         ScreenUtil.getWidth(context) /
                                      //             3,
                                      //     margin: EdgeInsets.only(
                                      //         top: 12, bottom: 0),
                                      //     child: FlatButton(
                                      //       shape: RoundedRectangleBorder(
                                      //         borderRadius:
                                      //             new BorderRadius.circular(
                                      //                 9.0),
                                      //       ),
                                      //       color: themeColor.getColor(),
                                      //       onPressed: () async {
                                      //         API(context).Put(
                                      //             'closeAt/${orders[index].id}',
                                      //             {}).then((value) {
                                      //           print(value);
                                      //           if (value['status'] == true) {
                                      //             getOrders();

                                      //             showDialog(
                                      //                 context: context,
                                      //                 builder: (_) =>
                                      //                     ResultOverlay(
                                      //                         '${value['message']}'));
                                      //           } else {
                                      //             showDialog(
                                      //                 context: context,
                                      //                 builder: (_) =>
                                      //                     ResultOverlay(
                                      //                         '${value['message']}'));
                                      //           }
                                      //         });
                                      //       },
                                      //       child: Center(
                                      //         child: Text(
                                      //           "${getTransrlate(context, 'closeOrder')}",
                                      //           textAlign: TextAlign.center,
                                      //           style: TextStyle(
                                      //             fontSize: 16,
                                      //             color: Colors.white,
                                      //             fontWeight: FontWeight.w400,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
    );
  }

  void getOrders() {
    setState(() {
      isLoading = true;
    });
    try {
      API(context).get('delegateOrders').then((value) {
        if (value != null) {
          setState(() {
            orders = DelegateOrders.fromJson(value).data;
          });
        }
        setState(() {
          isLoading = false;
        });
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
