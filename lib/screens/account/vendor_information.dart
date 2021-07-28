import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/model/area_model.dart';
import 'package:flutter_pos/model/city_model.dart';
import 'package:flutter_pos/model/country_model.dart';
import 'package:flutter_pos/model/vendor_info.dart';
import 'package:flutter_pos/model/vendors_types.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorInfo extends StatefulWidget {
  const VendorInfo({Key key}) : super(key: key);

  @override
  _VendorInfoState createState() => _VendorInfoState();
}

class _VendorInfoState extends State<VendorInfo> {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  bool _isLoading = false;
  Vendor userModal;
  int _value = 0;
  List<Country> contries;
  List<City> cities;
  List<Area> area;
  List<vendor_types> _vendor_types;
  String password;
  final _formKey = GlobalKey<FormState>();
  final address_key = GlobalKey<FormState>();
  List<String> items = ["male", "female"];
  GlobalKey _toolTipKey = GlobalKey();
  GlobalKey _toolTip1 = GlobalKey();
  GlobalKey _toolTip2 = GlobalKey();
  GlobalKey _toolTip3 = GlobalKey();
  File bankDocs;
  File taxCardDocs;
  File commercialDocs;
  File wholesaleDocs;
  String country, areas, city,  address, phone;

  @override
  void initState() {
    getCountry();

    API(context).get('add-vendors/get/types').then((value) {
      if (value != null) {
        if (value['status_code'] == 200) {
          setState(() {
            _vendor_types = Vendors_types.fromJson(value).data;
          });
        } else {
          showDialog(
              context: context,
              builder: (_) => ResultOverlay(value['message']));
        }
      }
      API(context).get('vendor/saved/docs').then((value) {
        if (value != null) {
          if (value['status_code'] == 200) {
            setState(() {
              userModal = Vendor_info.fromJson(value).data;
              _status=userModal.approved!=1;
              _value = int.parse(userModal.type);
            });
          } else {
            showDialog(
                context: context,
                builder: (_) => ResultOverlay(value['message']));
          }
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/store.svg",
                color: Colors.white,
                height: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text('حساب البائع'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: userModal == null
              ? Container(
                  height: 200,
                  color: Colors.white,
                  child: Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              themeColor.getColor()))))
              :userModal.approved == 1
              ? Center(
                child: Container(
            width: ScreenUtil.getWidth(context)/1.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SvgPicture.asset(
                        "assets/icons/Attention.svg",
                        color: Colors.green,
                        height: 100,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'حسابك كبائع حاليا مفعل',
                        style: TextStyle(color: Colors.green,fontSize: 25),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: ScreenUtil.getWidth(context)/2,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'نوع التاجر :',
                                  style: TextStyle(color: Colors.green,fontSize: 16),
                                ),
                                Text(
                                  '${userModal.venType}',
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'الشركة :',
                                  style: TextStyle(color: Colors.green,fontSize: 16),
                                ),
                                Text(
                                  '${userModal.companyName}',
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'الهاتف :',
                                  style: TextStyle(color: Colors.green,fontSize: 16),
                                ),
                                Text(
                                  '${userModal.userDetails.phoneNo}',textDirection: TextDirection.ltr,
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'رقم السجل التجارى:',
                                  style: TextStyle(color: Colors.green,fontSize: 16),
                                ),
                                Text(
                                  '${userModal.commercialNo}',
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'رقم البطاقة الضريبية:',
                                  style: TextStyle(color: Colors.green,fontSize: 16),
                                ),
                                Text(
                                  '${userModal.taxCardNo}',
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'رقم حساب البنكى :',
                                  style: TextStyle(color: Colors.green,fontSize: 16),
                                ),
                                Text(
                                  '${userModal.bankAccount}',
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'عنوان المرسلات :',
                                  style: TextStyle(color: Colors.green,fontSize: 16),
                                ),
                                Text(
                                  '${userModal.storeDetails.address}',
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              )
              : Column(children: [
                  userModal.approved == 0
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 22, right: 22, left: 22, bottom: 22),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/Attention.svg",
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'حسابك كبائع حاليا غير مفعليرجى استكمال وإرسال البيانات التالية لتفعيل حسابك',
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                    padding: const EdgeInsets.only(
                        top: 22, right: 22, left: 22, bottom: 22),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/Attention.svg",
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'حسابك كبائع حاليامفعل',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                  _isLoading
                      ? Container(
                          // height: double.infinity,
                          // width: double.infinity,
                          color: Colors.white,
                          child: Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      themeColor.getColor()))))
                      : Container(
                          color: Colors.white,
                          child: Container(
                            color: Colors.white,
                            child: Container(
                              color: Color(0xffFFFFFF),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 25.0, right: 25.0),
                                child: Column(
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          _vendor_types==null?Container(): Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'نوع التاجر',
                                              ),
                                              ListView.builder(
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemCount: _vendor_types.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return ListTile(enabled: false,
                                                      title: Text(
                                                        '${_vendor_types[index].type}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1
                                                            .copyWith(
                                                            color: Colors.black),
                                                      ),
                                                      leading: Radio(
                                                        value: _vendor_types[index].id,
                                                        groupValue: _value,
                                                        activeColor:
                                                        themeColor.getColor(),
                                                        onChanged:  (int value) {
                                                          setState(() {
                                                            _value = value;
                                                          });
                                                        },
                                                      ),onTap: (){
                                                         setState(() {
                                                            _value =  _vendor_types[index].id;
                                                          });
                                                      },
                                                    );
                                                  }),
                                            ],
                                          ),
                                          MyTextFormField(
                                            intialLabel:
                                                userModal.companyName ?? '',
                                            keyboard_type:
                                                TextInputType.emailAddress,
                                            labelText: "الشركة",
                                            hintText: "الشركة",
                                            isPhone: true,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return "الشركة";
                                              }
                                              _formKey.currentState.save();
                                              return null;
                                            },
                                            onSaved: (String value) {
                                              userModal.companyName = value;
                                            },
                                          ),
                                          // MyTextFormField(
                                          //   intialLabel: "",
                                          //   keyboard_type:
                                          //       TextInputType.emailAddress,
                                          //   labelText: "الهاتف",
                                          //   hintText: "الهاتف",
                                          //   isPhone: true,
                                          //   validator: (String value) {
                                          //     if (value.isEmpty) {
                                          //       return "الهاتف";
                                          //     }
                                          //     _formKey.currentState.save();
                                          //     return null;
                                          //   },
                                          //   onSaved: (String value) {
                                          //     //userModal.phone_no = value;
                                          //   },
                                          // ),
                                          MyTextFormField(
                                            intialLabel: userModal.commercialNo,
                                            keyboard_type:
                                                TextInputType.emailAddress,
                                            labelText: "رقم السجل التجاري",
                                            hintText: "رقم السجل التجاري",
                                            isPhone: true,
                                            validator: (String value) {
                                              // if (value.isEmpty) {
                                              //   return "رقم السجل التجاري";
                                              // }
                                              _formKey.currentState.save();
                                              return null;
                                            },
                                            onSaved: (String value) {
                                              userModal.commercialNo = value;
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  child: Container(
                                                    width: ScreenUtil.getWidth(
                                                            context) /
                                                        1.4,
                                                    padding:
                                                        const EdgeInsets.all(10.0),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.orange)),
                                                    child: Center(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.file_upload,
                                                            color: Colors.orange,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          AutoSizeText(
                                                            "إرفاق ملف أقصى حجم 1MB",
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            maxFontSize: 14,
                                                            maxLines: 1,
                                                            minFontSize: 10,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                color:
                                                                    Colors.orange),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    getCommercialDocs();
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Tooltip(
                                                  key: _toolTipKey,
                                                  message: 'رقم السجل التجاري',
                                                  waitDuration:
                                                      Duration(seconds: 2),
                                                  showDuration:
                                                      Duration(seconds: 2),
                                                  child: GestureDetector(
                                                    child: Container(
                                                      padding: const EdgeInsets.all(
                                                          10.0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.orange)),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.info_outline,
                                                          color: Colors.orange,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      final dynamic tooltip =
                                                          _toolTipKey.currentState;
                                                      tooltip
                                                          .ensureTooltipVisible();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          userModal.commercialDocs == null
                                              ? Container()
                                              : InkWell(
                                                  onTap: () {
                                                    _launchURL(userModal
                                                        .commercialDocs.image);
                                                  },
                                                  child: Container(
                                                      child: Row(
                                                    children: [
                                                      Container(
                                                        width: ScreenUtil.getWidth(
                                                                context) /
                                                            2.5,
                                                        child: Text(
                                                          "${userModal.commercialDoc}",
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          CupertinoIcons
                                                              .clear_circled,
                                                          size: 20,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            userModal
                                                                    .commercialDocs =
                                                                null;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  )),
                                                ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          MyTextFormField(
                                            intialLabel: userModal.taxCardNo,
                                            keyboard_type:
                                                TextInputType.emailAddress,
                                            labelText: "رقم البطاقة الضريبية",
                                            hintText: "رقم البطاقة الضريبية",
                                            isPhone: true,
                                            validator: (String value) {
                                              // if (value.isEmpty) {
                                              //   return "رقم البطاقة الضريبية";
                                              // }
                                              _formKey.currentState.save();
                                              return null;
                                            },
                                            onSaved: (String value) {
                                              userModal.taxCardNo = value;
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  child: Container(
                                                    width: ScreenUtil.getWidth(
                                                            context) /
                                                        1.4,
                                                    padding:
                                                        const EdgeInsets.all(10.0),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.orange)),
                                                    child: Center(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.file_upload,
                                                            color: Colors.orange,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          AutoSizeText(
                                                            "إرفاق ملف أقصى حجم 1MB",
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            maxFontSize: 14,
                                                            maxLines: 1,
                                                            minFontSize: 10,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                color:
                                                                    Colors.orange),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    gettaxCardDocs();
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Tooltip(
                                                  key: _toolTip1,
                                                  message: 'رقم البطاقة الضريبية',
                                                  waitDuration:
                                                      Duration(seconds: 2),
                                                  showDuration:
                                                      Duration(seconds: 2),
                                                  child: GestureDetector(
                                                    child: Container(
                                                      padding: const EdgeInsets.all(
                                                          10.0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.orange)),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.info_outline,
                                                          color: Colors.orange,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      final dynamic tooltip =
                                                          _toolTip1.currentState;
                                                      tooltip
                                                          .ensureTooltipVisible();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          userModal.taxCardDocs == null
                                              ? Container()
                                              : InkWell(
                                                  onTap: () {
                                                    _launchURL(userModal
                                                        .taxCardDocs.image);
                                                  },
                                                  child: Container(
                                                      child: Row(
                                                    children: [
                                                      Container(
                                                        width: ScreenUtil.getWidth(
                                                                context) /
                                                            2.5,
                                                        child: Text(
                                                          "${userModal.taxCardDoc}",
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          CupertinoIcons
                                                              .clear_circled,
                                                          size: 20,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            userModal.taxCardDocs =
                                                                null;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  )),
                                                ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                      _value==2?Container():  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AutoSizeText(
                                                "تصريح تاجر الجملة",
                                                overflow: TextOverflow
                                                    .ellipsis,
                                                maxFontSize: 14,
                                                maxLines: 1,
                                                minFontSize: 10,
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color:
                                                    Colors.black54),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      child: Container(
                                                        width: ScreenUtil.getWidth(
                                                            context) /
                                                            1.4,
                                                        padding:
                                                        const EdgeInsets.all(10.0),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors.orange)),
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.file_upload,
                                                                color: Colors.orange,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              AutoSizeText(
                                                                "إرفاق ملف أقصى حجم 1MB",
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                                maxFontSize: 14,
                                                                maxLines: 1,
                                                                minFontSize: 10,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    color:
                                                                    Colors.orange),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        getWholesaleDocs();
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Tooltip(
                                                      key: _toolTip2,
                                                      message: 'تصريح تاجر الجملة',
                                                      waitDuration:
                                                      Duration(seconds: 2),
                                                      showDuration:
                                                      Duration(seconds: 2),
                                                      child: GestureDetector(
                                                        child: Container(
                                                          padding: const EdgeInsets.all(
                                                              10.0),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                  Colors.orange)),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.info_outline,
                                                              color: Colors.orange,
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          final dynamic tooltip =
                                                              _toolTip2.currentState;
                                                          tooltip.ensureTooltipVisible();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                          userModal.wholesaleDocs == null
                                              ? Container()
                                              : InkWell(
                                                  onTap: () {
                                                    _launchURL(userModal
                                                        .wholesaleDocs.image);
                                                  },
                                                  child: Container(
                                                      child: Row(
                                                    children: [
                                                      Container(
                                                        width: ScreenUtil.getWidth(
                                                                context) /
                                                            2.5,
                                                        child: Text(
                                                          "${userModal.wholesaleDocs}",
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          CupertinoIcons
                                                              .clear_circled,
                                                          size: 20,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            userModal
                                                                    .wholesaleDocs =
                                                                null;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  )),
                                                ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          MyTextFormField(
                                            intialLabel: userModal.bankAccount,
                                            keyboard_type:
                                                TextInputType.emailAddress,
                                            labelText: 'رقم الحساب البنكي',
                                            hintText: "رقم الحساب البنكي",
                                            isPhone: true,
                                            validator: (String value) {
                                              // if (value.isEmpty) {
                                              //   return "رقم الحساب البنكي";
                                              // }
                                              _formKey.currentState.save();
                                              return null;
                                            },
                                            onSaved: (String value) {
                                              userModal.bankAccount = value;
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  child: Container(
                                                    width: ScreenUtil.getWidth(
                                                            context) /
                                                        1.4,
                                                    padding:
                                                        const EdgeInsets.all(10.0),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.orange)),
                                                    child: Center(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.file_upload,
                                                            color: Colors.orange,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          AutoSizeText(
                                                            "إرفاق ملف أقصى حجم 1MB",
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            maxFontSize: 14,
                                                            maxLines: 1,
                                                            minFontSize: 10,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                color:
                                                                    Colors.orange),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    getbankDocs();
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Tooltip(
                                                  key: _toolTip3,
                                                  message: 'رقم الحساب البنكي',
                                                  waitDuration:
                                                      Duration(seconds: 2),
                                                  showDuration:
                                                      Duration(seconds: 2),
                                                  child: GestureDetector(
                                                    child: Container(
                                                      padding: const EdgeInsets.all(
                                                          10.0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.orange)),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.info_outline,
                                                          color: Colors.orange,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      final dynamic tooltip =
                                                          _toolTip3.currentState;
                                                      tooltip
                                                          .ensureTooltipVisible();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          userModal.bankDocs == null
                                              ? Container()
                                              : InkWell(
                                                  onTap: () {
                                                    _launchURL(
                                                        userModal.bankDocs.image);
                                                  },
                                                  child: Container(
                                                      child: Row(
                                                    children: [
                                                      Container(
                                                        width: ScreenUtil.getWidth(
                                                                context) /
                                                            2.5,
                                                        child: Text(
                                                          "${userModal.bankAccount}",
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          CupertinoIcons
                                                              .clear_circled,
                                                          size: 20,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            userModal.bankDocs =  null;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  )),
                                                ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Center(
                                            child: GestureDetector(
                                              child: Container(
                                                width:
                                                    ScreenUtil.getWidth(context) /
                                                        1.4,
                                                padding: const EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.orange)),
                                                child: Center(
                                                  child: AutoSizeText(
                                                    "حفظ ومتابعة في وقت لاحق",
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
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  _formKey.currentState.save();
                                                  API(context).postFile(
                                                      'vendor/upload/docs',
                                                      {
                                                        "user_id": userModal.useridId.toString(),
                                                        "vendor_id": userModal.id.toString(),
                                                        "type": _value.toString(),
                                                        "company_name": userModal.companyName??' ',
                                                        "commercial_no": userModal.commercialNo??' ',
                                                        "tax_card_no": userModal.taxCardNo??' ',
                                                        "bank_account": userModal.bankAccount??' ',
                                                      },
                                                      bankDocs: bankDocs,
                                                      commercialDocs: commercialDocs,
                                                      taxCardDocs: taxCardDocs,
                                                      wholesaleDocs: wholesaleDocs).then((value) {
                                                        print(value);
                                                    if (value != null) {
                                                      if (value['status_code'] ==
                                                          200) {
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
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),

                                        ],
                                      ),
                                    ),     userModal.competeStore==1?Container():
                                    Form(
                                      key: address_key,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            " عنوان المراسلات(الفرع الرئيسي)",
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            getTransrlate(
                                                context, 'Countroy'),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                          contries == null
                                              ? Container()
                                              : Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                vertical: 10),
                                            child:
                                            DropdownSearch<Country>(
                                              // label: getTransrlate(context, 'Countroy'),
                                              validator:
                                                  (Country item) {
                                                if (item == null) {
                                                  return "Required field";
                                                } else
                                                  return null;
                                              },selectedItem:userModal.storeDetails==null?Country(countryName: 'الدولة'):userModal.storeDetails.countryId==null?Country(countryName: 'الدولة'):contries.where((element) => element.id==userModal.storeDetails.countryId).first,
                                              showSearchBox: true,
                                              items: contries,
                                              //  onFind: (String filter) => getData(filter),
                                              itemAsString:
                                                  (Country u) =>
                                              u.countryName,
                                              onChanged:
                                                  (Country data) {
                                                country =
                                                    data.id.toString();
                                                getArea(data.id);
                                              },
                                            ),
                                          ),
                                          area == null
                                              ? Container()
                                              : Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                vertical: 10),
                                            child: DropdownSearch<Area>(
                                              // label: getTransrlate(context, 'Countroy'),
                                              validator: (Area item) {
                                                if (item == null) {
                                                  return "Required field";
                                                } else
                                                  return null;
                                              },

                                              items: area,
                                              //  onFind: (String filter) => getData(filter),
                                              itemAsString: (Area u) =>
                                              u.areaName,
                                              onChanged: (Area data) {
                                                areas =
                                                    data.id.toString();
                                                getCity(data.id);
                                              },
                                            ),
                                          ),
                                          cities == null
                                              ? Container()
                                              : Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                vertical: 10),
                                            child: DropdownSearch<City>(
                                              // label: getTransrlate(context, 'Countroy'),
                                              validator: (City item) {
                                                if (item == null) {
                                                  return "Required field";
                                                } else
                                                  return null;
                                              },

                                              items: cities,
                                              //  onFind: (String filter) => getData(filter),
                                              itemAsString: (City u) =>
                                              u.cityName,
                                              onChanged: (City data) {
                                                city =
                                                    data.id.toString();
                                              },
                                            ),
                                          ),
                                          MyTextFormField(
                                            intialLabel: '',
                                            keyboard_type:
                                            TextInputType.text,
                                            labelText: getTransrlate(
                                                context, 'Addres'),
                                            hintText: getTransrlate(
                                                context, 'Addres'),
                                            isPhone: true,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return getTransrlate(
                                                    context, 'Addres');
                                              }
                                              _formKey.currentState.save();
                                              return null;
                                            },
                                            onSaved: (String value) {
                                              address = value;
                                            },
                                          ),
                                          MyTextFormField(
                                            intialLabel: '',
                                            keyboard_type:
                                            TextInputType.phone,
                                            labelText: getTransrlate(
                                                context, 'phone'),
                                            hintText: getTransrlate(
                                                context, 'phone'),
                                            isPhone: true,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return getTransrlate(
                                                    context, 'phone');
                                              }
                                              _formKey.currentState.save();
                                              return null;
                                            },
                                            onSaved: (String value) {
                                              phone = value;
                                            },
                                          ),
                                          Center(
                                            child: GestureDetector(
                                              child: Container(
                                                width:
                                                ScreenUtil.getWidth(context) /
                                                    1.4,
                                                padding: const EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.orange)),
                                                child: Center(
                                                  child: AutoSizeText(
                                                    "حفظ العنوان",
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
                                                if (address_key.currentState
                                                    .validate()) {
                                                  address_key.currentState.save();
                                                  API(context).post(
                                                      "vendor/add/head/center", {
                                                    "moderator_phone": phone,
                                                    "user_id": userModal.useridId,
                                                    "vendor_id": userModal.id,
                                                    "area_id": areas,
                                                    "country_id": country,
                                                    "city_id": city,
                                                    "address": address,
                                                    //"long": 30,
                                                  }).then((value) {
                                                    if (value != null) {
                                                      if (value['status_code'] ==
                                                          200) {
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
                                                                ResultOverlay(
                                                                    '${value['message'] ?? ''}\n${value['errors']}'));
                                                      }
                                                    }
                                                  });
                                                }
                                              },
                                            ),
                                          ),

                                          SizedBox(
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ))
                ]),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  getbankDocs() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      bankDocs = File(result.files.single.path);
    } else {
      // User canceled the picker
    }
  }

  gettaxCardDocs() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      taxCardDocs = File(result.files.single.path);
    } else {
      // User canceled the picker
    }
  }

  getCommercialDocs() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      commercialDocs = File(result.files.single.path);
    } else {
      // User canceled the picker
    }
  }

  getWholesaleDocs() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      wholesaleDocs = File(result.files.single.path);
    } else {
      // User canceled the picker
    }
  }

  void getCity(int id) {
    API(context).get('cities/list/all/$id').then((value) {
      setState(() {
        cities = City_model.fromJson(value).data;
      });
    });
  }

  void getArea(int id) {
    API(context).get('areas/list/all/$id').then((value) {
      print(value);
      setState(() {
        area = Area_model.fromJson(value).data;
      });
    });
  }

  void getCountry() {
    API(context).get('countries/list/all').then((value) {
      setState(() {
        contries = Country_model.fromJson(value).data;
      });
    });
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
