import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/model/Categories_model.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/register/register_form_vendor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/category_model.dart';

class VolunteerPage extends StatefulWidget {
  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  String email, facebook_id;
  Provider_control themeColor;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  int ready_to_pack = 0;
  int ready_to_distribute = 0;
  Categories_item categories_item;
  List<Categories_item> catedories;

  @override
  void initState() {
    API(context).get('categories').then((value) {
      if (value != null) {
        print(value);
        if (value['status'] == true) {
          setState(() {
            catedories = Categories_model.fromJson(value).data;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    themeColor = Provider.of<Provider_control>(context);
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
                        getTransrlate(context, 'placeorder'),
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

              Container(
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
                      DropdownSearch<Categories_item>(
                        maxHeight: 120,
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(" ${item?.name} "),
                                );
                        },
                        //  onFind: (String filter) => getData(filter),
                        itemAsString: (Categories_item u) => u.name,
                        onChanged: (Categories_item data) =>
                            categories_item = data,
                      ),
                      SizedBox(
                        height: 20,
                      ),

                     categories_item?.id==2?Container(): Column(
                       crossAxisAlignment: CrossAxisAlignment.start,

                       children: [
                          Text(" ${getTransrlate(context,'ready_to_distribute')}"),
                          Container(
                            width: ScreenUtil.getWidth(context),
                            height: ScreenUtil.getHeight(context) / 10,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil.getWidth(context) / 2.5,
                                  child: ListTile(
                                    title: Text('${getTransrlate(context,'yes')}'),
                                    leading: Radio<int>(
                                      value: 0,
                                      groupValue: ready_to_distribute,
                                      activeColor: themeColor.getColor(),
                                      onChanged: (int value) {
                                        setState(() {
                                          ready_to_distribute = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil.getWidth(context) / 2.5,
                                  child: ListTile(
                                    title: Text('${getTransrlate(context,'no')}'),
                                    leading: Radio<int>(
                                      value: 1,
                                      activeColor: themeColor.getColor(),
                                      groupValue: ready_to_distribute,
                                      onChanged: (int value) {
                                        setState(() {
                                          ready_to_distribute = value;
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
                          Text("${getTransrlate(context,'ready_to_pack')}"),
                          Container(
                            width: ScreenUtil.getWidth(context),
                            height: ScreenUtil.getHeight(context) / 10,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil.getWidth(context) / 2.5,
                                  child: ListTile(
                                    title: Text('${getTransrlate(context,'yes')}'),
                                    leading: Radio<int>(
                                      value: 0,
                                      activeColor: themeColor.getColor(),
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
                                  width: ScreenUtil.getWidth(context) / 2.5,
                                  child: ListTile(
                                    title: Text('${getTransrlate(context,'no')}'),
                                    leading: Radio<int>(
                                      value: 1,
                                      activeColor: themeColor.getColor(),
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

  Widget routeLoginWidget(Provider_control themeColor, BuildContext context) {
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

  register(Provider_control themeColor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    API(context).post('donate', {
      'category_id': categories_item.id,
      'ready_to_distribute': ready_to_distribute,
      'ready_to_pack': ready_to_pack,
      'status_id': 1,
    }).then((value) {
      print(value);
      if (value['status'] == true) {
        Navigator.pop(context);

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

enum SingingCharacter { zero, one }
