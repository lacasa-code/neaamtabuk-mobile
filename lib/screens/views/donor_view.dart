import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/model/Categories_model.dart';
import 'package:flutter_pos/screens/widgets/page_header_widget.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/home_provider.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/MapOverlay.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/dropdown_widget.dart';
import 'package:flutter_pos/widget/register/register_form_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VolunteerView extends StatefulWidget {
  const VolunteerView({Key key}) : super(key: key);

  @override
  State<VolunteerView> createState() => _VolunteerViewState();
}

class _VolunteerViewState extends State<VolunteerView>
    with SingleTickerProviderStateMixin {
  String email, facebookId;
  ProviderControl themeColor;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  int readyToPack = 1;
  int location = 0;
  int readyToDistribute = 1;
  String desc = ' ';
  String delivaryDate = DateTime.now().toString();
  String noOfMeals = ' ';
  Categories_item categoriesItem;
  List<Categories_item> catedories = [];
  Model model = Model();
  String time, distributeLabel, packLabel;
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController =
      TextEditingController(text: DateTime.now().toString());

  @override
  void initState() {
    SharedPreferences.getInstance().then((pref) => {
          setState(() {
            model.longitude = pref.getString('lang') ?? '30';
            model.latitude = pref.getString('lat') ?? '20';
            model.address = pref.getString('address');
          }),
          addressController.text = pref.getString('address') ?? ''
        });

    API(context).get('categories').then((value) {
      if (value != null) {
        print(value);
        if (value['status'] == true) {
          setState(() {
            catedories = Categories_model.fromJson(value).data;
            catedories.isNotEmpty ? categoriesItem = catedories[0] : null;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeColor = Provider.of<ProviderControl>(context);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            DropDownWidget(
              dropDownMode: Mode.MENU,
              hint: 'category',
              items: catedories.map((e) => e.name).toList(),
              onChanged: (v) {
                if (v == null) {
                  return;
                }
                setState(() {
                  categoriesItem =
                      catedories.firstWhere((element) => element.name == v);
                });
              },
              prefixIcon: ImageIcon(
                AssetImage('assets/icons/category.png'),
              ),
            ),
            DropDownWidget(
              dropDownMode: Mode.MENU,
              hint: 'LocationUsage',
              items: [
                getTransrlate(context, 'myLocation'),
                getTransrlate(context, 'otherLocation'),
              ],
              onChanged: (v) {
                log('message $v');
                if (v == null) {
                  return;
                }
                setState(() {
                  if (v == getTransrlate(context, 'myLocation')) {
                    location = 0;
                  } else {
                    location = 1;
                  }
                });
              },
              prefixIcon: ImageIcon(
                AssetImage('assets/icons/location.png'),
              ),
            ),
            location == 0
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: MyTextFormField(
                      hintText: 'AddressTitle',
                      istitle: true,
                      controller: addressController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return getTransrlate(context, 'requiredempty');
                        }
                        if (model.latitude == null && model.longitude == null) {
                          return getTransrlate(context, 'LocationSelected');
                        }
                        _formKey.currentState.save();
                        return null;
                      },
                      suffixIcon: IconButton(
                          icon: Icon(Icons.location_pin),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => MapOverlay(
                                this.model,
                              ),
                            ).whenComplete(() {
                              model.latitude = this.model.latitude;
                              model.longitude = this.model.longitude;
                              addressController.text =
                                  '${this.model.address ?? ''}';
                            });
                          }),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(254),
                      ],
                      onSaved: (String val) => model.address = val,
                      onChange: (String val) {
                        model.address = val;
                      },
                    ),
                  ),
            InkWell(
              onTap: () async {
                var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    Duration(
                      days: 365,
                    ),
                  ),
                );
                if (date == null) {
                  return;
                }
                setState(() {
                  dateController.text = date.toString();
                });
              },
              child: DropDownWidget(
                enabled: false,
                value: dateController.text.isEmpty
                    ? null
                    : dateController.text.substring(0, 10),
                dropDownMode: Mode.MENU,
                hint: 'Data',
                onChanged: (v) {},
                prefixIcon: ImageIcon(
                  AssetImage('assets/icons/calendar.png'),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                var timePicker = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (timePicker == null) {
                  return;
                }
                setState(() {
                  time = timePicker.format(context);
                });
              },
              child: DropDownWidget(
                value: time,
                enabled: false,
                dropDownMode: Mode.MENU,
                hint: 'Time',
                items: [
                  'yes',
                  'no',
                ],
                onChanged: (v) {},
                prefixIcon: ImageIcon(
                  AssetImage('assets/icons/calendar.png'),
                ),
              ),
            ),
            categoriesItem?.id != 1
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: MyTextFormField(
                          hintText: 'desc',
                          istitle: true,
                          prefix: ImageIcon(
                            AssetImage('assets/icons/edit.png'),
                          ),
                          labelText: getTransrlate(context, 'desc'),
                          // hintText: getTransrlate(context, 'desc'),
                          // isEmail: true,
                          enabled: true,
                          // validator: (String value) {
                          //   if (value.isEmpty) {
                          //     return getTransrlate(
                          //         context, 'requiredempty');
                          //   }
                          //   _formKey.currentState.save();
                          //   return null;
                          // },
                          keyboard_type: TextInputType.multiline,
                          onSaved: (String value) {
                            desc = value;
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: MyTextFormField(
                          hintText: 'NoOfmeals', istitle: true,
                          prefix: ImageIcon(
                            AssetImage('assets/icons/meal.png'),
                          ),
                          // hintText:
                          // getTransrlate(context, 'NoOfmeals'),
                          enabled: true,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return getTransrlate(context, 'requiredempty');
                            }
                            _formKey.currentState.save();
                            return null;
                          },
                          keyboard_type: TextInputType.number,
                          onSaved: (String value) {
                            noOfMeals = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ImageIcon(
                              AssetImage('assets/icons/meal.png'),
                              color: themeColor.getColor(),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              getTransrlate(context, 'ready_to_distribute'),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: themeColor.getColor(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: readyToDistribute,
                                  onChanged: (v) {
                                    setState(() {
                                      readyToDistribute = v;
                                    });
                                  },
                                ),
                                Text(
                                  getTransrlate(context, 'yes'),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 0,
                                  groupValue: readyToDistribute,
                                  onChanged: (v) {
                                    setState(() {
                                      readyToDistribute = v;
                                    });
                                  },
                                ),
                                Text(
                                  getTransrlate(context, 'no'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ImageIcon(
                              AssetImage('assets/icons/meal.png'),
                              color: themeColor.getColor(),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              getTransrlate(context, 'ready_to_pack'),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: themeColor.getColor(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: readyToPack,
                                  onChanged: (v) {
                                    setState(() {
                                      readyToPack = v;
                                    });
                                  },
                                ),
                                Text(
                                  getTransrlate(context, 'yes'),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 0,
                                  groupValue: readyToPack,
                                  onChanged: (v) {
                                    setState(() {
                                      readyToPack = v;
                                    });
                                  },
                                ),
                                Text(
                                  getTransrlate(context, 'no'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            // DropDownWidget(
            //   dropDownMode: Mode.MENU,
            //   hint: 'ready_to_distribute',
            //   items: [
            //     getTransrlate(context, 'yes'),
            //     getTransrlate(context, 'no'),
            //   ],
            //   onChanged: (v) {
            //     if (v == null) {
            //       return;
            //     }
            //     setState(() {
            //       if (v == getTransrlate(context, 'yes')) {
            //         readyToDistribute = 1;
            //       } else {
            //         readyToDistribute = 0;
            //       }
            //       distributeLabel = v;
            //     });
            //   },
            //   prefixIcon: ImageIcon(
            //     AssetImage('assets/icons/meal.png'),
            //   ),
            // ),
            // DropDownWidget(
            //   dropDownMode: Mode.MENU,
            //   hint: 'ready_to_pack',
            //   items: [
            //     getTransrlate(context, 'yes'),
            //     getTransrlate(context, 'no'),
            //   ],
            //   onChanged: (v) {
            //     if (v == null) {
            //       return;
            //     }
            //     setState(() {
            //       if (v == getTransrlate(context, 'yes')) {
            //         readyToPack = 1;
            //       } else {
            //         readyToPack = 0;
            //       }
            //       packLabel = v;
            //     });
            //   },
            //   prefixIcon: ImageIcon(
            //     AssetImage('assets/icons/meal.png'),
            //   ),
            // ),
            Container(
              height: 40,
              width: ScreenUtil.getWidth(context),
              margin: EdgeInsets.only(top: 12, bottom: 10, right: 32, left: 32),
              // padding: EdgeInsets.only(right: 16, left: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
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
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(1.0),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    setState(() => _isLoading = true);
                    orderNow(themeColor);
                  }
                },
                child: Text(
                  getTransrlate(context, 'placeorder'),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  orderNow(ProviderControl themeColor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    API(context).post('donate', {
      'category_id': categoriesItem.id,
      'ready_to_distribute': readyToDistribute,
      'ready_to_pack': readyToPack,
      'description': desc,
      'delivary_date': dateController.text,
      'meals_num': noOfMeals,
      'latitude': model.latitude,
      'longitude': model.longitude,
      'address': model.address,
      'status_id': 1,
    }).then((value) {
      print(value);
      if (value['status'] == true) {
        Provider.of<HomeProvider>(context, listen: false).changeTabIndex(0);

        showDialog(
            context: context,
            builder: (_) => ResultOverlay('${value['message']}'));
      } else {
        showDialog(
            context: context,
            builder: (_) => ResultOverlay('${value['message']}'));
      }
    });
  }
}
