import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/years.dart';
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
                Text(getTransrlate(context,'AddNewAddress'),style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 22),),
              SizedBox(height: 10,),
                MyTextFormField(
                  intialLabel: ' ',
                  Keyboard_Type: TextInputType.name,
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
              SizedBox(height: 5,),
                Text(getTransrlate(context, 'Countroy'),style: TextStyle(color: Colors.black,fontSize: 16),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: DropdownSearch<String>(
                   // label: getTransrlate(context, 'Countroy'),
                    validator: (String item) {
                      if (item == null) {
                        return "Required field";
                      } else
                        return null;
                    },

                    items: ["الإمارات العربية المتحدة","مصر ",'السعودية','الكويت'],
                    //  onFind: (String filter) => getData(filter),
                    itemAsString: (String u) => u,
                    onChanged: (String data) =>
                    address.countryCode = data,
                  ),
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText:getTransrlate(context, 'area'),
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
                    address.area=value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'City'),
                  hintText:  getTransrlate(context, 'City'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return  getTransrlate(context, 'City');
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
                  labelText: getTransrlate(context, 'district'),
                  hintText:  getTransrlate(context, 'district'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return  getTransrlate(context, 'district');
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
                  labelText:  getTransrlate(context, 'street'),
                  hintText: getTransrlate(context, 'street'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'street');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.street=value;

                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  Keyboard_Type: TextInputType.number,
                  labelText: getTransrlate(context, 'HomeNo'),
                  hintText: getTransrlate(context, 'HomeNo'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'HomeNo');
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
                  Keyboard_Type: TextInputType.number,
                  labelText:getTransrlate(context, 'FloorNo'),
                  hintText: getTransrlate(context, 'FloorNo'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'FloorNo');
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
                  Keyboard_Type: TextInputType.number,
                  labelText: getTransrlate(context, 'apartment_no'),
                  hintText: getTransrlate(context, 'apartment_no'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'apartment_no');
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
                  Keyboard_Type: TextInputType.phone,
                  labelText: getTransrlate(context,'phone'),
                  hintText: getTransrlate(context,'phone'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context,'phone');
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
                  Keyboard_Type: TextInputType.phone,
                  labelText: getTransrlate(context, 'telphone'),
                  hintText:  getTransrlate(context, 'telphone'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return  getTransrlate(context, 'telphone');
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
                  labelText: getTransrlate(context, 'nearest_milestone'),
                  hintText: getTransrlate(context, 'nearest_milestone'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'nearest_milestone');
                    }else if (value.length>250) {
                      return "Over length";
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
                  labelText: getTransrlate(context, 'OrderNote'),
                  hintText: getTransrlate(context, 'OrderNote'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'OrderNote');
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
                            API(context).post('user/add/shipping',
                                address.toJson()).then((value) {
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
                                          ResultOverlay('${value['message']??''}\n${value['errors']}'));
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
                          Navigator.pop(context);
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
