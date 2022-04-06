import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/nearDonors.dart';
import 'package:flutter_pos/screens/map.dart';
import 'package:flutter_pos/screens/widgets/orders_text_widget.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/home_provider.dart';
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
        // appBar: AppBar(
        //   title: Row(
        //     children: [
        //       InkWell(
        //         onTap: () async {
        //           await Nav.route(context,
        //               MapPage('30', "37", " 30.431297", "37.773972", '10 k '));
        //         },
        //         child: Icon(
        //           Icons.local_shipping_outlined,
        //           color: Colors.white,
        //         ),
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Container(
        //           width: ScreenUtil.getWidth(context) / 2,
        //           child: AutoSizeText(
        //             getTransrlate(context, 'Myorders'),
        //             minFontSize: 10,
        //             maxFontSize: 16,
        //             maxLines: 1,
        //           )),
        //     ],
        //   ),
        // ),
        // floatingActionButton: FlatButton(color: themeColor.getColor(),child: Text("Add Order",style: TextStyle(color: Colors.white)),onPressed: (){
        //   Nav.route(context, AddOrderPage());
        // },),
        body: !themeColor.isLogin
            ? Notlogin()
            : orders == null
                ? Center(child: Custom_Loading())
                : SingleChildScrollView(
                    child: Container(
                      // padding: const EdgeInsets.all(8.0),
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
                                                '#${orders[index].donation_number}',
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
                                            description: orders[index].username,
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
                                                ScreenUtil.getWidth(context) /
                                                    1.5,
                                            description: orders[index].mobile,
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
                                                ScreenUtil.getWidth(context) /
                                                    1.5,
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
                                                ScreenUtil.getWidth(context) /
                                                    1.5,
                                            description: orders[index].category,
                                            title: '${getTransrlate(
                                              context,
                                              'category',
                                            )} : ',
                                          ),

                                          SizedBox(
                                            height: 10,
                                          ),
                                          OrderTextWidget(
                                            width:
                                                ScreenUtil.getWidth(context) /
                                                    1.5,
                                            description:
                                                '${double.tryParse(orders[index].distance).toStringAsFixed(4)} Km',
                                            title: '${getTransrlate(
                                              context,
                                              'distance',
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
                                                            color: Color(
                                                                0xff1ca04a),
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
                                                            color: Color(
                                                                0xff1ca04a),
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          ScreenUtil.getWidth(
                                                                  context) /
                                                              2,
                                                      child: AutoSizeText(
                                                        '${orders[index].description ?? "لا يوجد  "}',
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
                                                    ),
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          orders[index].delivary_date != null
                                              ? !DateTime.tryParse(orders[index]
                                                          .delivary_date)
                                                      .isBefore(DateTime.now())
                                                  ? Container()
                                                  : Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        // height: 42,
                                                        width:
                                                            ScreenUtil.getWidth(
                                                                    context) *
                                                                0.4,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(9),
                                                          gradient:
                                                              LinearGradient(
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
                                                            top: 10,
                                                            bottom: 10),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Nav.route(
                                                                context,
                                                                MapPage(
                                                                  key: ValueKey(
                                                                      orders[index]
                                                                          .id),
                                                                  donationName:
                                                                      orders[index]
                                                                          .username,

                                                                  statusId: orders[
                                                                          index]
                                                                      .status_id,
                                                                  donationId:
                                                                      orders[index]
                                                                          .id,
                                                                  donationLatitude:
                                                                      orders[index]
                                                                          .latitude,
                                                                  donationlongitude:
                                                                      orders[index]
                                                                          .longitude,
                                                                  dist: orders[
                                                                          index]
                                                                      .distance,
                                                                  // representativeLatitude: orders[index].,
                                                                  // representativeLongitude: orders[index].recipientLongitude,
                                                                ));
                                                          },
                                                          child: AutoSizeText(
                                                            '${getTransrlate(context, 'OrderTrack')} ',
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                              : Container(),
                                          SizedBox(
                                            height: 15,
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
    API(context).get('nearDonors').then((value) {
      if (value != null) {
        setState(() {
          orders = NearDonors.fromJson(value).data;
        });
      }
    });
  }
}
