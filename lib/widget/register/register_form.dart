import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/model/area_model.dart';
import 'package:flutter_pos/model/city_model.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/screens/splash_screen.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/widget/MapOverlay.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/register/register_form_model.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class RegisterForm extends StatefulWidget {
  int role_id;

  RegisterForm(this.role_id);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();
  bool PhoneStatue = false;
  bool passwordVisible = true;
  bool _isLoading = false;
  String CountryNo = '+996';
  String verificationId;
  String errorMessage = '';
  String smsOTP;
  int checkboxValueA = 1;
  final formKey = GlobalKey<FormState>();
  List<String> country = [];
  List<Area> items;
  List<Area> area;
  List<City> cities;
  List<City> districts;
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    API(context).get('gender').then((value) {
      if (value != null) {
        setState(() {
          items = AreaModel.fromJson(value).data;
        });
      }
    });
    API(context).get('areas').then((value) {
      if (value != null) {
        setState(() {
          area = AreaModel.fromJson(value).data;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 36, left: 48),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                MyTextFormField(
                  labelText: getTransrlate(context, 'name'),
                  hintText: getTransrlate(context, 'name'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    } else if (value.length <= 2) {
                      return "${getTransrlate(context, 'requiredlength')}";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    model.Name = value;
                  },
                ),
                MyTextFormField(
                  labelText: getTransrlate(context, 'Email'),
                  hintText: getTransrlate(context, 'Email'),
                  isEmail: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    } else if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                        .hasMatch(value)) {
                      return getTransrlate(context, 'invalidemail');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  textDirection: TextDirection.ltr,
                  onSaved: (String value) {
                    model.email = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      getTransrlate(context, 'phone'),
                    ),
                  ],
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: MyTextFormField(
                    hintText: getTransrlate(context, 'phone'),
                    istitle: true,
                    inputFormatters:[
                      new LengthLimitingTextInputFormatter(9),
                    ],
                    textDirection: TextDirection.ltr,
                    prefix: IconButton(
                      icon: Center(child: Text("$CountryNo")),
                      onPressed: () {},
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return getTransrlate(context, 'requiredempty');
                      }else if (value.length<9) {
                        return "${getTransrlate(context, 'shorterphone')}";
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onSaved: (String value) {
                      model.mobile = value;
                    },
                    keyboard_type: TextInputType.phone,
                  ),
                ),
                InkWell(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (_) => MapOverlay(this.model))
                        .whenComplete(() => addressController.text =
                    '${model.address ?? ''}');
                  },
                  child: MyTextFormField(
                    controller: addressController,
                    labelText: getTransrlate(context, 'AddressTitle'),
                    hintText: getTransrlate(context, 'AddressTitle'),
                    isEmail: true,
                    enabled: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => MapOverlay(this.model))
                            .whenComplete(() => addressController.text =
                        '${model.address ?? ''}');
                      },
                      icon: Icon(Icons.location_pin),
                    ),
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
                    onSaved: (String value) {
                      model.address = value;
                    },
                  ),
                ),
                Row(
                  children: [
                    Text(
                      getTransrlate(context, 'City'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownSearch<Area>(
                  mode: Mode.MENU,
                  validator: (Area item) {
                    if (item == null) {
                      return "${getTransrlate(context, 'requiredempty')}";
                    } else return null;
                  },
                  items: area,
                  //  onFind: (String filter) => getData(filter),
                  itemAsString: (Area u) => u.nameAr,

                  onChanged: (Area data) {
                    model.region = data.id;
                    setState(() {
                      cities=null;
                      districts=null;

                    });
                    API(context).get('cities/${data.id}').then((value) {
                      if (value != null) {
                        setState(() {
                          cities = City_model.fromJson(value).data;
                        });
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                cities == null
                    ? Container()
                    : Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          getTransrlate(context, 'area'),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    DropdownSearch<City>(
                      mode: Mode.MENU,
                      validator: (City item) {
                        if (item == null) {
                          return "${getTransrlate(context, 'requiredempty')}";
                        } else return null;
                      },
                      items: cities,

                      //  onFind: (String filter) => getData(filter),
                      itemAsString: (City u) => "${u.cityName}",
//                                        selectedItem:city.firstWhere((element) => element.id==userModal.city,orElse: ()=>City(cityName:userModal.city)) ,
                      onChanged: (City data) {
                        setState(() {
                          districts=null;
                        });
                        model.city = "${data.id}";

                        API(context).get('districts/${data.id}').then((value) {
                          if (value != null) {
                            setState(() {
                              districts = City_model.fromJson(value).data;
                            });
                          }
                        });
                      },
                      onSaved: (City data) {

                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                districts == null
                    ? Container()
                    : Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          getTransrlate(context, 'district'),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    DropdownSearch<City>(
                      mode: Mode.MENU,
                      validator: (City it) {
                        if (it == null) {
                          return "${getTransrlate(context, 'requiredempty')}";
                        } else return null;
                      },
                      items: districts,
                      //  onFind: (String filter) => getData(filter),
                      itemAsString: (City u) => "${u.cityName}",
//                          selectedItem:city.firstWhere((element) => element.id==userModal.city,orElse: ()=>City(cityName:userModal.city)) ,
                      onChanged: (City data) {
                        model.district = "${data.id}";
                      },
                      onSaved: (City data) {
                        model.district = "${data?.id}";

                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                widget.role_id==3?MyTextFormField(
                  labelText:
                  getTransrlate(context, 'family_members'),
                  hintText:
                  getTransrlate(context, 'family_members'),
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
                    model.family_members=int.tryParse(value??'0');
                  },
                ):Container(),
                SizedBox(
                  height: 10,
                ),
                items==null?Container():  Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          getTransrlate(context, 'gender'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownSearch<Area>(
                      mode: Mode.MENU,
                      maxHeight: 120,
                      validator: (Area item) {
                        if (item == null) {
                          return "${getTransrlate(context, 'requiredempty')}";
                        } else
                          return null;
                      },
                      items: items,
                      //  onFind: (String filter) => getData(filter),
                      itemAsString: (Area u) => u.nameAr,
                      onChanged: (Area data) => model.gender = data.id,
                    ),
                  ],
                ),
                MyTextFormField(
                  labelText: getTransrlate(context, 'password'),
                  hintText: getTransrlate(context, 'password'),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black26,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  isPassword: passwordVisible,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    } else if (value.length < 8) {
                      return getTransrlate(context, 'PasswordShorter');
                    } else if (!value.contains(new RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                      return "${getTransrlate(context, 'invalidpass')}";
                    }
                    _formKey.currentState.save();

                    return null;
                  },
                  onSaved: (String value) {
                    model.password = value;
                  },
                ),
                MyTextFormField(
                  labelText: getTransrlate(context, 'ConfirmPassword'),
                  hintText: getTransrlate(context, 'ConfirmPassword'),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility_off:Icons.visibility,
                      color: Colors.black26,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  isPassword: passwordVisible,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    } else if (value != model.password) {
                      return getTransrlate(context, 'Passwordmatch');
                    }

                    _formKey.currentState.save();

                    return null;
                  },
                  onSaved: (String value) {
                    model.password_confirmation = value;
                  },
                ),

                Container(
                  height: 40,
                  width: ScreenUtil.getWidth(context),
                  margin: EdgeInsets.only(top: 12, bottom: 0),
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
                      getTransrlate(context, 'RegisterNew'),
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
        _isLoading
            ? Container(
            color: Colors.white,
            height: ScreenUtil.getHeight(context) / 2,
            width: ScreenUtil.getWidth(context),
            child: Custom_Loading())
            : Container()
      ],
    );
  }

  register(Provider_control themeColor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    API(context).post('register', {
      'username': model.Name,
      'email': model.email,
      'password': model.password,
      'address': model.address,
      'mobile': model.mobile,
      'region': model.region,
      'city': model.city,
      'district': model.district,
      'gender': model.gender,
      'role_id': widget.role_id,
      'donation_type_id': 1,
      'status': "active",
      'family_members': model.family_members,
      'longitude': model.longitude ?? '',
      'latitude': model.latitude ?? '',
    }).then((value) {
      print(value);
      if (value['status'] == true) {
        setState(() => _isLoading = false);
        var user = value['data'];
        prefs.setString("user_email", user['email']);
        prefs.setString("user_name", user['username']);
        prefs.setString("token", value['access_token']??'');
        prefs.setString("address", "${user['address']}");
        prefs.setString("lat", "${user['latitude']}");
        prefs.setString("lang", "${user['longitude']}");
        prefs.setString("mobile", user['mobile']);
        prefs.setString("role_id", "${user['role_id']}");
        prefs.setInt("user_id", user['id']);
        themeColor.setLogin(true);
        showDialog(
            context: context,
            builder: (_) => ResultOverlay('${value['message']}'))
            .whenComplete(() {
          Nav.routeReplacement(context, SplashScreen());
        });
      } else {
        showDialog(
            context: context,
            builder: (_) =>
                ResultOverlay('${value['message']}\n${value['errors']}'));

        setState(() => _isLoading = false);
      }
    });
  }
}
