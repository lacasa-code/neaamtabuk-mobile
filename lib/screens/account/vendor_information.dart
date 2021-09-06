import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/model/Reason.dart';
import 'package:flutter_pos/model/area_model.dart';
import 'package:flutter_pos/model/city_model.dart';
import 'package:flutter_pos/model/country_model.dart';
import 'package:flutter_pos/model/vendor_info.dart';
import 'package:flutter_pos/model/vendors_types.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
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
  bool _statusDocs = true;
  final FocusNode myFocusNode = FocusNode();
  bool _isLoading = false;
  Vendor userModal;
  Reasons reasons;
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
  Color commercialDocss;
  Color taxCardDocss;
  Color wholesaleDocss;
  Color bankDocss;
  File wholesaleDocs;
  String country, areas, city, address, phone, name;
  TextEditingController code = TextEditingController();

  @override
  void initState() {
    getCountry();

    API(context).get('add-vendors/get/types').then((value) {
      if (value != null) {
        if (value['status_code'] == 200) {
          setState(() {
            _vendor_types = Vendors_types
                .fromJson(value)
                .data;
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
              userModal = Vendor_info
                  .fromJson(value)
                  .data;
              _status = userModal.approved != 1;
              _value = int.parse(userModal.type);
              userModal.storeDetails == null
                  ? null
                  : userModal.storeDetails.countryId == null
                  ? null
                  : getArea(userModal.storeDetails.countryId);
              userModal.storeDetails == null
                  ? null
                  : userModal.storeDetails.areaId == null
                  ? null
                  : getCity(userModal.storeDetails.areaId);
            });
          } else {
            showDialog(
                context: context,
                builder: (_) => ResultOverlay(value['message']));
          }
        }
      });
    });
    API(context).post('vendor/reject/reasons', {}).then((value) {
      if (value != null) {
        if (value['status_code'] == 200) {
          setState(() {
            reasons = Reasons.fromJson(value);
            reasons.data.forEach((element) {
              element.field == 'commercialDocs'
                  ? commercialDocss = Colors.red
                  : Colors.black;
              element.field == 'taxCardDocs' ?
              taxCardDocss = Colors.red : Colors.black;

              element.field == 'wholesaleDocs' ?
              wholesaleDocss = Colors.red :Colors.black;

              element.field == 'bankDocs' ?
              bankDocss = Colors.red : Colors.black;
            });
          });
        } else {
          // showDialog(
          //     context: context,
          //     builder: (_) => ResultOverlay(value['message']));
        }
      }
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
              Text('${getTransrlate(context, 'vendorSettings')}'),
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
              : userModal.approved == 1
              ? Center(
            child: Container(
              width: ScreenUtil.getWidth(context) / 1.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline,
                        color: Colors.green,size: 35,),

                      SizedBox(width: 10),
                      Text(
                        '${getTransrlate(context, 'validvendor')}',
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(color: Colors.green, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: ScreenUtil.getWidth(context) / 1.2,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${getTransrlate(context, 'VendorType')} :',
                              style: TextStyle(
                                  color: Colors.green, fontSize: 16),
                            ),
                            Text(
                              '${userModal.venType}',
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${getTransrlate(context, 'company')} :',
                              style: TextStyle(
                                  color: Colors.green, fontSize: 16),
                            ),
                            Text(
                              '${userModal.companyName}',
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${getTransrlate(context, 'phone')} :',
                              style: TextStyle(
                                  color: Colors.green, fontSize: 16),
                            ),
                            Text(
                              '${userModal.userDetails.phoneNo}',
                              textDirection: TextDirection.ltr,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${getTransrlate(context, 'commercialNo')}:',
                              style: TextStyle(
                                  color: Colors.green, fontSize: 16),
                            ),
                            Text(
                              '${userModal.commercialNo}',
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${getTransrlate(context, 'taxCardNo')} : ',
                              style: TextStyle(
                                  color: Colors.green, fontSize: 16),
                            ),
                            Text(
                              '${userModal.taxCardNo}',
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${getTransrlate(
                                  context, 'Bankaccountnumber')} :',
                              style: TextStyle(
                                  color: Colors.green, fontSize: 16),
                            ),
                            Text(
                              '${userModal.bankAccount}',
                            ),
                          ],
                        ),
                        Container(
                          width: ScreenUtil.getWidth(context) / 1.2,

                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '${getTransrlate(context, 'HeadCenter')} :-',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 16),
                                ),
                              ),
                              Text(
                                '${userModal.storeDetails.address}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${getTransrlate(context, 'install_vendor_app')}',
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  InkWell(
                      onTap: (){
                        _launchURL('https://play.google.com/store/apps/details?id=com.lacasacode.trkar_vendor');
                      },child: Image.asset('assets/images/google play.png')),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '${getTransrlate(context, 'Orinstall_app')}',
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(color: Colors.black, fontSize: 14),
                  ),  InkWell(
                    onTap: (){
                      _launchURL('dashboard.lacasacode.dev');
                    },
                    child: Text(
                      '${getTransrlate(context, 'thisLink')}',
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(color: Colors.orange,decoration: TextDecoration.underline, fontSize: 14),
                    ),
                  ),

                ],
              ),
            ),
          )
              : Column(children: [
            userModal.approved == 0
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/Attention.svg",
                    color: Colors.orange,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: ScreenUtil.getWidth(context) / 1.2,
                    child: Text(
                      '${getTransrlate(context, 'invalidvendor')}',
                      style: TextStyle(color: Colors.orange),
                    ),
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
                    '${getTransrlate(context, 'validvendor')}',
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
              ),
            ),
            reasons == null
                ? Container()
                : reasons.data.isEmpty
                ? Container()
                : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: reasons.data.length,
                    itemBuilder:
                        (BuildContext context, int index) {
                      return Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/Attention.svg",
                            color: Colors.orange,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width:
                            ScreenUtil.getWidth(context) /
                                1.2,
                            child: Text(
                              '${reasons.data[index].field} : ${reasons
                                  .data[index].rejReason}',
                              style: TextStyle(
                                  color: Colors.orange),
                            ),
                          ),
                        ],
                      );
                    })),
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
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0),
                      child: Column(
                        children: [
                          !_statusDocs
                              ? Container()
                              : Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                _vendor_types == null
                                    ? Container()
                                    : Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    Text(
                                      '${getTransrlate(context, 'VendorType')}',
                                    ),
                                    ListView.builder(
                                        primary:
                                        false,
                                        shrinkWrap:
                                        true,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        itemCount:
                                        _vendor_types
                                            .length,
                                        itemBuilder:
                                            (BuildContext
                                        context,
                                            int index) {
                                          return ListTile(
                                            enabled:
                                            false,
                                            title:
                                            Text(
                                              '${_vendor_types[index].type}',
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  .copyWith(
                                                  color: Colors.black),
                                            ),
                                            leading:
                                            Radio(
                                              value: _vendor_types[index]
                                                  .id,
                                              groupValue:
                                              _value,
                                              activeColor:
                                              themeColor.getColor(),
                                              onChanged:
                                                  (int
                                              value) {
                                                setState(
                                                        () {
                                                      _value =
                                                          value;
                                                    });
                                              },
                                            ),
                                            onTap:
                                                () {
                                              setState(
                                                      () {
                                                    _value =
                                                        _vendor_types[index].id;
                                                  });
                                            },
                                          );
                                        }),
                                  ],
                                ),
                                MyTextFormField(
                                  intialLabel: userModal
                                      .companyName ??
                                      '',
                                  keyboard_type:
                                  TextInputType
                                      .emailAddress,
                                  labelText:
                                  "${getTransrlate(context, 'company')}",
                                  hintText:
                                  "${getTransrlate(context, 'company')}",
                                  isPhone: true,
                                  validator:
                                      (String value) {
                                    if (value.isEmpty) {
                                      return "${getTransrlate(
                                          context, 'company')}";
                                    }
                                    _formKey.currentState
                                        .save();
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    userModal.companyName =
                                        value;
                                  },
                                ),
                                MyTextFormField(
                                  intialLabel: userModal
                                      .commercialNo,
                                  keyboard_type:
                                  TextInputType
                                      .emailAddress,
                                  labelText:
                                  "${getTransrlate(context, 'commercialNo')}",
                                  hintText:
                                  "${getTransrlate(context, 'commercialNo')}",
                                  isPhone: true,
                                  validator:
                                      (String value) {
                                    // if (value.isEmpty) {
                                    //   return "رقم السجل التجاري";
                                    // }
                                    _formKey.currentState
                                        .save();
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    userModal.commercialNo =
                                        value;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .start,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          width: ScreenUtil
                                              .getWidth(
                                              context) /
                                              1.4,
                                          padding:
                                          const EdgeInsets
                                              .all(
                                              10.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors
                                                      .orange)),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .file_upload,
                                                  color: Colors
                                                      .orange,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                AutoSizeText(
                                                  "${getTransrlate(
                                                      context, 'Attach')}",
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  maxFontSize:
                                                  14,
                                                  maxLines:
                                                  1,
                                                  minFontSize:
                                                  10,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold,
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
                                        message:
                                        '${getTransrlate(
                                            context, 'commercialNo')}',
                                        waitDuration:
                                        Duration(
                                            seconds: 2),
                                        showDuration:
                                        Duration(
                                            seconds: 2),
                                        child:
                                        GestureDetector(
                                          child: Container(
                                            padding:
                                            const EdgeInsets
                                                .all(
                                                10.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .orange)),
                                            child: Center(
                                              child: Icon(
                                                Icons
                                                    .info_outline,
                                                color: Colors
                                                    .orange,
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            final dynamic
                                            tooltip =
                                                _toolTipKey
                                                    .currentState;
                                            tooltip
                                                .ensureTooltipVisible();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                userModal.commercialDocs ==
                                    null
                                    ? Container()
                                    : InkWell(
                                  onTap: () {
                                    _launchURL(userModal
                                        .commercialDocs
                                        .image);
                                  },
                                  child: Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: ScreenUtil
                                                .getWidth(
                                                context) /
                                                2.5,
                                            child: Text(
                                              "${userModal.commercialDocs
                                                  .name}",
                                              maxLines: 1,
                                              style: TextStyle(color:  commercialDocss??Colors.black),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              CupertinoIcons
                                                  .clear_circled,
                                              size: 20,
                                            ),
                                            onPressed:
                                                () {
                                              setState(
                                                      () {
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
                                  intialLabel:
                                  userModal.taxCardNo,
                                  keyboard_type:
                                  TextInputType
                                      .emailAddress,
                                  labelText:
                                  "${getTransrlate(context, 'taxCardNo')}",
                                  hintText:
                                  "${getTransrlate(context, 'taxCardNo')}",
                                  isPhone: true,
                                  validator:
                                      (String value) {
                                    // if (value.isEmpty) {
                                    //   return "رقم البطاقة الضريبية";
                                    // }
                                    _formKey.currentState
                                        .save();
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    userModal.taxCardNo =
                                        value;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .start,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          width: ScreenUtil
                                              .getWidth(
                                              context) /
                                              1.4,
                                          padding:
                                          const EdgeInsets
                                              .all(
                                              10.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors
                                                      .orange)),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .file_upload,
                                                  color: Colors
                                                      .orange,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                AutoSizeText(
                                                  "${getTransrlate(
                                                      context, 'Attach')}",
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  maxFontSize:
                                                  14,
                                                  maxLines:
                                                  1,
                                                  minFontSize:
                                                  10,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold,
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
                                        message:
                                        "${getTransrlate(
                                            context, 'taxCardNo')}",
                                        waitDuration:
                                        Duration(
                                            seconds: 2),
                                        showDuration:
                                        Duration(
                                            seconds: 2),
                                        child:
                                        GestureDetector(
                                          child: Container(
                                            padding:
                                            const EdgeInsets
                                                .all(
                                                10.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .orange)),
                                            child: Center(
                                              child: Icon(
                                                Icons
                                                    .info_outline,
                                                color: Colors
                                                    .orange,
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            final dynamic
                                            tooltip =
                                                _toolTip1
                                                    .currentState;
                                            tooltip
                                                .ensureTooltipVisible();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                userModal.taxCardDocs ==
                                    null
                                    ? Container()
                                    : InkWell(
                                  onTap: () {
                                    _launchURL(userModal
                                        .taxCardDocs
                                        .image);
                                  },
                                  child: Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: ScreenUtil
                                                .getWidth(
                                                context) /
                                                2.5,
                                            child: Text(
                                              "${userModal.taxCardDocs.name}",
                                              maxLines: 1,
                                              style: TextStyle(color:  taxCardDocss??Colors.black),

                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              CupertinoIcons
                                                  .clear_circled,
                                              size: 20,
                                            ),
                                            onPressed:
                                                () {
                                              setState(
                                                      () {
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
                                _value == 1
                                    ? Container()
                                    : Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    AutoSizeText(
                                      "${getTransrlate(
                                          context, 'WholesalerPermit')}",
                                      overflow:
                                      TextOverflow
                                          .ellipsis,
                                      maxFontSize: 14,
                                      maxLines: 1,
                                      minFontSize: 10,
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          color: Colors
                                              .black54),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .start,
                                        children: [
                                          GestureDetector(
                                            child:
                                            Container(
                                              width: ScreenUtil.getWidth(
                                                  context) /
                                                  1.4,
                                              padding:
                                              const EdgeInsets.all(10.0),
                                              decoration:
                                              BoxDecoration(border: Border.all(
                                                  color: Colors.orange)),
                                              child:
                                              Center(
                                                child:
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.file_upload,
                                                      color: Colors.orange,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    AutoSizeText(
                                                      "${getTransrlate(
                                                          context, 'Attach')}",
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      maxFontSize: 14,
                                                      maxLines: 1,
                                                      minFontSize: 10,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          color: Colors.orange),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onTap:
                                                () {
                                              getWholesaleDocs();
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Tooltip(
                                            key:
                                            _toolTip2,
                                            message:
                                            '${getTransrlate(
                                                context, 'WholesalerPermit')}',
                                            waitDuration:
                                            Duration(
                                                seconds: 2),
                                            showDuration:
                                            Duration(
                                                seconds: 2),
                                            child:
                                            GestureDetector(
                                              child:
                                              Container(
                                                padding:
                                                const EdgeInsets.all(10.0),
                                                decoration:
                                                BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.orange)),
                                                child:
                                                Center(
                                                  child:
                                                  Icon(
                                                    Icons.info_outline,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                              ),
                                              onTap:
                                                  () {
                                                final dynamic
                                                tooltip =
                                                    _toolTip2.currentState;
                                                tooltip
                                                    .ensureTooltipVisible();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                userModal.wholesaleDocs ==
                                    null
                                    ? Container()
                                    : InkWell(
                                  onTap: () {
                                    _launchURL(userModal
                                        .wholesaleDocs
                                        .image);
                                  },
                                  child: Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: ScreenUtil
                                                .getWidth(
                                                context) /
                                                2.5,
                                            child: Text(
                                              "${userModal.wholesaleDocs.name}",
                                              maxLines: 1,
                                              style: TextStyle(color:  wholesaleDocss??Colors.black),

                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              CupertinoIcons
                                                  .clear_circled,
                                              size: 20,
                                            ),
                                            onPressed:
                                                () {
                                              setState(
                                                      () {
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
                                  intialLabel:
                                  userModal.bankAccount,
                                  keyboard_type:
                                  TextInputType
                                      .emailAddress,
                                  labelText:
                                  '${getTransrlate(
                                      context, 'Bankaccountnumber')}',
                                  hintText:
                                  "${getTransrlate(
                                      context, 'Bankaccountnumber')}",
                                  isPhone: true,
                                  validator:
                                      (String value) {
                                    // if (value.isEmpty) {
                                    //   return "${getTransrlate(context, 'Bankaccountnumber')}";
                                    // }
                                    _formKey.currentState
                                        .save();
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    userModal.bankAccount =
                                        value;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .start,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          width: ScreenUtil
                                              .getWidth(
                                              context) /
                                              1.4,
                                          padding:
                                          const EdgeInsets
                                              .all(
                                              10.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors
                                                      .orange)),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .file_upload,
                                                  color: Colors
                                                      .orange,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                AutoSizeText(
                                                  "${getTransrlate(
                                                      context, 'Attach')}",
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  maxFontSize:
                                                  14,
                                                  maxLines:
                                                  1,
                                                  minFontSize:
                                                  10,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold,
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
                                        message:
                                        '${getTransrlate(
                                            context, 'Bankaccountnumber')}',
                                        waitDuration:
                                        Duration(
                                            seconds: 2),
                                        showDuration:
                                        Duration(
                                            seconds: 2),
                                        child:
                                        GestureDetector(
                                          child: Container(
                                            padding:
                                            const EdgeInsets
                                                .all(
                                                10.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .orange)),
                                            child: Center(
                                              child: Icon(
                                                Icons
                                                    .info_outline,
                                                color: Colors
                                                    .orange,
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            final dynamic
                                            tooltip =
                                                _toolTip3
                                                    .currentState;
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
                                        userModal
                                            .bankDocs
                                            .image);
                                  },
                                  child: Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: ScreenUtil
                                                .getWidth(
                                                context) /
                                                2.5,
                                            child: Text(
                                              "${userModal.bankDocs.name}",
                                              maxLines: 1,
                                              style: TextStyle(color:  bankDocss??Colors.black),

                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              CupertinoIcons
                                                  .clear_circled,
                                              size: 20,
                                            ),
                                            onPressed:
                                                () {

                                              setState(
                                                      () {
                                                    userModal
                                                        .bankDocs =
                                                    null;
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
                                      width: ScreenUtil
                                          .getWidth(
                                          context) /
                                          1.4,
                                      padding:
                                      const EdgeInsets
                                          .all(10.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors
                                                  .orange)),
                                      child: Center(
                                        child: AutoSizeText(
                                          "${getTransrlate(
                                              context, 'continueLater')}",
                                          overflow:
                                          TextOverflow
                                              .ellipsis,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          minFontSize: 10,
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                              color: Colors
                                                  .orange),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      if (_formKey
                                          .currentState
                                          .validate()) {
                                        _formKey
                                            .currentState
                                            .save();
                                        API(context)
                                            .postFile(
                                            'vendor/upload/docs',
                                            {
                                              "user_id":
                                              userModal.useridId.toString() ??
                                                  ' ',
                                              "vendor_id":
                                              userModal.id.toString() ??
                                                  ' ',
                                              "type":
                                              _value.toString() ??
                                                  ' ',
                                              "company_name":
                                              userModal.companyName ??
                                                  ' ',
                                              "commercial_no":
                                              userModal.commercialNo ??
                                                  ' ',
                                              "tax_card_no":
                                              userModal.taxCardNo ??
                                                  ' ',
                                              "bank_account":
                                              userModal.bankAccount ??
                                                  ' ',
                                            },
                                            bankDocs:
                                            bankDocs,
                                            commercialDocs:
                                            commercialDocs,
                                            taxCardDocs:
                                            taxCardDocs,
                                            wholesaleDocs:
                                            wholesaleDocs)
                                            .then((value) {
                                          print(value);
                                          if (value !=
                                              null) {
                                            if (value[
                                            'status_code'] ==
                                                200) {
                                              //   Navigator.pop(context);
                                              setState(() {
                                                userModal.competeStore == 1
                                                    ? Navigator.pop(context)
                                                    : _statusDocs =
                                                !_statusDocs;
                                              });
                                              showDialog(
                                                  context:
                                                  context,
                                                  builder: (_) =>
                                                      ResultOverlay(
                                                          value['message']));
                                            } else {
                                              showDialog(
                                                  context:
                                                  context,
                                                  builder: (_) =>
                                                      ResultOverlay(
                                                          "${value['errors'] ??
                                                              value['message']}"));
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
                          _statusDocs
                              ? Container()
                              : userModal.competeStore == 1
                              ? Container()
                              : Form(
                            key: address_key,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${getTransrlate(context, 'HeadCenter')}",
                                ),
                                MyTextFormField(
                                  intialLabel: '',
                                  keyboard_type:
                                  TextInputType
                                      .text,
                                  labelText:
                                  getTransrlate(
                                      context,
                                      'name'),
                                  hintText:
                                  getTransrlate(
                                      context,
                                      'name'),
                                  isPhone: true,
                                  validator:
                                      (String value) {
                                    if (value.isEmpty) {
                                      return getTransrlate(
                                          context,
                                          'name');
                                    }
                                    address_key
                                        .currentState
                                        .save();
                                    return null;
                                  },
                                  onSaved:
                                      (String value) {
                                    name = value;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  getTransrlate(context,
                                      'Countroy'),
                                  style: TextStyle(
                                      color:
                                      Colors.black,
                                      fontSize: 16),
                                ),
                                contries == null
                                    ? Container()
                                    : Padding(
                                  padding: const EdgeInsets
                                      .symmetric(
                                      vertical:
                                      10),
                                  child:
                                  DropdownSearch<
                                      Country>(
                                    // label: getTransrlate(context, 'Countroy'),
                                    validator:
                                        (Country
                                    item) {
                                      if (item ==
                                          null) {
                                        return "Required field";
                                      } else
                                        return null;
                                    },
                                    // selectedItem:userModal.storeDetails==null?Country(countryName: 'الدولة'):userModal.storeDetails.countryId==null?Country(countryName: 'الدولة'):contries.where((element) => element.id==userModal.storeDetails.countryId).first,
                                    showSearchBox:
                                    true,
                                    items:
                                    contries,
                                    //  onFind: (String filter) => getData(filter),
                                    itemAsString:
                                        (Country
                                    u) =>
                                    u.countryName,
                                    onChanged:
                                        (Country
                                    data) {
                                      country = data
                                          .id
                                          .toString();
                                      setState(
                                              () {
                                            area =
                                            null;
                                            cities =
                                            null;
                                          });
                                      code.text = data
                                          .phonecode
                                          .toString();
                                      getArea(data
                                          .id);
                                    },
                                  ),
                                ),
                                area == null
                                    ? Container()
                                    : Padding(
                                  padding: const EdgeInsets
                                      .symmetric(
                                      vertical:
                                      10),
                                  child:
                                  DropdownSearch<
                                      Area>(
                                    // label: getTransrlate(context, 'Countroy'),
                                    validator:
                                        (Area
                                    item) {
                                      if (item ==
                                          null) {
                                        return "Required field";
                                      } else
                                        return null;
                                    },

                                    items: area,
                                    //  onFind: (String filter) => getData(filter),
                                    itemAsString:
                                        (Area u) =>
                                    u.areaName,
                                    onChanged:
                                        (Area
                                    data) {
                                      areas = data
                                          .id
                                          .toString();
                                      setState(
                                              () {
                                            cities =
                                            null;
                                          });
                                      getCity(data
                                          .id);
                                    },
                                  ),
                                ),
                                cities == null
                                    ? Container()
                                    : Padding(
                                  padding: const EdgeInsets
                                      .symmetric(
                                      vertical:
                                      10),
                                  child:
                                  DropdownSearch<
                                      City>(
                                    // label: getTransrlate(context, 'Countroy'),
                                    validator:
                                        (City
                                    item) {
                                      if (item ==
                                          null) {
                                        return "Required field";
                                      } else
                                        return null;
                                    },

                                    items: cities,
                                    //  onFind: (String filter) => getData(filter),
                                    itemAsString:
                                        (City u) =>
                                    u.cityName,
                                    onChanged:
                                        (City
                                    data) {
                                      city = data
                                          .id
                                          .toString();
                                    },
                                  ),
                                ),
                                MyTextFormField(
                                  intialLabel: '',
                                  keyboard_type:
                                  TextInputType
                                      .text,
                                  labelText:
                                  getTransrlate(
                                      context,
                                      'Addres'),
                                  hintText:
                                  getTransrlate(
                                      context,
                                      'Addres'),
                                  isPhone: true,
                                  validator:
                                      (String value) {
                                    if (value.isEmpty) {
                                      return getTransrlate(
                                          context,
                                          'Addres');
                                    }
                                    address_key
                                        .currentState
                                        .save();
                                    return null;
                                  },
                                  onSaved:
                                      (String value) {
                                    address = value;
                                  },
                                ),
                                Text(
                                  getTransrlate(context,
                                      'phone'),
                                  style: TextStyle(
                                      color:
                                      Colors.black,
                                      fontSize: 16),
                                ),
                                Container(
                                  height: 100,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        right: 1,
                                        child:
                                        Container(
                                          width: ScreenUtil
                                              .getWidth(
                                              context) /
                                              1.5,
                                          child:
                                          TextFormField(
                                            textAlign: TextAlign.left,
                                            inputFormatters: [
                                              new LengthLimitingTextInputFormatter(
                                                  10),
                                            ],
                                            initialValue:
                                            phone,
                                            keyboardType:
                                            TextInputType
                                                .number,
                                            decoration:
                                            InputDecoration(),
                                            validator:
                                                (String
                                            value) {
                                              if (value
                                                  .isEmpty) {
                                                return getTransrlate(
                                                    context,
                                                    'phone');
                                              } else if (value
                                                  .length >
                                                  15) {
                                                return "${getTransrlate(
                                                    context, 'phone')} > 14";
                                              } else if (value
                                                  .length <
                                                  9) {
                                                return "${getTransrlate(
                                                    context, 'phone')} < 9";
                                              }
                                              address_key
                                                  .currentState
                                                  .save();
                                              return null;
                                            },
                                            onSaved: (String
                                            val) =>
                                            phone =
                                            "+${code.text}$val",
                                            onChanged: (String
                                            val) =>
                                            phone =
                                                val,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 1,
                                        child:
                                        Container(
                                          width: ScreenUtil
                                              .getWidth(
                                              context) *
                                              0.2,
                                          child:
                                          TextFormField(
                                            textAlign: TextAlign.right,
                                            controller:
                                            code,
                                            inputFormatters: [
                                              new LengthLimitingTextInputFormatter(
                                                  8),
                                            ],
                                            keyboardType:
                                            TextInputType
                                                .number,
                                            decoration:
                                            InputDecoration(),
                                            validator:
                                                (String
                                            value) {
                                              if (value
                                                  .isEmpty) {
                                                return getTransrlate(
                                                    context,
                                                    'CountroyCode');
                                              }
                                              address_key
                                                  .currentState
                                                  .save();
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child:
                                  GestureDetector(
                                    child: Container(
                                      width: ScreenUtil
                                          .getWidth(
                                          context) /
                                          1.4,
                                      padding:
                                      const EdgeInsets
                                          .all(
                                          10.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors
                                                  .orange)),
                                      child: Center(
                                        child:
                                        AutoSizeText(
                                          "${getTransrlate(
                                              context, 'SaveAddress')}",
                                          overflow:
                                          TextOverflow
                                              .ellipsis,
                                          maxFontSize:
                                          14,
                                          maxLines: 1,
                                          minFontSize:
                                          10,
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                              color: Colors
                                                  .orange),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      print(phone);
                                      if (address_key
                                          .currentState
                                          .validate()) {
                                        address_key
                                            .currentState
                                            .save();
                                        API(context).post(
                                            "vendor/add/head/center",
                                            {
                                              "name":
                                              '$name',
                                              "moderator_phone":
                                              phone,
                                              "user_id":
                                              userModal
                                                  .useridId,
                                              "vendor_id":
                                              userModal
                                                  .id,
                                              "area_id":
                                              areas,
                                              "country_id":
                                              country,
                                              "city_id":
                                              city,
                                              "address":
                                              address,
                                              //"long": 30,
                                            }).then(
                                                (value) {
                                              print(value);
                                              if (value !=
                                                  null) {
                                                if (value[
                                                'status_code'] ==
                                                    201) {
                                                  Navigator.pop(
                                                      context);
                                                  showDialog(
                                                      context:
                                                      context,
                                                      builder: (_) =>
                                                          ResultOverlay(
                                                              value['message']));
                                                } else {
                                                  showDialog(
                                                      context:
                                                      context,
                                                      builder: (_) =>
                                                          ResultOverlay(
                                                              '${value['message'] ??
                                                                  ''}\n${value['errors']}'));
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
      setState(() {
        userModal.bankDocs = Images(image: bankDocs.path, name: bankDocs.path);
      });
    } else {
      // User canceled the picker
    }
  }

  gettaxCardDocs() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      taxCardDocs = File(result.files.single.path);
      setState(() {
        userModal.taxCardDocs =
            Images(image: taxCardDocs.path, name: taxCardDocs.path);
      });
    } else {
      // User canceled the picker
    }
  }

  getCommercialDocs() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      commercialDocs = File(result.files.single.path);
      setState(() {
        userModal.commercialDocs =
            Images(image: commercialDocs.path, name: commercialDocs.path);
      });
    } else {
      // User canceled the picker
    }
  }

  getWholesaleDocs() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      wholesaleDocs = File(result.files.single.path);
      setState(() {
        userModal.wholesaleDocs =
            Images(image: wholesaleDocs.path, name: wholesaleDocs.path);
      });
    } else {
      // User canceled the picker
    }
  }

  void getCity(int id) {
    API(context).get('cities/list/all/$id').then((value) {
      setState(() {
        cities = City_model
            .fromJson(value)
            .data;
      });
    });
  }

  void getArea(int id) {
    API(context).get('areas/list/all/$id').then((value) {
      print(value);
      setState(() {
        area = Area_model
            .fromJson(value)
            .data;
      });
    });
  }

  void getCountry() {
    API(context).get('countries/list/all').then((value) {
      setState(() {
        contries = Country_model
            .fromJson(value)
            .data;
      });
    });
  }

  void _launchURL(String _url) async =>
      await canLaunch(_url)
          ? await launch(_url)
          : throw 'Could not launch $_url';
}
