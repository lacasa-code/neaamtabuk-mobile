import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/model/cart_model.dart';
import 'package:flutter_pos/model/checkout_model.dart';
import 'package:flutter_pos/model/payment_model.dart';
import 'package:flutter_pos/model/shipping_address.dart';
import 'package:flutter_pos/screens/MyCars/myCars.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'add_address.dart';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key key, this.carts}) : super(key: key);
  Cart_model carts;

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  int _currentStep = 0;
  List<Address> address;
  List<Payment> payment;
  int checkboxValue;
  int checkboxPay;
  final _formKey = GlobalKey<FormState>();
  Checkout_model checkout_model;
  @override
  void initState() {
    getAddress();
    getpaymentways();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            AppBarCustom(isback: true,),
            Expanded(
              child: Theme(
                data: ThemeData(
                    fontFamily: 'Cairo',
                    primaryColor: Colors.lightGreen,
                    accentColor: Colors.orange,
                    backgroundColor: Colors.orange,
                    primarySwatch: Colors.orange,
                    colorScheme: ColorScheme.light(
                      primary: Colors.lightGreen,
                    )),
                child: Stepper(
                  type: StepperType.horizontal,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: _currentStep == 2 ? null : continued,
                  onStepCancel: cancel,
                  controlsBuilder: _createEventControlBuilder,
                  steps: <Step>[
                    Step(
                      title: Text(
                        getTransrlate(context, 'shipping'),
                      ),
                      content: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              getTransrlate(context, 'shippingTo'),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            address == null
                                ? CircularProgressIndicator()
                                : ListView.builder(
                                    padding: EdgeInsets.all(1),
                                    primary: false,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: address.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Center(
                                          child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Radio<int>(
                                            value: index,
                                            groupValue: checkboxValue,
                                            activeColor: themeColor.getColor(),
                                            focusColor: themeColor.getColor(),
                                            hoverColor: themeColor.getColor(),
                                            onChanged: (int value) {
                                              setState(() {
                                                checkboxValue = value;
                                                API(context).post(
                                                    'user/select/shipping/${address[index].id}',
                                                    {}).then((value) {
                                                  if (value != null) {
                                                    if (value['status_code'] ==
                                                        201) {
                                                      Navigator.pop(context);
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              ResultOverlay(value[
                                                                  'message']));
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              ResultOverlay(value[
                                                                  'message']));
                                                    }
                                                  }
                                                });
                                              });
                                            },
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                checkboxValue = index;
                                              });
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  address[index].recipientName,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          checkboxValue == index
                                                              ? FontWeight.bold
                                                              : FontWeight.w400,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  "${address[index].address}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          checkboxValue == index
                                                              ? FontWeight.bold
                                                              : FontWeight.w400,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: SizedBox(
                                            height: 1,
                                          )),
                                        ],
                                      ));
                                    },
                                  ),
                            Center(
                              child: GestureDetector(
                                child: Container(
                                  width: ScreenUtil.getWidth(context) / 2.5,
                                  margin: const EdgeInsets.all(10.0),
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.orange)),
                                  child: Center(
                                    child: AutoSizeText(
                                      getTransrlate(context, 'AddNewAddress'),
                                      overflow: TextOverflow.ellipsis,
                                      maxFontSize: 14,
                                      maxLines: 1,
                                      minFontSize: 10,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _navigate_add_Address(context);
                                },
                              ),
                            ),
                            Text(
                              "${getTransrlate(context, 'Shipping')} 1",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12)),
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                    padding: EdgeInsets.all(1),
                                    primary: false,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        widget.carts.data.orderDetails.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:
                                                ScreenUtil.getWidth(context) /
                                                    8,
                                            child: CachedNetworkImage(
                                              imageUrl: widget
                                                      .carts
                                                      .data
                                                      .orderDetails[index]
                                                      .productImage
                                                      .isNotEmpty
                                                  ? widget
                                                      .carts
                                                      .data
                                                      .orderDetails[index]
                                                      .productImage[0]
                                                      .image
                                                  : '',
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.image,color: Colors.black12,),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width:ScreenUtil.getWidth(context)/2,
                                            child: AutoSizeText(
                                              widget
                                                  .carts
                                                  .data
                                                  .orderDetails[index]
                                                  .productName,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              minFontSize: 11,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.black12,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${getTransrlate(context, 'fees_ship')} : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
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
                                            Text(
                                              'ARAMIX',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              'متوقع وصولها يوم 25-6-2021',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '40 ${getTransrlate(context, 'Currency')}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CartList(),
                            Center(
                              child: InkWell(
                                onTap: continued,
                                child: Container(
                                  width: ScreenUtil.getWidth(context) / 2,
                                  margin: const EdgeInsets.only(
                                      top: 16.0, right: 25, left: 25),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      border:
                                          Border.all(color: Colors.lightGreen)),
                                  child: Center(
                                    child: Text(
                                      getTransrlate(context, 'next_checkout'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: Text(getTransrlate(context, 'payment'),),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            getTransrlate(context, 'shippingTo'),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'محمد حسن مبنى 12 ش الملك عبدالله، تبوك، المملكة العربية السعودية+966050412236',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'بواسطة ارامكس  ARAMIX ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'متوقع وصولها يوم 25-6-2021',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: InkWell(
                              onTap: () {
                                cancel();
                              },
                              child: Text(
                                getTransrlate(context, 'edit'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              getTransrlate(context, 'paymentMethod'),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          payment==null?Container(): Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12)),
                              padding: const EdgeInsets.all(12.0),
                              child: ListView.builder(
                                padding: EdgeInsets.all(1),
                                primary: false,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: payment.length,
                                itemBuilder: (BuildContext context, int index){
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Radio<int>(
                                              value: index,
                                              groupValue: checkboxPay,
                                              activeColor:
                                                  themeColor.getColor(),
                                              focusColor: themeColor.getColor(),
                                              hoverColor: themeColor.getColor(),
                                              onChanged: (int value) {
                                                setState(() {
                                                  checkboxPay = value;
                                                });
                                                API(context).post(
                                                    'user/select/paymentway',
                                                    {"paymentway_id":payment[index].id}).then((value) {
                                                  if (value != null) {
                                                    if (value['status_code'] ==
                                                        201) {
                                                      Navigator.pop(context);
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              ResultOverlay(value[
                                                              'message']));
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              ResultOverlay(value[
                                                              'message']));
                                                    }
                                                  }
                                                });
                                              },
                                            ),
                                            Text(
                                              payment[index].paymentName??' ',
                                              style: TextStyle(
                                                  fontWeight: checkboxPay == 1
                                                      ? FontWeight.bold
                                                      : FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                            Expanded(
                                                child: SizedBox(
                                              height: 1,
                                            )),
                                          ],
                                        ),
                                  checkboxPay == 0&&index==0
                                  ? Container(
                                                child: Column(
                                                  children: [
                                                    MyTextFormField(
                                                      intialLabel: '',
                                                      keyboard_type:
                                                          TextInputType.number,
                                                      labelText: getTransrlate(context, 'CardNumber'),
                                                      hintText:
                                                          'xxxx xxxx xxxx xxxx',
                                                      isPhone: true,
                                                      validator:
                                                          (String value) {
                                                        if (value.isEmpty) {
                                                          return getTransrlate(context, 'CardNumber');
                                                        }
                                                        _formKey.currentState
                                                            .save();
                                                        return null;
                                                      },
                                                      onSaved:
                                                          (String value) {},
                                                    ),
                                                    MyTextFormField(
                                                      intialLabel: '',
                                                      keyboard_type:
                                                          TextInputType.number,
                                                      labelText:
                                                      getTransrlate(context, 'CardName'),
                                                      hintText: getTransrlate(context, 'CardName'),
                                                      isPhone: true,
                                                      validator:
                                                          (String value) {
                                                        if (value.isEmpty) {
                                                          return getTransrlate(context, 'CardName');
                                                        }
                                                        _formKey.currentState
                                                            .save();
                                                        return null;
                                                      },
                                                      onSaved:
                                                          (String value) {},
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          child:
                                                              MyTextFormField(
                                                            intialLabel: '',
                                                            keyboard_type:
                                                                TextInputType
                                                                    .number,
                                                            labelText: getTransrlate(context, 'month'),
                                                            hintText: '',
                                                            isPhone: true,
                                                            validator:
                                                                (String value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return getTransrlate(context, 'month');
                                                              }
                                                              _formKey
                                                                  .currentState
                                                                  .save();
                                                              return null;
                                                            },
                                                            onSaved: (String
                                                                value) {},
                                                          ),
                                                        ),
                                                        Container(
                                                            width: 50,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 50),
                                                            child: Center(
                                                                child: Text(
                                                              '/',
                                                              style: TextStyle(
                                                                  fontSize: 35),
                                                            ))),
                                                        Container(
                                                          width: 50,
                                                          child:
                                                              MyTextFormField(
                                                            intialLabel: '',
                                                            keyboard_type:
                                                                TextInputType
                                                                    .number,
                                                            labelText: getTransrlate(context, 'year'),
                                                            hintText: '',
                                                            isPhone: true,
                                                            validator:
                                                                (String value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return getTransrlate(context, 'year');
                                                              }
                                                              _formKey
                                                                  .currentState
                                                                  .save();
                                                              return null;
                                                            },
                                                            onSaved: (String
                                                                value) {},
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          child:
                                                              MyTextFormField(
                                                            intialLabel: '',
                                                            keyboard_type:
                                                                TextInputType
                                                                    .number,
                                                            prefix: Icon(Icons
                                                                .credit_card),
                                                            labelText:
                                                            getTransrlate(context, 'Cvv'),
                                                            hintText: '',
                                                            isPhone: true,
                                                            validator:
                                                                (String value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return  getTransrlate(context, 'Cvv');
                                                              }
                                                              _formKey
                                                                  .currentState
                                                                  .save();
                                                              return null;
                                                            },
                                                            onSaved: (String
                                                                value) {},
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ) : Container(),
                                      ],
                                    );

                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CartList(),
                          Center(
                            child: InkWell(
                              onTap: (){
                                API(context).post(
                                    'user/checkout', {}).then((value) {
                                  if (value != null) {
                                    if (value['status_code'] ==
                                        200) {
                                      checkout_model=Checkout_model.fromJson(value);
                                      Provider.of<Provider_Data>(context, listen: false).getCart(context);
                                      continued();
                                    }
                                      showDialog(
                                          context: context,
                                          builder: (_) =>
                                              ResultOverlay(value[
                                              'message']));

                                  }
                                });

                              },
                              child: Container(
                                width: ScreenUtil.getWidth(context) / 2,
                                margin: const EdgeInsets.only(
                                    top: 16.0, right: 25, left: 25),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    border:
                                        Border.all(color: Colors.lightGreen)),
                                child: Center(
                                  child: Text(
                                      getTransrlate(context, 'paying'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      isActive: _currentStep >= 1,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: Text(getTransrlate(context, 'next_checkout'),),
                      content: checkout_model==null?Container():Column(
                        children: <Widget>[
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.lightGreen,
                            size: 100,
                          ),SizedBox(height: 10,),
                          Text(
                            '${checkout_model.message}',
                            style: TextStyle(
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                      SizedBox(height: 10,),
                          Text(
                            'شكرا لثقتكم بــتركار .. سوف تصلك رسالة على الهاتف الجوال و البريد الإلكتروني بمعلومات الطلب والتوصيل',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12)),
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${getTransrlate(context, 'OrderNO')} ${checkout_model.data.orderNumber} :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),SizedBox(height: 10,),
                                Text(
                                  '${getTransrlate(context, 'OrderDitails')}',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ), SizedBox(height: 10,),
                                Text(
                                  'بواسطة ارامكس  ARAMIX ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                            SizedBox(height: 10,),
                                Text(
                                  'متوقع وصولها يوم 25-6-2021',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.all(1),
                                  primary: false,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:checkout_model.data.orderDetails.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              ScreenUtil.getWidth(context) / 8,
                                          child: CachedNetworkImage(
                                            imageUrl:checkout_model.data.orderDetails[index]
                                                    .productImage
                                                    .isNotEmpty
                                                ? checkout_model.data.orderDetails[index]
                                                    .productImage[0]
                                                    .image
                                                : '',
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.image,color: Colors.black12,),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              width:ScreenUtil.getWidth(context)/2,
                                              child: AutoSizeText(
                                                checkout_model.data.orderDetails[index]
                                                    .productName,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                minFontSize: 11,
                                              ),
                                            ),
                                            AutoSizeText(
                                              "  : ${getTransrlate(context, 'quantity')}${checkout_model.data.orderDetails[index].quantity}",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                              minFontSize: 11,
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        getTransrlate(context, 'total'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${checkout_model.data.orderTotal} ${getTransrlate(context, 'Currency')} ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: (){
                                      Phoenix.rebirth(context);
                                    },
                                    child: Container(
                                      width: ScreenUtil.getWidth(context) / 2,
                                      margin: const EdgeInsets.only(
                                          top: 16.0, right: 25, left: 25),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border:
                                          Border.all(color: Colors.black26,width: 2)),
                                      child: Center(
                                        child: Text(
                                          getTransrlate(context, 'backToshopping'),

                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          )
                        ],
                      ),
                      isActive: _currentStep >= 2,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createEventControlBuilder(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    return Container();
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  void getAddress() {
    API(context).get('user/all/shippings').then((value) {
      if (value != null) {
        setState(() {
          address = ShippingAddress.fromJson(value).data;
        });
      }
    });
  }

  void getpaymentways() {
    API(context).get('all/paymentways').then((value) {
      if (value != null) {
        setState(() {
          payment = Payment_model.fromJson(value).data;
        });
      }
    });
  }

  CartList() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTransrlate(context, 'ShoppingCart'),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                getTransrlate(context, 'backToshoppingCart'),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ListView.builder(
                padding: EdgeInsets.all(1),
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.carts.data.orderDetails.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: ScreenUtil.getWidth(context) / 8,
                            child: CachedNetworkImage(
                              imageUrl: widget.carts.data.orderDetails[index]
                                      .productImage.isNotEmpty
                                  ? widget.carts.data.orderDetails[index]
                                      .productImage[0].image
                                  : '',
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.image,color: Colors.black12,),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width:ScreenUtil.getWidth(context)/2,

                            child: AutoSizeText(
                              widget.carts.data.orderDetails[index].productName,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              minFontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              "${getTransrlate(context, 'quantity')} :  ${widget.carts.data.orderDetails[index].quantity}",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              minFontSize: 11,
                            ),
                            AutoSizeText(
                              "${getTransrlate(context, 'price')} : ${widget.carts.data.orderDetails[index].price}  ${getTransrlate(context, 'Currency')}",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              minFontSize: 11,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                    ],
                  );
                },
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                     "${ getTransrlate(context, 'total_product')}",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '${widget.carts.data.orderTotal} ${getTransrlate(context, 'Currency')} ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      getTransrlate(context, 'fees_ship'),
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '20 ${getTransrlate(context, 'Currency')} ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      getTransrlate(context, 'total_order'),
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '${widget.carts.data.orderTotal} ${getTransrlate(context, 'Currency')} ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
  _navigate_add_Address(BuildContext context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddAddress()));
    Timer(Duration(seconds: 3), () => getAddress());
  }
}
