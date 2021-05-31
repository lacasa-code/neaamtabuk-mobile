import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/order_model.dart';
import 'package:flutter_pos/screens/orderdetails.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:intl/intl.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List<Order> orders;
  String dropdownValue = ' آخر 6 شهور ';

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                  width: ScreenUtil.getWidth(context) / 2,
                  child: AutoSizeText(
                    'الطلبات والمشتريات',
                    minFontSize: 10,
                    maxFontSize: 16,
                    maxLines: 1,
                  )),
            ],
          ),
        ),
        body: orders==null?Container():Container(
          padding: EdgeInsets.all(ScreenUtil.getWidth(context)/15),
          child: ListView.builder(
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon:  Icon(Icons.arrow_drop_down_outlined),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Cairo'),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>[' آخر 6 شهور ', ' آخر 12 شهور ']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text("$value"),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),

                    Container(height: 1,color: Colors.black12,),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: ScreenUtil.getWidth(context) / 2.5,
                            child: AutoSizeText(
                                'طلب رقم  ${orders[index].orderNumber}',maxLines: 1,)),
                        AutoSizeText(
                          DateFormat('yyyy-MM-dd').format(DateTime.parse(orders[index].created)),maxLines: 1,),
                      ],
                    ),
                    SizedBox(height: 15,),
                    orders[index].orderDetails==null?Container():  ListView.builder(
                      padding: EdgeInsets.all(1),
                      primary: false,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: orders[index].orderDetails.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Container(
                                width:
                                ScreenUtil.getWidth(context) /
                                    8,
                                child: CachedNetworkImage(
                                  imageUrl:'https://cdn-sharing.adobecc.com/content/storage/id/urn:aaid:sc:US:aa5b859b-f4c9-4193-83b0-cb574fc1500e;revision=0?component_id=541ceed2-f0c4-432b-80dc-dd58eb0b7e89&api_key=CometServer1&access_token=1622401748_urn%3Aaaid%3Asc%3AUS%3Aaa5b859b-f4c9-4193-83b0-cb574fc1500e%3Bpublic_e0ea48ed44073f2db297b6b7a7af2eff0cfaf01b',
                                  errorWidget:
                                      (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              AutoSizeText(
                               orders[index].orderDetails[i].productId.toString(),
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                minFontSize: 11,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Container(
                        width: ScreenUtil.getWidth(context) / 1.5,
                        child: AutoSizeText(
                          ' إجمالي : ${orders[index].orderTotal} ريال',maxLines: 1,)),
                    SizedBox(height: 15,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Row(
                          children: [
                            AutoSizeText(
                              'حالة الطلب : ',maxLines: 1,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                                child: AutoSizeText(
                                  '${orders[index].orderStatus}',maxLines: 1,)),
                          ],
                        ),
                        InkWell(onTap: (){Nav.route(context, Orderdetails(order: orders[index],));},
                          child: AutoSizeText(
                            'تفاصيل الطلب',maxLines: 1,style: TextStyle(color: Colors.orange,fontSize: 16,decoration: TextDecoration.underline),),
                        ),

                      ],
                    ),
                    SizedBox(height: 15,),
                    Container(height: 1,color: Colors.black12,),

                  ],
                ),
              );
            },
          ),
        ));
  }

  void getOrders() {
    API(context).post('user/show/orders', {}).then((value) {
      if (value != null) {
        setState(() {
          orders = Order_model.fromJson(value).data;
        });
      }
    });
  }
}
