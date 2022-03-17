import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:flutter_pos/widget/register/register_form_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String name, email,role_id;
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  bool _isLoading = false;
  bool loading = false;
  User userModal;
  Model model = Model();
  String password;
  List<Area> area;
  List<Area> items;
  List<City> city;
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
    final themeColor = Provider.of<Provider_control>(context);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/User Icon.svg",
                color: Colors.white,
                height: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text(getTransrlate(context, 'ProfileSettings'),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              color: Colors.black12,
              width: ScreenUtil.getWidth(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name ?? " "),
                    Text(email ?? " "),
                  ],
                ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Text(
                                        getTransrlate(context, 'AddressTitle'),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        showDialog(context: context,
                                            builder: (_) => MapOverlay(this.model)).whenComplete(() {
                                          userModal.latitude=this.model.latitude;
                                          userModal.longitude=this.model.longitude;
                                          addressController.text =
                                          '${this.model.address ?? ''}';
                                        });
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.0, right: 25.0, top: 2.0),
                                          child: TextFormField(
                                            controller: addressController,
                                            decoration:  InputDecoration(
                                              suffixIcon: IconButton( icon: Icon(Icons.location_pin),
                                             onPressed: (){
                                               showDialog(context: context,
                                                   builder: (_) => MapOverlay(this.model)).whenComplete(() {
                                                 userModal.latitude=this.model.latitude;
                                                 userModal.longitude=this.model.longitude;
                                                 addressController.text =
                                                 '${this.model.address ?? ''}';
                                               });
                                             })
                                            ),
                                            enabled:false,
                                            inputFormatters: [
                                              new LengthLimitingTextInputFormatter(254),
                                            ],
                                              autofocus: !_status,
                                            onSaved: (String val) =>
                                                userModal.address = val,
                                            onChanged: (String val) {
                                              userModal.address = val;
                                            },

                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            getTransrlate(context, 'area'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    area==null?Custom_Loading():   Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 10.0),
                                      child: DropdownSearch<Area>(
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
                                        itemAsString: (Area u) => u.nameAr,
                                        selectedItem:area.firstWhere((element) => element.id==userModal.region,orElse: ()=>Area(nameAr:userModal.region)) ,
                                        onChanged: (Area data) {
                                          userModal.region = data.id;
                                          API(context).get('cities/${data.id}').then((value) {
                                            if (value != null) {
                                              setState(() {
                                                city = City_model.fromJson(value).data;
                                              });
                                            }
                                          });
                                        },
                                        onSaved: (Area data) =>
                                        userModal.region = data.id,
                                      ),
                                    ),
                                    city==null?Container():   Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.0, right: 25.0, top: 10.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                getTransrlate(context, 'City'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.0, right: 25.0, top: 10.0),
                                          child: DropdownSearch<City>(
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
                                            itemAsString: (City u) => "${u?.cityName}",
                                           selectedItem:city?.firstWhere((element) => element.id==userModal.city,orElse: ()=>City(cityName:"${userModal?.city??' '}")) ,
                                            onSaved: (City data) =>
                                            userModal.city = data?.id,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 10.0),
                                        child: Text(
                                          getTransrlate(context, 'mail'),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: TextFormField(
                                          inputFormatters: [
                                            new LengthLimitingTextInputFormatter(200),
                                          ],
                                          initialValue: userModal.email,
                                          decoration: const InputDecoration(),
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return getTransrlate(
                                                  context, 'mail');
                                            } else if (!RegExp(
                                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                .hasMatch(value)) {
                                              return getTransrlate(
                                                  context, 'invalidemail');
                                            }
                                            _formKey.currentState.save();
                                            return null;
                                          },
                                          enabled:false,
                                          onSaved: (String val) =>
                                              userModal.email = val,
                                          onChanged: (String val) =>
                                              userModal.email = val,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 1.0),
                                        child: Text(
                                          getTransrlate(context, 'phone'),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: TextFormField(
                                          inputFormatters: [
                                            new LengthLimitingTextInputFormatter(17),
                                          ],
                                          initialValue: userModal.phoneNo,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(),
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return getTransrlate(context, 'phone');
                                            }else if (value.length<9) {
                                              return "${getTransrlate(context, 'shorterphone')}";
                                            }
                                            _formKey.currentState.save();
                                            return null;
                                          },
                                          enabled: !_status,
                                          onSaved: (String val) =>
                                              userModal.phoneNo = val,
                                         )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Text(
                                         getTransrlate(context, 'gender'),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0,
                                          right: 25.0,
                                          top: 10.0,
                                          bottom: 10),
                                      child: DropdownSearch<Area>(
                                        maxHeight: 120,
                                        validator: (Area item) {
                                          if (item == null) {
                                            return "${getTransrlate(context, 'requiredempty')}";
                                          } else
                                            return null;
                                        },
                                        items: items,
                                       // selectedItem: userModal.gender,
                                        selectedItem:items?.firstWhere((element) => element.id==userModal.gender,orElse: ()=>Area(nameAr:userModal.gender??' ')) ,

                                        enabled: !_status,
                                        //  onFind: (String filter) => getData(filter),
                                        itemAsString: (Area u) => u.nameAr,
                                        onChanged: (Area data) =>
                                            userModal.gender = data.id,
                                      ),
                                    ),
                                    _status
                                        ? _getEditIcon()
                                        : _getActionButtons(),
                                  SizedBox(height: 20,)
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
                child:  loading?FlatButton(
                  minWidth: ScreenUtil.getWidth(context) / 2.5,
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:Container(
                      height: 30,
                      child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation<Color>( Colors.white),
                          )),
                    ),
                  ),
                  onPressed: () async {
                  },
                ):InkWell(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    //  final SharedPreferences prefs = await SharedPreferences.getInstance();
                      setState(() => loading = true);
                      API(context).post('update', {
                        "username": userModal.name,
                        "email": userModal.email,
                        "address": userModal.address,
                        "mobile": userModal.phoneNo,
                        "gender": userModal.gender,
                        "city": userModal.city,
                        "region": userModal.region,
                        "longitude": userModal.longitude,
                        "latitude": userModal.latitude,
                        "role_id": role_id,

                      }).then((value) {
                        setState(() => loading = false);

                        if (value != null) {

                          if (value['status'] == true) {

                            getUser();
                            showDialog(
                                context: context,
                                builder: (_) =>
                                    ResultOverlay(value['message']));
                            setState(() {
                              _status = true;
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) =>
                                    ResultOverlay("${value['message']}" ));
                          }
                        }
                      });
                    }
                  },
                  child: Container(
                      width: ScreenUtil.getWidth(context) / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green)),
                      child: Center(
                        child: Text(
                            getTransrlate(context, 'save'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      )),
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _status = true;
                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                  },
                  child: Container(
                      width: ScreenUtil.getWidth(context) / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Center(
                        child: Text(
    getTransrlate(context, 'cancel'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      )),
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getEditIcon() {
    return Center(
      child: GestureDetector(
        child: Container(
          width: ScreenUtil.getWidth(context) / 2.5,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.green)),
          child: Center(
            child: AutoSizeText(
              getTransrlate(context, 'edit'),
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
        role_id = pref.getString('role_id');
        email = pref.getString('user_email');
      }),
    print(pref.getString('token')),
        API(context).get('userProfile').then((value) {
        if (value != null) {
          print(value);
          if (value['status'] == true) {
            var user = value['data'];
            pref.setString("user_email", user['email']??' ');
            pref.setString("user_name", user['username']??' ');
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
            addressController = TextEditingController(text: userModal.address);
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
