import 'dart:developer';

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
import 'package:flutter_pos/screens/tab_screen.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/utils/tab_provider.dart';
import 'package:flutter_pos/widget/MapOverlay.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/dropdown_widget.dart';
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
  String email, facebookId;
  ProviderControl themeColor;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  int readyToPack = 1;
  int location = 0;
  int readyToDistribute = 1;
  String date, time;
  String desc = ' ';
  String delivaryDate = DateTime.now().toString();
  String noOfMeals = ' ';
  Categories_item categoriesItem;
  List<Categories_item> catedories;
  Model model = Model();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController =
      TextEditingController(text: DateTime.now().toString());
  DateTime _dateTime = DateTime.now();
  var isInit = true;

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
    dateController =
        TextEditingController(text: widget.donorOrder.delivary_date);
    _dateTime = DateTime.parse(widget.donorOrder.delivary_date);

    setState(() {
      readyToDistribute = int.parse(widget.donorOrder.readyToDistribute);
      readyToPack = int.parse(widget.donorOrder.readyToPack);
    });
    API(context).get('categories').then((value) {
      if (value != null) {
        print(value);
        if (value['status'] == true) {
          setState(() {
            catedories = Categories_model.fromJson(value).data;
            catedories.isNotEmpty
                ? categoriesItem = catedories.firstWhere((element) =>
                    element.id == int.parse(widget.donorOrder.category_id))
                : null;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        time = TimeOfDay(hour: _dateTime.hour, minute: _dateTime.minute)
            .format(context);
      });
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    addressController.dispose();
    dateController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPopScope() async {
    Nav.routeReplacement(
      context,
      TabScreen(),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    themeColor = Provider.of<ProviderControl>(context);
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: themeColor.getColor(),
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => _onWillPopScope(),
              icon: ImageIcon(
                AssetImage('assets/icons/arrowBack.png'),
                color: themeColor.getColor(),
              ),
            ),
            title: Text(
              getTransrlate(context, 'edit'),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                catedories == null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Custom_Loading(),
                        ],
                      )
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
                                      dropdownSearchDecoration: InputDecoration(
                                        prefixIcon: ImageIcon(
                                          AssetImage(
                                              'assets/icons/category.png'),
                                        ),
                                        contentPadding: themeColor.local == 'ar'
                                            ? EdgeInsets.fromLTRB(0, 0, 12, 12)
                                            : EdgeInsets.fromLTRB(12, 12, 0, 0),
                                        border: OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(),
                                        errorStyle:
                                            TextStyle(color: Colors.red),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
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
                                      selectedItem: categoriesItem,
                                      //  onFind: (String filter) => getData(filter),
                                      itemAsString: (Categories_item u) =>
                                          u.name,
                                      onChanged: (Categories_item data) =>
                                          categoriesItem = data,
                                    ),
                              SizedBox(
                                height: 20,
                              ),
                              DropDownWidget(
                                removePadding: true,
                                dropDownMode: Mode.MENU,
                                value: getTransrlate(
                                    context,
                                    location == 0
                                        ? 'myLocation'
                                        : 'otherLocation'),
                                hint: 'LocationUsage',
                                items: [
                                  getTransrlate(context, 'myLocation'),
                                  getTransrlate(context, 'otherLocation'),
                                ],
                                onChanged: (v) {
                                  if (v == null) {
                                    return;
                                  }
                                  setState(() {
                                    if (v ==
                                        getTransrlate(context, 'myLocation')) {
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

                              SizedBox(
                                height: 10,
                              ),
                              // Text("${getTransrlate(context, 'OrderDate')}"),
                              // SizedBox(
                              //   height: 10,
                              // ),
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
                                  _dateTime = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    _dateTime.hour,
                                    _dateTime.minute,
                                    _dateTime.second,
                                    _dateTime.millisecond,
                                    _dateTime.microsecond,
                                  );
                                  setState(() {
                                    dateController.text = _dateTime.toString();
                                  });
                                },
                                child: DropDownWidget(
                                  removePadding: true,
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
                              SizedBox(
                                height: 10,
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
                                  _dateTime = DateTime(
                                    _dateTime.year,
                                    _dateTime.month,
                                    _dateTime.day,
                                    timePicker.hour,
                                    timePicker.minute,
                                  );
                                  setState(() {
                                    time = timePicker.format(context);
                                    dateController.text = _dateTime.toString();
                                  });
                                },
                                child: DropDownWidget(
                                  value: time,
                                  removePadding: true,
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

                              SizedBox(
                                height: 10,
                              ),
                              location == 0
                                  ? Container()
                                  : MyTextFormField(
                                      hintText: "AddressTitle",
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
                                        new LengthLimitingTextInputFormatter(
                                            254),
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
                              categoriesItem?.id != 1
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        MyTextFormField(
                                          hintText: 'desc',
                                          prefix: ImageIcon(
                                            AssetImage('assets/icons/edit.png'),
                                          ),
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
                                          keyboardType: TextInputType.multiline,
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
                                          intialLabel: widget
                                                  .donorOrder.number_of_meals ??
                                              '',
                                          hintText: 'NoOfmeals', istitle: true,
                                          prefix: ImageIcon(
                                            AssetImage('assets/icons/meal.png'),
                                          ),

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
                                          keyboardType: TextInputType.number,
                                          onSaved: (String value) {
                                            noOfMeals = value;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          " ${getTransrlate(context, 'ready_to_distribute')}",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: themeColor.getColor(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          width: ScreenUtil.getWidth(context),
                                          height:
                                              ScreenUtil.getHeight(context) /
                                                  10,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: ScreenUtil.getWidth(
                                                        context) /
                                                    2.5,
                                                child: ListTile(
                                                  title: Text(
                                                      '${getTransrlate(context, 'yes')}'),
                                                  leading: Radio<int>(
                                                    value: 1,
                                                    groupValue:
                                                        readyToDistribute,
                                                    activeColor:
                                                        themeColor.getColor(),
                                                    onChanged: (int value) {
                                                      setState(() {
                                                        readyToDistribute =
                                                            value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: ScreenUtil.getWidth(
                                                        context) /
                                                    2.5,
                                                child: ListTile(
                                                  title: Text(
                                                      '${getTransrlate(context, 'no')}'),
                                                  leading: Radio<int>(
                                                    value: 0,
                                                    activeColor:
                                                        themeColor.getColor(),
                                                    groupValue:
                                                        readyToDistribute,
                                                    onChanged: (int value) {
                                                      setState(() {
                                                        readyToDistribute =
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
                                          "${getTransrlate(context, 'ready_to_pack')}",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: themeColor.getColor(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          width: ScreenUtil.getWidth(context),
                                          height:
                                              ScreenUtil.getHeight(context) /
                                                  10,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: ScreenUtil.getWidth(
                                                        context) /
                                                    2.5,
                                                child: ListTile(
                                                  title: Text(
                                                      '${getTransrlate(context, 'yes')}'),
                                                  leading: Radio<int>(
                                                    value: 1,
                                                    activeColor:
                                                        themeColor.getColor(),
                                                    groupValue: readyToPack,
                                                    onChanged: (int value) {
                                                      setState(() {
                                                        readyToPack = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: ScreenUtil.getWidth(
                                                        context) /
                                                    2.5,
                                                child: ListTile(
                                                  title: Text(
                                                      '${getTransrlate(context, 'no')}'),
                                                  leading: Radio<int>(
                                                    value: 0,
                                                    activeColor:
                                                        themeColor.getColor(),
                                                    groupValue: readyToPack,
                                                    onChanged: (int value) {
                                                      setState(() {
                                                        readyToPack = value;
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
                                    borderRadius:
                                        new BorderRadius.circular(1.0),
                                  ),
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
        showDialog(
            context: context,
            builder: (_) => ResultOverlay(
                  '${value['message']}',
                  success: true,
                )).whenComplete(() {
          Nav.routeReplacement(
            context,
            ChangeNotifierProvider<TabProvider>(
              create: (_) => TabProvider(),
              child: TabScreen(),
            ),
          );
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
