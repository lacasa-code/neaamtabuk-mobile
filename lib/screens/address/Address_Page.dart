import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/address/add_address.dart';
import 'package:flutter_pos/model/shipping_address.dart';
import 'package:flutter_pos/screens/address/edit_address.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/not_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Shipping_Address extends StatefulWidget {
  const Shipping_Address({Key key}) : super(key: key);

  @override
  _Shipping_AddressState createState() => _Shipping_AddressState();
}

class _Shipping_AddressState extends State<Shipping_Address> {
  List<Address> address;
  int checkboxValue;

  @override
  void initState() {
    getAddress();
    Provider.of<Provider_Data>(context,listen: false).address==null?null:
    checkboxValue=Provider.of<Provider_Data>(context,listen: false).address.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final _cart_model = Provider.of<Provider_Data>(context);

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
            Text(getTransrlate(context, 'MyAddress')),
          ],
        ),
      ),
      body: !themeColor.isLogin
          ? Notlogin()
          : Container(
              child: address == null
                  ? Center(child: Custom_Loading())
                  : SingleChildScrollView(
                    child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: address.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Radio<int>(
                                        value: address[index].id,
                                        groupValue: checkboxValue,
                                        activeColor: themeColor.getColor(),
                                        focusColor: themeColor.getColor(),
                                        hoverColor: themeColor.getColor(),
                                        onChanged: (int value) {
                                          setState(() {
                                            checkboxValue = value;
                                            API(context).post(
                                                'user/mark/default/shipping/${address[index].id}',
                                                {}).then((value) {
                                              if (value != null) {
                                                if (value['status_code'] ==
                                                    200) {
                                                  Navigator.pop(context);
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          ResultOverlay(value[
                                                          'message']));
                                                  _cart_model.setShipping(address[index]);

                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          ResultOverlay(value[
                                                          'message']));
                                                }
                                              }
                                            });
                                          });
                                        },
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            checkboxValue = index;
                                          });
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              address[index].recipientName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Container(
                                              width: ScreenUtil.getWidth(context) / 2.3,
                                              child: Text(
                                                "${address[index].apartmentNo??' '} /  ${address[index].floorNo??' '} ${address[index].district??' '} ,${address[index].street??' '}},}",
                                               maxLines: 2,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        height: 1,
                                      )),
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          _navigateAndeditSelection(context,address[index]);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          API(context)
                                              .Delete(
                                                  'user/delete/shipping/${address[index].id}')
                                              .then((value) {
                                            if (value != null) {print(value);
                                              if (value['status_code'] == 200) {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) => ResultOverlay(
                                                        value['message']));
                                                getAddress();
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) => ResultOverlay(
                                                        value['message']??value['errors']));
                                              }
                                            }
                                          });
                                        },
                                      )
                                    ],
                                  )),
                                );
                              },
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              child: Container(
                                width: ScreenUtil.getWidth(context) / 2.5,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.orange)),
                                child: Center(
                                  child: AutoSizeText(
                                    getTransrlate(context, 'AddNewAddress'),
                                    overflow: TextOverflow.ellipsis,
                                    maxFontSize: 14,
                                    maxLines: 1,
                                    minFontSize: 10,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                  ),
                                ),
                              ),
                              onTap: () {
                                _navigateAndDisplaySelection(context);
                              },
                            ),
                          ),
                          SizedBox(width: 1,height: 50,)
                        ],
                      ),
                  ),
            ),
    );
  }

  void getAddress() {
    setState(() {
      address=null;
    });
    API(context).get('user/all/shippings').then((value) {
      if (value != null) {
        setState(() {
          address = ShippingAddress.fromJson(value).data;
        });
      }
    });
  }

  _navigateAndDisplaySelection(
    BuildContext context,
  ) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddAddress()));
    Timer(Duration(seconds: 3), () => getAddress());
  }  _navigateAndeditSelection(
    BuildContext context,Address address
  ) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditAddress(address)));
    Timer(Duration(seconds: 2), () => getAddress());
  }
}
