import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/shipping_address.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();
  Address address=new Address();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset("assets/icons/User Icon.svg",color: Colors.white,height: 25,),
            SizedBox(width: 10,),
            Text(getTransrlate(context, 'MyAddress')),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('إضافة عنوان جديد',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 22),),
                MyTextFormField(
                  intialLabel: ' ',
                  Keyboard_Type: TextInputType.text,
                  labelText: getTransrlate(context, 'Firstname'),
                  hintText: getTransrlate(context, 'Firstname'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'Firstname');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.recipientName=value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.text,
                  labelText: getTransrlate(context, 'Lastname'),
                  hintText: getTransrlate(context, 'Lastname'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'Lastname');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.lastName=value;
                    },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'Countroy'),
                  hintText: getTransrlate(context, 'Countroy'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'Countroy');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.state=value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText:"المنطقة",
                  hintText: "المنطقة",
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "المنطقة";
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.area=value;

                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText: "المدينة",
                  hintText: "المدينة",
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "المدينة";
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.city=value;

                  },
                ),

                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText: 'الحي',
                  hintText: 'الحي',
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'الحي';
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.district=value;

                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText: "اسم/رقم شارع",
                  hintText: "اسم/رقم شارع",
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "اسم/رقم شارع";
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.countryCode=value;

                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText: "رقم المنزل",
                  hintText: "رقم المنزل",
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "رقم المنزل";
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.homeNo=value;

                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText: "رقم الطابق",
                  hintText: "رقم الطابق",
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "رقم الطابق";
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.floorNo=value;

                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText: "رقم الشقه",
                  hintText: "رقم الشقه",
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "رقم الشقه";
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.apartmentNo=value;

                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText: "رقم الجوال",
                  hintText: "رقم الجوال",
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "رقم الجوال";
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.recipientPhone=value;

                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText: "رقم الهاتف الأرضي",
                  hintText: "رقم الهاتف الأرضي",
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "رقم الهاتف الأرضي";
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.telephoneNo=value;

                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText: "أقرب معلم",
                  hintText: "أقرب معلم",
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "أقرب معلم";
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.nearestMilestone=value;

                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText: "ملاحظات",
                  hintText: "ملاحظات",
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "ملاحظات";
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.notices=value;

                  },
                ),
                SizedBox(height: 25 ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: GestureDetector(
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 2.5,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
                          child: Center(
                            child: AutoSizeText(
                              getTransrlate(context, 'save'),
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
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            //setState(() => _isLoading = true);
                            API(context).post('user/add/shipping', address.toJson()).then((value) {
                              if (value != null) {
                                if (value['status_code'] == 201) {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (_) =>
                                          ResultOverlay(value['message']));

                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) =>
                                          ResultOverlay(value['message']));
                                }
                              }
                            });
                          }                      },
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 2.5,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: AutoSizeText(
                              getTransrlate(context, 'close'),
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 14,
                              maxLines: 1,
                              minFontSize: 10,
                              style:
                              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                          ),
                        ),
                        onTap: () {

                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
