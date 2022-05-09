import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/RecipentOrdersModel.dart';
import 'package:flutter_pos/screens/widgets/orders_text_widget.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:flutter_pos/widget/not_login.dart';
import 'package:provider/provider.dart';

class RecipentOrders extends StatefulWidget {
  const RecipentOrders({Key key}) : super(key: key);
  @override
  _RecipentOrdersState createState() => _RecipentOrdersState();
}

class _RecipentOrdersState extends State<RecipentOrders> {
  List<RecipentOrder> orders;
  @override
  void initState() {
    getOrders("1");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ProviderControl>(context);
    return !themeColor.isLogin
        ? Notlogin()
        : orders == null
            ? Center(child: Custom_Loading())
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(ScreenUtil.getWidth(context) / 15),
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
                                      horizontal: 18, vertical: 10),
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
                                      SizedBox(
                                        height: 10,
                                      ),
                                      OrderTextWidget(
                                        title:
                                            '${getTransrlate(context, 'representative')} : ',
                                        description:
                                            '${orders[index].delegateUsername}',
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      OrderTextWidget(
                                        width: ScreenUtil.getWidth(context) / 1,
                                        title:
                                            '${getTransrlate(context, 'phone')} : ',
                                        description:
                                            '${orders[index].delegateMobile}',
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      OrderTextWidget(
                                        width: ScreenUtil.getWidth(context),
                                        title:
                                            '${getTransrlate(context, 'OrderDate')} : ',
                                        description:
                                            '${orders[index].delivary_date?.substring(0, 10)?.replaceAll('-', '/')}',
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      OrderTextWidget(
                                        width: ScreenUtil.getWidth(context),
                                        title:
                                            '${getTransrlate(context, 'category')} : ',
                                        description:
                                            '${orders[index].category}',
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
                                                      2,
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

  void getOrders(String from) {
    API(context).get('recipentOrders').then((value) {
      if (value != null) {
        setState(() {
          orders = RecipentOrdersModel.fromJson(value).data;
        });
      }
    });
  }
}
