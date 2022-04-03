import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/model/Categories_model.dart';
import 'package:flutter_pos/model/donorOrdersModel.dart';
import 'package:flutter_pos/screens/DonorOrders.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/MapOverlay.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/register/register_form_model.dart';
import 'package:flutter_pos/widget/register/register_form_vendor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/category_model.dart';

class EditVolunteerPage extends StatefulWidget {
  DonorOrder donorOrder;

  EditVolunteerPage(this.donorOrder);

  @override
  _EditVolunteerPageState createState() => _EditVolunteerPageState();
}

class _EditVolunteerPageState extends State<EditVolunteerPage> {
  String email, facebook_id;
  ProviderControl themeColor;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  int ready_to_pack = 1;
  int location = 0;
  int ready_to_distribute = 1;
  String desc = ' ';
  String delivary_date = DateTime.now().toString();
  String NoOfmeals = ' ';
  Categories_item categories_item;
  List<Categories_item> catedories;
  Model model = Model();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController(text: DateTime.now().toString());

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
    dateController = TextEditingController(text: widget.donorOrder.delivary_date);
    setState(() {
      ready_to_distribute=int.parse(widget.donorOrder.readyToDistribute);
      ready_to_pack=int.parse(widget.donorOrder.readyToPack);

    });
    API(context).get('categories').then((value) {
      if (value != null) {
        print(value);
        if (value['status'] == true) {
          setState(() {
            catedories = Categories_model.fromJson(value).data;
            catedories.isNotEmpty ? categories_item = catedories.firstWhere((element) => element.id==int.parse(widget.donorOrder.category_id)) : null;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    themeColor = Provider.of<ProviderControl>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: themeColor.getColor(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/trkar_logo_white (copy).png',
            fit: BoxFit.fill,
            height: 50,
            //color: themeColor.getColor(),
          ),
        ),
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: ScreenUtil.getWidth(context) / 4,
                        color: Colors.black12,
                      ),
                      Text(
                        getTransrlate(context, 'edit'),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 1,
                        width: ScreenUtil.getWidth(context) / 4,
                        color: Colors.black12,
                      )
                    ],
                  ),
                ),
              ),

