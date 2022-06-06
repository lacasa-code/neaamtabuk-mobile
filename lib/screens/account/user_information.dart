import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/tab_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as util;
import 'package:flutter/services.dart';
import 'package:flutter_pos/main.dart';
import 'package:flutter_pos/model/area_model.dart';
import 'package:flutter_pos/model/city_model.dart';
import 'package:flutter_pos/model/user_info.dart';
import 'package:flutter_pos/screens/account/changePasswordPAge.dart';
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
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String name, email, roleId;
  bool _status = false;
  final FocusNode myFocusNode = FocusNode();
  bool _isLoading = false;
  bool loading = false;
  User userModal;
  Model model = Model();
  String password;
  List<Area> area;
  List<Area> items;
  List<City> city;
  List<City> districts;
  final _formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
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
    SharedPreferences.getInstance().then((pref) => {
          setState(() {
            roleId = pref.getString('role_id');
            print(roleId);
          }),
          addressController.text = pref.getString('address') ?? ''
        });
    API(context).get('areas').then((value) {
      if (value != null) {
        setState(() {
          area = AreaModel.fromJson(value).data;
        });
      }
    });
    API(context).get('gender').then((value) {
      if (value != null) {
        setState(() {
          items = AreaModel.fromJson(value).data;
        });
      }
    });
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ProviderControl>(context);
    return WillPopScope(
      onWillPop: () async {
        Provider.of<TabProvider>(context, listen: false).toHome();
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              getTransrlate(context, 'ProfileSettings'),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: util.ScreenUtil().setSp(17)),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton(
                  itemBuilder: (_) => [
                    CheckedPopupMenuItem(
                      value: 'ar',
                      checked: themeColor.local == 'ar',
                      child: Text(
                        'العربية',
                      ),
                    ),
                    CheckedPopupMenuItem(
                      value: 'en',
                      checked: themeColor.local == 'en',
                      child: Text(
                        'English',
                      ),
                    ),
                  ],
                  child: Icon(
                    Icons.language,
                    color: themeColor.getColor(),
                  ),
                  onSelected: (v) {
                    if (themeColor.local == v) {
                      return;
                    }
                    themeColor.setLocal(v);
                    MyApp.setlocal(context, Locale(themeColor.getlocal(), ''));
                    SharedPreferences.getInstance().then((prefs) {
                      prefs.setString('local', themeColor.local);
                    });
                  },
                ),
              ),
            ],
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Container(
                //   color: Colors.black12,
                //   width: ScreenUtil.getWidth(context),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(name ?? " "),
                //         Text(email ?? " "),
                //       ],
                //     ),
                //   ),
                // ),
                _isLoading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              // height: double.infinity,
                              // width: double.infinity,
                              color: Colors.white,
                              child: Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          themeColor.getColor())))),
                        ],
                      )
                    : userModal == null
                        ? Custom_Loading()
                        : Container(
                            color: Colors.white,
                            child: Container(
                              color: Colors.white,
                              child: Container(
                                color: Color(0xffFFFFFF),
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 15.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                          child: Column(
                                            children: <Widget>[
                                              MyTextFormField(
                                                intialLabel: name,
                                                enabled: false,
                                                istitle: true,
                                                hintText: 'name' ?? '',
                                                prefix: ImageIcon(
                                                  AssetImage(
                                                      'assets/icons/user.png'),
                                                ),
                                              ),
                                              MyTextFormField(
                                                istitle: true,
                                                enabled: !_status,
                                                intialLabel:
                                                    userModal?.phoneNo ?? '',
                                                hintText: 'phone',
                                                onSaved: (String val) =>
                                                    userModal.phoneNo = val,
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return getTransrlate(
                                                        context, 'phone');
                                                  } else if (value.length < 9) {
                                                    return "${getTransrlate(context, 'shorterphone')}";
                                                  }
                                                  _formKey.currentState.save();
                                                  return null;
                                                },
                                                prefix: ImageIcon(
                                                  AssetImage(
                                                      'assets/icons/phone.png'),
                                                ),
                                              ),
                                              MyTextFormField(
                                                istitle: true,
                                                hintText: 'Email',
                                                enabled: !_status,
                                                onSaved: (String val) =>
                                                    userModal.email = val,
                                                onChange: (String val) =>
                                                    userModal.email = val,
                                                validator: (String value) {
                                                  if (value.isEmpty &&
                                                      roleId != "3") {
                                                    return getTransrlate(
                                                        context, 'mail');
                                                  } else if (value.isNotEmpty &&
                                                      !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                          .hasMatch(value)) {
                                                    return getTransrlate(
                                                        context,
                                                        'invalidemail');
                                                  }
                                                  _formKey.currentState.save();
                                                  return null;
                                                },
                                                intialLabel: email ?? '',
                                                prefix: ImageIcon(
                                                  AssetImage(
                                                      'assets/icons/email.png'),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              MapOverlay(
                                                                  this.model))
                                                      .whenComplete(() {
                                                    userModal.latitude =
                                                        this.model.latitude;
                                                    userModal.longitude =
                                                        this.model.longitude;
                                                    addressController.text =
                                                        '${this.model.address ?? ''}';
                                                  });
                                                },
                                                child: MyTextFormField(
                                                  // autoFocus: !_status,
                                                  onSaved: (String val) =>
                                                      userModal.address = val,
                                                  onChange: (String val) {
                                                    userModal.address = val;
                                                  },
                                                  controller: addressController,
                                                  inputFormatters: [
                                                    new LengthLimitingTextInputFormatter(
                                                        254),
                                                  ],
                                                  suffixIcon: IconButton(
                                                      icon: Icon(Icons
                                                          .add_location_alt),
                                                      onPressed: () {
                                                        showDialog(
                                                                context: context,
                                                                builder: (_) =>
                                                                    MapOverlay(this
                                                                        .model))
                                                            .whenComplete(() {
                                                          userModal.latitude =
                                                              this
                                                                  .model
                                                                  .latitude;
                                                          userModal.longitude =
                                                              this
                                                                  .model
                                                                  .longitude;
                                                          addressController
                                                                  .text =
                                                              '${this.model.address ?? ''}';
                                                        });
                                                      }),
                                                  istitle: true,
                                                  hintText: 'AddressTitle',
                                                  enabled: !_status,
                                                  validator: (String v) {
                                                    if (v.isEmpty) {
                                                      return getTransrlate(
                                                          context,
                                                          'address_required');
                                                    }
                                                    return null;
                                                  },
                                                  prefix: ImageIcon(
                                                    AssetImage(
                                                        'assets/icons/location.png'),
                                                  ),
                                                ),
                                              ),

                                              // Container(
                                              //   height: 42,
                                              //   width: ScreenUtil.getWidth(context),
                                              //   decoration: BoxDecoration(
                                              //     borderRadius: BorderRadius.circular(10),
                                              //     gradient: LinearGradient(
                                              //       colors: [
                                              //         Color(0xff2CA649),
                                              //         Color(0xff2CA649),
                                              //         Color(0xff4BB146),
                                              //         Color(0xff4BB146),
                                              //         Color(0xff66BA44),
                                              //         Color(0xff77C042),
                                              //       ],
                                              //     ),
                                              //   ),
                                              //   margin: EdgeInsets.only(
                                              //     top: 20,
                                              //     bottom: 12,
                                              //   ),
                                              //   child: FlatButton(
                                              //     shape: RoundedRectangleBorder(
                                              //       borderRadius: new BorderRadius.circular(8.0),
                                              //     ),
                                              //     onPressed: () async {
                                              //       if (_formKey.currentState.validate()) {
                                              //         _formKey.currentState.save();
                                              //         FocusScope.of(context).requestFocus(new FocusNode());
                                              //         //  setState(() => _isLoading = true);
                                              //       }
                                              //     },
                                              //     child: Text(
                                              //       getTransrlate(context, 'Submit'),
                                              //       style: TextStyle(
                                              //         fontSize: 16,
                                              //         color: Colors.white,
                                              //         fontWeight: FontWeight.w400,
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.only(
                                        //       left: 25.0, right: 25.0, top: 25.0),
                                        //   child: Text(
                                        //     getTransrlate(context, 'AddressTitle'),
                                        //   ),
                                        // ),
                                        // InkWell(
                                        //   // onTap: () {
                                        //   //   showDialog(
                                        //   //           context: context,
                                        //   //           builder: (_) =>
                                        //   //               MapOverlay(this.model))
                                        //   //       .whenComplete(() {
                                        //   //     userModal.latitude =
                                        //   //         this.model.latitude;
                                        //   //     userModal.longitude =
                                        //   //         this.model.longitude;
                                        //   //     addressController.text =
                                        //   //         '${this.model.address ?? ''}';
                                        //   //   });
                                        //   // },
                                        //   child: Padding(
                                        //       padding: EdgeInsets.only(
                                        //           left: 25.0,
                                        //           right: 25.0,
                                        //           top: 2.0),
                                        //       child: TextFormField(
                                        //         controller: addressController,
                                        //         decoration: InputDecoration(
                                        //             // suffixIcon: IconButton(
                                        //             //   icon: Icon(Icons.location_pin),
                                        //             //   onPressed: () {
                                        //             //     showDialog(
                                        //             //             context: context,
                                        //             //             builder: (_) =>
                                        //             //                 MapOverlay(
                                        //             //                     this.model))
                                        //             //         .whenComplete(() {
                                        //             //       userModal.latitude =
                                        //             //           this.model.latitude;
                                        //             //       userModal.longitude =
                                        //             //           this.model.longitude;
                                        //             //       addressController.text =
                                        //             //           '${this.model.address ?? ''}';
                                        //             //     });
                                        //             //   },
                                        //             // ),
                                        //             ),
                                        //         enabled: !_status,
                                        //         // inputFormatters: [
                                        //         //   new LengthLimitingTextInputFormatter(
                                        //         //       254),
                                        //         // ],
                                        //         autofocus: !_status,
                                        //         onSaved: (String val) =>
                                        //             userModal.address = val,
                                        //         onChanged: (String val) {
                                        //           userModal.address = val;
                                        //         },
                                        //       )),
                                        // ),
                                        // Padding(
                                        //   padding: EdgeInsets.only(
                                        //       left: 25.0, right: 25.0, top: 10.0),
                                        //   child: Row(
                                        //     children: [
                                        //       Text(
                                        //         getTransrlate(context, 'City'),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        area == null
                                            ? Custom_Loading()
                                            : Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 10.0),
                                                child: DropdownSearch<Area>(
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    contentPadding: themeColor
                                                                .local ==
                                                            'ar'
                                                        ? EdgeInsets.fromLTRB(
                                                            0, 0, 12, 12)
                                                        : EdgeInsets.fromLTRB(
                                                            12, 12, 0, 0),
                                                    border:
                                                        OutlineInputBorder(),
                                                    disabledBorder:
                                                        OutlineInputBorder(),
                                                    errorStyle: TextStyle(
                                                        color: Colors.red),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    labelStyle: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),

                                                  prefixIcon: ImageIcon(AssetImage(
                                                      'assets/icons/building.png')),
                                                  hint: getTransrlate(
                                                      context, 'City'),
                                                  enabled: !_status,
                                                  mode: Mode.MENU,
                                                  validator: (Area item) {
                                                    if (item == null) {
                                                      return "${getTransrlate(context, 'requiredempty')}";
                                                    } else
                                                      return null;
                                                  },
                                                  items: area,
                                                  //  onFind: (String filter) => getData(filter),
                                                  itemAsString: (Area u) =>
                                                      u.nameAr,
                                                  selectedItem: area.firstWhere(
                                                      (element) =>
                                                          element.id ==
                                                          userModal.region,
                                                      orElse: () => Area(
                                                          nameAr: userModal
                                                              .region)),
                                                  onChanged: (Area data) {
                                                    userModal.region = data.id;
                                                    setState(() {
                                                      districts = null;
                                                      city == null;
                                                    });
                                                    API(context)
                                                        .get(
                                                            'cities/${data.id}')
                                                        .then((value) {
                                                      if (value != null) {
                                                        setState(() {
                                                          city = City_model
                                                                  .fromJson(
                                                                      value)
                                                              .data;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  onSaved: (Area data) =>
                                                      userModal.region =
                                                          data.id,
                                                ),
                                              ),
                                        city == null
                                            ? Container()
                                            : Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15.0,
                                                        right: 15.0,
                                                        top: 10.0),
                                                    child: DropdownSearch<City>(
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            themeColor.local ==
                                                                    'ar'
                                                                ? EdgeInsets
                                                                    .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        12,
                                                                        12)
                                                                : EdgeInsets
                                                                    .fromLTRB(
                                                                        12,
                                                                        12,
                                                                        0,
                                                                        0),
                                                        border:
                                                            OutlineInputBorder(),
                                                        disabledBorder:
                                                            OutlineInputBorder(),
                                                        errorStyle: TextStyle(
                                                            color: Colors.red),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        labelStyle: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      prefixIcon: ImageIcon(
                                                        AssetImage(
                                                            'assets/icons/building.png'),
                                                      ),

                                                      hint: getTransrlate(
                                                          context, 'area'),
                                                      enabled: !_status,
                                                      mode: Mode.MENU,
                                                      validator: (City item) {
                                                        if (item == null) {
                                                          return "${getTransrlate(context, 'requiredempty')}";
                                                        } else
                                                          return null;
                                                      },
                                                      items: city,
                                                      //  onFind: (String filter) => getData(filter),
                                                      onChanged: (City data) {
                                                        print(data.id);

                                                        setState(() {
                                                          userModal.city =
                                                              data.id;
                                                          userModal.cityName =
                                                              "${data.cityName}";
                                                          districts = null;
                                                        });
                                                        API(context)
                                                            .get(
                                                                'districts/${data.id}')
                                                            .then((value) {
                                                          if (value != null) {
                                                            setState(() {
                                                              districts = City_model
                                                                      .fromJson(
                                                                          value)
                                                                  .data;
                                                            });
                                                          }
                                                        });
                                                      },
                                                      itemAsString: (City u) =>
                                                          "${u?.cityName}",
                                                      selectedItem: city?.firstWhere(
                                                          (element) =>
                                                              element.id ==
                                                              userModal.city,
                                                          orElse: () => City(
                                                              cityName:
                                                                  "${userModal?.cityName ?? ' '}")),
                                                      onSaved: (City data) =>
                                                          userModal.city =
                                                              data?.id,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        districts == null
                                            ? Container()
                                            : Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 10.0),
                                                child: Column(
                                                  children: [
                                                    DropdownSearch<City>(
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            themeColor.local ==
                                                                    'ar'
                                                                ? EdgeInsets
                                                                    .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        12,
                                                                        12)
                                                                : EdgeInsets
                                                                    .fromLTRB(
                                                                        12,
                                                                        12,
                                                                        0,
                                                                        0),
                                                        border:
                                                            OutlineInputBorder(),
                                                        disabledBorder:
                                                            OutlineInputBorder(),
                                                        errorStyle: TextStyle(
                                                            color: Colors.red),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        labelStyle: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      prefixIcon: ImageIcon(
                                                          AssetImage(
                                                              'assets/icons/building.png')),

                                                      hint: getTransrlate(
                                                          context, 'district'),
                                                      mode: Mode.MENU,
                                                      enabled: !_status,

                                                      validator: (City item) {
                                                        if (item == null) {
                                                          return "${getTransrlate(context, 'requiredempty')}";
                                                        } else
                                                          return null;
                                                      },
                                                      items: districts,
                                                      //  onFind: (String filter) => getData(filter),
                                                      itemAsString: (City u) =>
                                                          "${u.cityName}",
                                                      selectedItem:
                                                          districts.firstWhere(
                                                              (element) =>
                                                                  element.id ==
                                                                  userModal
                                                                      .district,
                                                              orElse: () =>
                                                                  City(
                                                                      cityName:
                                                                          '')),
                                                      onChanged: (City data) {
                                                        print(data.id);
                                                        userModal.district =
                                                            data.id;
                                                      },
                                                      onSaved: (City data) {
                                                        userModal.district =
                                                            data.id;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        // Padding(
                                        //     padding: EdgeInsets.only(
                                        //         left: 25.0, right: 25.0, top: 10.0),
                                        //     child: Text(
                                        //       getTransrlate(context, 'mail'),
                                        //     )),
                                        // Padding(
                                        //     padding: EdgeInsets.only(
                                        //         left: 25.0, right: 25.0, top: 2.0),
                                        //     child: TextFormField(
                                        //       inputFormatters: [
                                        //         new LengthLimitingTextInputFormatter(
                                        //             200),
                                        //       ],
                                        //       initialValue: userModal.email,
                                        //       decoration: const InputDecoration(),

                                        //       enabled: !_status,
                                        //       onSaved: (String val) =>
                                        //           userModal.email = val,
                                        //       onChanged: (String val) =>
                                        //           userModal.email = val,
                                        //     )),
                                        // Padding(
                                        //     padding: EdgeInsets.only(
                                        //         left: 25.0, right: 25.0, top: 1.0),
                                        //     child: Text(
                                        //       getTransrlate(context, 'phone'),
                                        //     )),
                                        // Padding(
                                        //     padding: EdgeInsets.only(
                                        //         left: 25.0, right: 25.0, top: 2.0),
                                        //     child: TextFormField(
                                        //       inputFormatters: [
                                        //         new LengthLimitingTextInputFormatter(
                                        //             17),
                                        //       ],
                                        //       initialValue: userModal.phoneNo,
                                        //       keyboardType: TextInputType.phone,
                                        //       decoration: InputDecoration(),
                                        //       // validator: (String value) {
                                        //       //   if (value.isEmpty) {
                                        //       //     return getTransrlate(
                                        //       //         context, 'phone');
                                        //       //   } else if (value.length < 9) {
                                        //       //     return "${getTransrlate(context, 'shorterphone')}";
                                        //       //   }
                                        //       //   _formKey.currentState.save();
                                        //       //   return null;
                                        //       // },
                                        //       enabled: !_status,
                                        //       onSaved: (String val) =>
                                        //           userModal.phoneNo = val,
                                        //     )),
                                        // Padding(
                                        //     padding: EdgeInsets.only(
                                        //         left: 25.0, right: 25.0, top: 25.0),
                                        //     child: Text(
                                        //       getTransrlate(context, 'gender'),
                                        //     )),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                              top: 10.0,
                                              bottom: 10),
                                          child: DropdownSearch<Area>(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              contentPadding:
                                                  themeColor.local == 'ar'
                                                      ? EdgeInsets.fromLTRB(
                                                          0, 0, 12, 12)
                                                      : EdgeInsets.fromLTRB(
                                                          12, 12, 0, 0),
                                              border: OutlineInputBorder(),
                                              disabledBorder:
                                                  OutlineInputBorder(),
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

                                            hint: getTransrlate(
                                                context, 'gender'),
                                            prefixIcon: ImageIcon(
                                              AssetImage(
                                                'assets/icons/gender.png',
                                              ),
                                            ),
                                            maxHeight: 120,
                                            validator: (Area item) {
                                              if (item == null) {
                                                return "${getTransrlate(context, 'requiredempty')}";
                                              } else
                                                return null;
                                            },
                                            items: items,
                                            // selectedItem: userModal.gender,
                                            selectedItem: items?.firstWhere(
                                                (element) =>
                                                    element.id ==
                                                    userModal.gender,
                                                orElse: () => Area(
                                                    nameAr: userModal.gender ??
                                                        ' ')),

                                            enabled: !_status,
                                            //  onFind: (String filter) => getData(filter),
                                            itemAsString: (Area u) => u.nameAr,
                                            onChanged: (Area data) =>
                                                userModal.gender = data.id,
                                          ),
                                        ),
                                        roleId == "3"
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 5.0,
                                                    bottom: 5),
                                                child: MyTextFormField(
                                                  istitle: true,
                                                  prefix: Icon(
                                                      Icons.card_membership),
                                                  intialLabel:
                                                      userModal.family_member,
                                                  hintText: 'family_members',
                                                  // hintText:
                                                  // getTransrlate(context, 'family_members'),
                                                  enabled: true,
                                                  validator: (String value) {
                                                    if (value.isEmpty) {
                                                      return getTransrlate(
                                                          context,
                                                          'requiredempty');
                                                    }
                                                    _formKey.currentState
                                                        .save();
                                                    return null;
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onSaved: (String value) {
                                                    userModal.family_member =
                                                        value;
                                                  },
                                                ),
                                              )
                                            : Container(),
                                        _getActionButtons(),
                                        SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ))
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    addressController.dispose();

    super.dispose();
  }

  Widget _getActionButtons() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: loading
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                          minWidth: ScreenUtil.getWidth(context) / 2.5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30,
                              child: Center(
                                  child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )),
                            ),
                          ),
                          onPressed: () async {},
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            //  final SharedPreferences prefs = await SharedPreferences.getInstance();
                            setState(() => loading = true);
                            log('body =>${{
                              "username": userModal.name,
                              if (userModal.email.isNotEmpty) ...{
                              "email": userModal.email,
                              },
                              "address": userModal.address,
                              "mobile": userModal.phoneNo,
                              "gender": userModal.gender,
                              "city": userModal.city,
                              "district": userModal.district,
                              "region": userModal.region,
                              "longitude": userModal.longitude,
                              "latitude": userModal.latitude,
                              "family_members":
                                  int.tryParse(userModal.family_member ?? '0'),
                              "role_id": roleId,
                            }}');
                            API(context).post('update', {
                              "username": userModal.name,
                              if (userModal.email.isNotEmpty) ...{
                                "email": userModal.email,
                              },
                              "address": userModal.address,
                              "mobile": userModal.phoneNo,
                              "gender": userModal.gender,
                              "city": userModal.city,
                              "district": userModal.district,
                              "region": userModal.region,
                              "longitude": userModal.longitude,
                              "latitude": userModal.latitude,
                              "family_members":
                                  int.tryParse(userModal.family_member ?? '0'),
                              "role_id": roleId,
                            }).then((value) {
                              setState(() => loading = false);

                              if (value != null) {
                                if (value['status'] == true) {
                                  getUser();
                                  showDialog(
                                      context: context,
                                      builder: (_) => ResultOverlay(
                                            value['message'],
                                            success: true,
                                          ));
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                  });
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) =>
                                          ResultOverlay("${value['message']}"));
                                }
                              }
                            });
                          }
                        },
                        child: Container(
                            width: ScreenUtil.getWidth(context) / 2.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                getTransrlate(context, 'save'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )),
                      ),
              ),
              flex: 2,
            ),
            // Expanded(
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 10.0, right: 10.0),
            //     child: GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           _status = true;
            //           FocusScope.of(context).requestFocus(new FocusNode());
            //         });
            //       },
            //       child: Container(
            //           width: ScreenUtil.getWidth(context) / 2.5,
            //           padding: const EdgeInsets.all(10.0),
            //           height: 42,
            //           decoration: BoxDecoration(
            //             gradient: LinearGradient(
            //               colors: [
            //                 Color(0xff2CA649),
            //                 Color(0xff2CA649),
            //                 Color(0xff4BB146),
            //                 Color(0xff4BB146),
            //                 Color(0xff66BA44),
            //                 Color(0xff77C042),
            //               ],
            //             ),
            //           ),
            //           child: Center(
            //             child: Text(
            //               getTransrlate(context, 'cancel'),
            //               style: TextStyle(
            //                   fontWeight: FontWeight.bold, color: Colors.white),
            //             ),
            //           )),
            //     ),
            //   ),
            //   flex: 2,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _getEditIcon() {
    return Center(
      child: GestureDetector(
        child: Container(
          width: ScreenUtil.getWidth(context),
          padding: const EdgeInsets.all(10.0),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
          child: Center(
            child: AutoSizeText(
              getTransrlate(context, 'edit'),
              overflow: TextOverflow.ellipsis,
              maxFontSize: 14,
              maxLines: 1,
              minFontSize: 10,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        onTap: () {
          setState(() {
            _status = false;
          });
        },
      ),
    );
  }

  Widget _getChangePassword() {
    return Center(
      child: GestureDetector(
        child: Container(
          width: ScreenUtil.getWidth(context) / 2.5,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.green)),
          child: Center(
            child: AutoSizeText(
              getTransrlate(context, 'changePassword'),
              overflow: TextOverflow.ellipsis,
              maxFontSize: 14,
              maxLines: 1,
              minFontSize: 10,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
        ),
        onTap: () {
          Nav.route(context, changePassword());
        },
      ),
    );
  }

  void getUser() {
    SharedPreferences.getInstance().then((pref) => {
          setState(() {
            name = pref.getString('user_name');
            roleId = pref.getString('role_id');
            email = pref.getString('user_email');
          }),
          print(pref.getString('token')),
          API(context).get('userProfile').then((value) {
            if (value != null) {
              print(value);
              if (value['status'] == true) {
                var user = value['data'];
                pref.setString("user_email", user['email'] ?? ' ');
                pref.setString("user_name", user['username'] ?? ' ');
                pref.setString("address", "${user['address']}");
                pref.setString("lat", "${user['latitude']}");
                pref.setString("lang", "${user['longitude']}");

                setState(() {
                  userModal = UserInformation.fromJson(value).data;
                });
                API(context).get('cities/${userModal.region}').then((value) {
                  if (value != null) {
                    setState(() {
                      city = City_model.fromJson(value).data;
                    });
                  }
                });
                API(context).get('districts/${userModal.city}').then((value) {
                  if (value != null) {
                    setState(() {
                      districts = City_model.fromJson(value).data;
                    });
                  }
                });
                addressController =
                    TextEditingController(text: userModal.address);
              } else {
                showDialog(
                    context: context,
                    builder: (_) => ResultOverlay(value['message']));
              }
            }
          })
        });
  }
}
