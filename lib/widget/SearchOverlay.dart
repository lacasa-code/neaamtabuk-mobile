import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/widget/List/listview.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:provider/provider.dart';

class SearchOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchOverlayState();
}

class SearchOverlayState extends State<SearchOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  List<Product> products = [];
  FocusNode _focusNode = FocusNode();
  String search_index;
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: themeColor.getColor(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            search_index ==null? null:search_index.isEmpty? null:Nav.route(context, Products_Page(Url: 'user/search/products?search_index=${search_index??''}',name:"نتائج البحث: ${search_index??''}" ,));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            color: Colors.orange,
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            color: Colors.white,
                            child: TextFormField(
                                  onChanged: (string) {
                                    search_index=string;
                                    if (string.length >= 1) {
                                      API(context).get(
                                          'user/search/products?search_index=$search_index&cartype_id=${themeColor.car_type}',).then((value) {
                                        if (value != null) {
                                          if (value['status_code'] == 200) {
                                            setState(() {
                                              products =
                                                  Product_model
                                                      .fromJson(value)
                                                      .data;
                                            });
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    ResultOverlay("${value['message']}\n${value['errors']}"));
                                          }
                                        }
                                      });
                                    } else {
                                      setState(() {
                                        products = [];
                                      });
                                    }
                                  },

                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                List_product(
                  product: products,ctx: context,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    FocusScope.of(context).unfocus();
  }
}
