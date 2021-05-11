import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/filterPage.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:provider/provider.dart';

class SearchOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchOverlayState();
}

class SearchOverlayState extends State<SearchOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  @override
  void initState() {
    super.initState();

    controller =
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
          child: Container(
            color: themeColor.getColor(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Nav.route(context, FilterPage());
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
                      child: searchTextField = AutoCompleteTextField<String>(
                        key: key,
                        clearOnSubmit: false,
                        suggestions: [
                          "Apple",
                          "Armidillo",
                          "Actual",
                          "Actuary",
                          "America",
                          "Argentina",
                          "Australia",
                          "Antarctica"
                        ],
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: ' بحث ',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            )),
                        itemFilter: (item, query) {
                          return item
                              .toString()
                              .toLowerCase()
                              .startsWith(query.toLowerCase());
                        },
                        itemSorter: (a, b) {
                          return a.compareTo(b);
                        },
                        itemSubmitted: (item) {
                          setState(() {
                            searchTextField.textField.controller.text =
                                item.toString();
                          });
                        },
                        textChanged: (string) {},
                        itemBuilder: (context, item) {
                          // ui for the autocompelete row
                          return row(item);
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
        ),
      ),
    );
  }

  Widget row(String productModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          productModel.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        // Text(
        //   productModel.toString(),
        // ),
      ],
    );
  }
}