              catedories == null
                  ? Custom_Loading()
                  : Container(
                      padding: EdgeInsets.only(right: 16, left: 16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              getTransrlate(context, 'category'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            catedories.isEmpty
                                ? Container()
                                : DropdownSearch<Categories_item>(
                                    maxHeight: 200,
                                    validator: (Categories_item item) {
                                      if (item == null) {
                                        return "${getTransrlate(context, 'requiredempty')}";
                                      } else
                                        return null;
                                    },
                                    items: catedories,
                                    dropdownBuilder: (context, item) {
                                      return item == null
                                          ? Container()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(" ${item?.name} "),
                                            );
                                    },
                                    selectedItem:categories_item,
                                    //  onFind: (String filter) => getData(filter),
                                    itemAsString: (Categories_item u) => u.name,
                                    onChanged: (Categories_item data) =>
                                        categories_item = data,
                                  ),
                            SizedBox(
                              height: 20,
                            ),

                            Text("${getTransrlate(context, 'LocationUsage')}"),
                            Container(
                              width: ScreenUtil.getWidth(context),
                              height: ScreenUtil.getHeight(context) / 10,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: ScreenUtil.getWidth(context) / 2.2,
                                    child: ListTile(
                                      title: Text(
                                          '${getTransrlate(context, 'myLocation')}'),
                                      leading: Radio<int>(
                                        value: 0,
                                        activeColor: themeColor.getColor(),
                                        groupValue: location,
                                        onChanged: (int value) {
                                          setState(() {
                                            location = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: ScreenUtil.getWidth(context) / 2.2,
                                    child: ListTile(
                                      title: Text(
                                          '${getTransrlate(context, 'otherLocation')}'),
                                      leading: Radio<int>(
                                        value: 1,
                                        activeColor: themeColor.getColor(),
                                        groupValue: location,
                                        onChanged: (int value) {
                                          setState(() {
                                            location = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Text("${getTransrlate(context, 'OrderDate')}"),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              dateMask: 'yyyy/MM/dd',
                              controller: dateController,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 5 * 365)),
                             // initialDate: initStartDate,
                              //use24HourFormat: false,
                              icon: Icon(Icons.event),
                              dateLabelText: '${getTransrlate(context, 'Data')}',
                              timeLabelText: '${getTransrlate(context, 'Time')}',
                              onChanged: (val) => setState(() => dateController.text = val),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return  getTransrlate(
                                      context, 'requiredempty');
                                }
                                return null;
                              },
                              onSaved: (val) => setState(() => dateController.text = val ?? ''),
                              // decoration: InputDecoration(
                              //   labelStyle: TextStyle(color: Colors.grey[700]),
                              //   filled: true,
                              //   fillColor: Colors.white,
                              //   contentPadding:
                              //   EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                              //   border: OutlineInputBorder(
                              //       borderSide: BorderSide(
                              //           color: Theme.of(context).focusColor.withOpacity(0.2))),
                              //   focusedBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(
                              //           color: Theme.of(context).focusColor.withOpacity(0.5))),
                              //   enabledBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(
                              //           color: Theme.of(context).focusColor.withOpacity(0.2))),
                              // ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            location == 0
                                ? Container()
                                : MyTextFormField(
                                    labelText:
                                        '${getTransrlate(context, "AddressTitle")}',
                                    controller: addressController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return getTransrlate(
                                            context, 'requiredempty');
                                      }
                                      if (model.latitude == null &&
                                          model.longitude == null) {
                                        return getTransrlate(
                                            context, 'LocationSelected');
                                      }
                                      _formKey.currentState.save();
                                      return null;
                                    },
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.location_pin),
                                        onPressed: () {
                                          showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      MapOverlay(this.model))
                                              .whenComplete(() {
                                            model.latitude =
                                                this.model.latitude;
                                            model.longitude =
                                                this.model.longitude;
                                            addressController.text =
                                                '${this.model.address ?? ''}';
                                          });
                                        }),
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(254),
                                    ],
                                    onSaved: (String val) =>
                                        model.address = val,
                                    onChange: (String val) {
                                      model.address = val;
                                    },
                                  ),
                            SizedBox(
                              height: 5,
                            ),
                            categories_item?.id != 1
                                ? Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    MyTextFormField(
                                      labelText: getTransrlate(context, 'desc'),
                                      // hintText: getTransrlate(context, 'desc'),
                                      isEmail: true,
                                      enabled: true,
                                      minLines: 5,
                                      maxLines: 5,
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
                                  ],
                                )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyTextFormField(
                                        intialLabel: widget.donorOrder.number_of_meals??'',
                                        labelText:
                                            getTransrlate(context, 'NoOfmeals'),
                                        // hintText:
                                        //     getTransrlate(context, 'NoOfmeals'),
                                        enabled: true,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return getTransrlate(
                                                context, 'requiredempty');
                                          }
                                          _formKey.currentState.save();
                                          return null;
                                        },
                                        keyboard_type: TextInputType.number,
                                        onSaved: (String value) {
                                          NoOfmeals = value;
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          " ${getTransrlate(context, 'ready_to_distribute')}"),
                                      Container(
                                        width: ScreenUtil.getWidth(context),
                                        height:
                                            ScreenUtil.getHeight(context) / 10,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width:
                                                  ScreenUtil.getWidth(context) /
                                                      2.5,
                                              child: ListTile(
                                                title: Text(
                                                    '${getTransrlate(context, 'yes')}'),
                                                leading: Radio<int>(
                                                  value: 1,
                                                  groupValue:
                                                      ready_to_distribute,
                                                  activeColor:
                                                      themeColor.getColor(),
                                                  onChanged: (int value) {
                                                    setState(() {
                                                      ready_to_distribute =
                                                          value;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  ScreenUtil.getWidth(context) /
                                                      2.5,
                                              child: ListTile(
                                                title: Text(
                                                    '${getTransrlate(context, 'no')}'),
                                                leading: Radio<int>(
                                                  value: 0,
                                                  activeColor:
                                                      themeColor.getColor(),
                                                  groupValue:
                                                      ready_to_distribute,
                                                  onChanged: (int value) {
                                                    setState(() {
                                                      ready_to_distribute =
                                                          value;
                                                    });
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
                                      Text(
                                          "${getTransrlate(context, 'ready_to_pack')}"),
                                      Container(
                                        width: ScreenUtil.getWidth(context),
                                        height:
                                            ScreenUtil.getHeight(context) / 10,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width:
                                                  ScreenUtil.getWidth(context) /
                                                      2.5,
                                              child: ListTile(
                                                title: Text(
                                                    '${getTransrlate(context, 'yes')}'),
                                                leading: Radio<int>(
                                                  value: 1,
                                                  activeColor:
                                                      themeColor.getColor(),
                                                  groupValue: ready_to_pack,
                                                  onChanged: (int value) {
                                                    setState(() {
                                                      ready_to_pack = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  ScreenUtil.getWidth(context) /
                                                      2.5,
                                              child: ListTile(
                                                title: Text(
                                                    '${getTransrlate(context, 'no')}'),
                                                leading: Radio<int>(
                                                  value: 0,
                                                  activeColor:
                                                      themeColor.getColor(),
                                                  groupValue: ready_to_pack,
                                                  onChanged: (int value) {
                                                    setState(() {
                                                      ready_to_pack = value;
                                                    });
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
                                    ],
                                  ),

                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 40,
                              width: ScreenUtil.getWidth(context),
                              margin: EdgeInsets.only(
                                  top: 12, bottom: 0, right: 16, left: 16),
                              padding: EdgeInsets.only(right: 16, left: 16),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(1.0),
                                ),
                                color: themeColor.getColor(),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    setState(() => _isLoading = true);
                                    register(themeColor);
                                  }
                                },
                                child: Text(
                                  getTransrlate(context, 'save'),
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
                    ),
              SizedBox(
                height: 50,
              )
              //SocialRegisterButtons(themeColor: themeColor)
            ],
          ),
        ),
      ),
    );
  }

  Widget routeLoginWidget(ProviderControl themeColor, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 36, left: 48),
      child: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4,
                    color: Colors.black12,
                  ),
                  Text(
                    getTransrlate(context, 'or'),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4,
                    color: Colors.black12,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4.5,
                    color: Colors.black12,
                  ),
                  Text(
                    getTransrlate(context, 'haveanaccount'),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4.5,
                    color: Colors.black12,
                  )
                ],
              ),
            ),
          ),
          FlatButton(
            minWidth: ScreenUtil.getWidth(context),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.0),
                side: BorderSide(color: Colors.black26)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                getTransrlate(context, 'login'),
                style: TextStyle(
                  fontSize: 14,
                  color: themeColor.getColor(),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onPressed: () {
              Nav.routeReplacement(context, LoginPage());
            },
          )
        ],
      ),
    );
  }

  register(ProviderControl themeColor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    API(context).post('updateDonate/${widget.donorOrder.donorId}', {
      'category_id': categories_item.id,
      'ready_to_distribute': ready_to_distribute,
      'ready_to_pack': ready_to_pack,
      'description': desc,
      'delivary_date': dateController.text,
      'meals_num': NoOfmeals,
      'latitude': model.latitude,
      'longitude': model.longitude,
      'address': model.address,
      'status_id': 1,
    }).then((value) {
      print(value);
      if (value['status'] == true) {

        showDialog(
            context: context,
            builder: (_) => ResultOverlay('${value['message']}')).whenComplete(() {
          Navigator.pop(context);
          Nav.routeReplacement(context, DonorOrders());
        });
      } else {
        showDialog(
            context: context,
            builder: (_) => ResultOverlay('${value['message']}'));
      }
    });
  }
}

enum SingingCharacter { zero, one }
