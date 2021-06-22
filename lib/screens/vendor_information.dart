import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/model/user_info.dart';
import 'package:flutter_pos/model/vendor_info.dart';
import 'package:flutter_pos/screens/changePasswordPAge.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
  List typies = ['جملة', 'تجزئة', 'جملة وتجزئة'];
  String password;
  final _formKey = GlobalKey<FormState>();
  List<String> items = ["male", "female"];
  GlobalKey _toolTipKey = GlobalKey();
  GlobalKey _toolTip1 = GlobalKey();
  GlobalKey _toolTip2 = GlobalKey();
  GlobalKey _toolTip3 = GlobalKey();

  submitForm() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    _isLoading = true;
    try {
      setState(() => _isLoading = false);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    API(context).get('vendor/saved/docs').then((value) {
      if (value != null) {
        if (value['status_code'] == 200) {
          setState(() {
            userModal = Vendor_info.fromJson(value).data;
          });
        } else {
          showDialog(
              context: context,
              builder: (_) => ResultOverlay(value['message']));
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
              Text('حساب البائع'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
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
                : userModal == null
                    ? Container()
                    : Container(
                        color: Colors.white,
                        child: Container(
                          color: Colors.white,
                          child: Container(
                            color: Color(0xffFFFFFF),
                            child: Padding(
                              padding: EdgeInsets.only(left: 25.0, right: 25.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'نوع التاجر',
                                    ),
                                    Column(
                                      children: <Widget>[
                                        for (int i = 0; i < typies.length; i++)
                                          ListTile(
                                            title: Text(
                                              '${typies[i]}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  .copyWith(
                                                      color: i == 5
                                                          ? Colors.black38
                                                          : Colors.black),
                                            ),
                                            leading: Radio(
                                              value: i,
                                              groupValue: _value,
                                              activeColor:
                                                  themeColor.getColor(),
                                              onChanged: i == typies.length
                                                  ? null
                                                  : (int value) {
                                                      setState(() {
                                                        _value = value;
                                                      });
                                                    },
                                            ),
                                          ),
                                      ],
                                    ),
                                    MyTextFormField(
                                      intialLabel: userModal.companyName??'',
                                      keyboard_type: TextInputType.emailAddress,
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
                                        userModal.companyName=value;
                                      },
                                    ),
                                    MyTextFormField(
                                      intialLabel:  userModal.phone_no,
                                      keyboard_type: TextInputType.emailAddress,
                                      labelText: "الهاتف",
                                      hintText: "الهاتف",
                                      isPhone: true,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "الهاتف";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      onSaved: (String value) {
                                        userModal.phone_no=value;
                                      },
                                    ),
                                    MyTextFormField(
                                      intialLabel: userModal.commercialNo,
                                      keyboard_type: TextInputType.emailAddress,
                                      labelText: "رقم السجل التجاري",
                                      hintText: "رقم السجل التجاري",
                                      isPhone: true,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "رقم السجل التجاري";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      onSaved: (String value) {
                                        userModal.commercialNo=value;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              width:
                                                  ScreenUtil.getWidth(context) /
                                                      1.4,
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.orange)),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.file_upload,color: Colors.orange,),
                                                    SizedBox(width: 10,),
                                                    AutoSizeText(
                                                     "إرفاق ملف أقصى حجم 1MB",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxFontSize: 14,
                                                      maxLines: 1,
                                                      minFontSize: 10,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.orange),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              final dynamic tooltip =
                                                  _toolTipKey.currentState;
                                              tooltip.ensureTooltipVisible();
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Tooltip(
                                            key: _toolTipKey,
                                            message: 'My Account',
                                            waitDuration: Duration(seconds: 2),
                                            showDuration:Duration(seconds: 2) ,
                                            child: GestureDetector(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.orange)),
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
                                                tooltip.ensureTooltipVisible();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MyTextFormField(
                                      intialLabel: userModal.taxCardNo,
                                      keyboard_type: TextInputType.emailAddress,
                                      labelText: "رقم البطاقة الضريبية",
                                      hintText: "رقم البطاقة الضريبية",
                                      isPhone: true,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "رقم البطاقة الضريبية";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      onSaved: (String value) {
                                        userModal.commercialNo=value;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              width:
                                              ScreenUtil.getWidth(context) /
                                                  1.4,
                                              padding:
                                              const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.orange)),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.file_upload,color: Colors.orange,),
                                                    SizedBox(width: 10,),
                                                    AutoSizeText(
                                                      "إرفاق ملف أقصى حجم 1MB",
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      maxFontSize: 14,
                                                      maxLines: 1,
                                                      minFontSize: 10,
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors.orange),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              final dynamic tooltip =
                                                  _toolTipKey.currentState;
                                              tooltip.ensureTooltipVisible();
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Tooltip(
                                            key: _toolTip1,
                                            message: 'My Account',
                                            waitDuration: Duration(seconds: 2),
                                            showDuration:Duration(seconds: 2) ,
                                            child: GestureDetector(
                                              child: Container(
                                                padding:
                                                const EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.orange)),
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
                                                tooltip.ensureTooltipVisible();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MyTextFormField(
                                      intialLabel: userModal.commercialDoc,
                                      keyboard_type: TextInputType.emailAddress,
                                      labelText: 'تصريح تاجر الجملة',
                                      hintText: "تصريح تاجر الجملة",
                                      isPhone: true,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "تصريح تاجر الجملة";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      onSaved: (String value) {
                                        userModal.commercialDoc=value;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              width:
                                              ScreenUtil.getWidth(context) /
                                                  1.4,
                                              padding:
                                              const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.orange)),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.file_upload,color: Colors.orange,),
                                                    SizedBox(width: 10,),
                                                    AutoSizeText(
                                                      "إرفاق ملف أقصى حجم 1MB",
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      maxFontSize: 14,
                                                      maxLines: 1,
                                                      minFontSize: 10,
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors.orange),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              final dynamic tooltip =
                                                  _toolTipKey.currentState;
                                              tooltip.ensureTooltipVisible();
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Tooltip(
                                            key: _toolTip2,
                                            message: 'My Account',
                                            waitDuration: Duration(seconds: 2),
                                            showDuration:Duration(seconds: 2) ,
                                            child: GestureDetector(
                                              child: Container(
                                                padding:
                                                const EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.orange)),
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
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MyTextFormField(
                                      intialLabel: userModal.bankAccount,
                                      keyboard_type: TextInputType.emailAddress,
                                      labelText: 'رقم الحساب البنكي',
                                      hintText: "رقم الحساب البنكي",
                                      isPhone: true,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "رقم الحساب البنكي";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      onSaved: (String value) {
                                        userModal.bankAccount=value;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              width:
                                              ScreenUtil.getWidth(context) /
                                                  1.4,
                                              padding:
                                              const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.orange)),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.file_upload,color: Colors.orange,),
                                                    SizedBox(width: 10,),
                                                    AutoSizeText(
                                                      "إرفاق ملف أقصى حجم 1MB",
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      maxFontSize: 14,
                                                      maxLines: 1,
                                                      minFontSize: 10,
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors.orange),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              final dynamic tooltip =
                                                  _toolTipKey.currentState;
                                              tooltip.ensureTooltipVisible();
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Tooltip(
                                            key: _toolTip3,
                                            message: 'My Account',
                                            waitDuration: Duration(seconds: 2),
                                            showDuration:Duration(seconds: 2) ,
                                            child: GestureDetector(
                                              child: Container(
                                                padding:
                                                const EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.orange)),
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
                                                tooltip.ensureTooltipVisible();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      " عنوان المراسلات(الفرع الرئيسي)",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MyTextFormField(
                                      intialLabel: '',
                                      keyboard_type: TextInputType.emailAddress,
                                      labelText:
                                          getTransrlate(context, 'Countroy'),
                                      hintText:
                                          getTransrlate(context, 'Countroy'),
                                      isPhone: true,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return getTransrlate(
                                              context, 'Countroy');
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      onSaved: (String value) {
                                        //address.city=value;
                                      },
                                    ),
                                    MyTextFormField(
                                      intialLabel: '',
                                      keyboard_type: TextInputType.emailAddress,
                                      labelText: getTransrlate(context, 'area'),
                                      hintText: getTransrlate(context, 'area'),
                                      isPhone: true,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return getTransrlate(context, 'area');
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      onSaved: (String value) {
                                        //address.city=value;
                                      },
                                    ),
                                    MyTextFormField(
                                      intialLabel: '',
                                      keyboard_type: TextInputType.emailAddress,
                                      labelText: getTransrlate(
                                          context, 'addressVendor'),
                                      hintText: getTransrlate(
                                          context, 'addressVendor'),
                                      isPhone: true,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return getTransrlate(
                                              context, 'addressVendor');
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      onSaved: (String value) {
                                        //address.city=value;
                                      },
                                    ),
                                    MyTextFormField(
                                      intialLabel: '',
                                      keyboard_type: TextInputType.emailAddress,
                                      labelText: getTransrlate(context, 'City'),
                                      hintText: getTransrlate(context, 'City'),
                                      isPhone: true,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return getTransrlate(context, 'City');
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      onSaved: (String value) {
                                        //address.city=value;
                                      },
                                    ),
                                    Text(
                                      "الموقع",
                                    ),
                                  ],
                                ),
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

  Widget _getChangePassword() {
    return Center(
      child: GestureDetector(
        child: Container(
          width: ScreenUtil.getWidth(context) / 2.5,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
          child: Center(
            child: AutoSizeText(
              getTransrlate(context, 'changePassword'),
              overflow: TextOverflow.ellipsis,
              maxFontSize: 14,
              maxLines: 1,
              minFontSize: 10,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
            ),
          ),
        ),
        onTap: () {
          Nav.route(context, changePassword());
        },
      ),
    );
  }
}
