import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/order_model.dart';
import 'package:flutter_pos/screens/order/CreateTickits.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:intl/intl.dart';

class Orderdetails extends StatefulWidget {
  Orderdetails({Key key, this.order}) : super(key: key);
  Order order;

  @override
  _OrderdetailsState createState() => _OrderdetailsState();
}

class _OrderdetailsState extends State<Orderdetails> {
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
                  getTransrlate(context, 'Myorders'),
                  minFontSize: 10,
                  maxFontSize: 16,
                  maxLines: 1,
                )),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenUtil.getWidth(context) / 15),
        width: ScreenUtil.getWidth(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${getTransrlate(context, 'OrderDitails')} ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    '${getTransrlate(context, 'OrderNO')} : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ), SizedBox(width: 10,),
                  Text(
                    '${widget.order.orderNumber}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    '${getTransrlate(context, 'OrderDate')} : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ), SizedBox(width: 5,),
                  Text(
                    '${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.order.createdAt))}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    '${getTransrlate(context, 'paymentMethod')} : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '${widget.order.payment==null?'':widget.order.payment.paymentName ?? ' '}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${getTransrlate(context, 'addressShipping')} : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  widget.order.address==null?Container():Text(
                    '${widget.order.address.area==null?'':widget.order.address.area.areaName??''},${widget.order.address.street??''}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${getTransrlate(context, 'OrderPref')} : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        '${getTransrlate(context, 'total_product')} :',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${widget.order.orderTotal} ${getTransrlate(context, 'Currency')}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        '${getTransrlate(context, 'fees_ship')} :',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${widget.order.orderTotal} ${getTransrlate(context, 'Currency')}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        '${getTransrlate(context, 'total_order')} : ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${widget.order.orderTotal} ${getTransrlate(context, 'Currency')}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${getTransrlate(context, 'OrderState')} : ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          width: ScreenUtil.getWidth(context) / 2,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: Text(
                              '${widget.order.orderStatus}',
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          )),
                    ],
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
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${getTransrlate(context, 'Shipping')}  1',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              widget.order.orderDetails == null
                  ? Container()
                  : Container(
                      child: ListView.builder(
                        padding: EdgeInsets.all(1),
                        primary: false,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.order.orderDetails.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Container(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: ScreenUtil.getWidth(context) / 8,
                                      child: CachedNetworkImage(
                                        imageUrl:  widget.order
                                          .orderDetails[i]
                                          .productImage
                                          .isNotEmpty
                                      ? widget.order
                                          .orderDetails[i]
                                          .productImage[0]
                                          .image
                                        : ' ',                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.image,
                                          color: Colors.black12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    AutoSizeText(
                                      widget.order.orderDetails[i].productName
                                          .toString(),
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      minFontSize: 11,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                  InkWell(
                                        onTap: () {
                                          Nav.route(
                                              context,
                                              Tickits(product_id:widget.order.orderDetails[i].productId.toString(),
                                                order_id: widget.order.id.toString(),
                                                vendor_id: widget.order.orderDetails[i].vendorId.toString(),
                                              ));
                                        },
                                        child: AutoSizeText(
                                          '${getTransrlate(context, 'problem')} ',
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 16,
                                              decoration: TextDecoration.underline),
                                        ),
                                      ),
                                      AutoSizeText(
                                        "${getTransrlate(context, 'quantity')}  : ${widget.order.orderDetails[i].quantity}",
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        minFontSize: 11,
                                      ),
                                      AutoSizeText(
                                        "${getTransrlate(context, 'price')}  : ${widget.order.orderDetails[i].price}  ${getTransrlate(context, 'Currency')}",
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        minFontSize: 11,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${getTransrlate(context, 'total_product')} : ${widget.order.orderTotal ?? '0'} ${getTransrlate(context, 'Currency')} ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${getTransrlate(context, 'fees_ship')} : ${widget.order.orderTotal ?? '0'} ${getTransrlate(context, 'Currency')} ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${getTransrlate(context, 'total_order')} : ${widget.order.orderTotal ?? '0'} ${getTransrlate(context, 'Currency')} ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    color: Colors.black12,
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
