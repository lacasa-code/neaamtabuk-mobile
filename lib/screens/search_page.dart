import 'dart:html';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/service/api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> products = [];
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Product>> key = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(bottom: 4),
        height: 72,
        child: searchTextField = AutoCompleteTextField<Product>(
          key: key,
          clearOnSubmit: false,
          suggestions: products,
          style: TextStyle(color: Colors.black, fontSize: 16.0),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'search',
              hintStyle: TextStyle(
                fontSize: 13,
                color: Color(0xFF5D6A78),
                fontWeight: FontWeight.w400,
              )),
          itemFilter: (item, query) {
            return item
                .toString()
                .toLowerCase()
                .startsWith(query.toLowerCase());
          },
          itemSorter: (a, b) {
            return a.name.compareTo(b.name);
          },
          itemSubmitted: (item) {
            setState(() {
              searchTextField.textField.controller.text = item.toString();
            });
          },
          textChanged: (string) {
            API(context).post('user/search/products', {
              "search_index": string,
            }).then((value) {
              if (value != null) {
                if (value['status_code'] == 200) {
                  setState(() {
                    products = Product_model.fromJson(value).data;
                  });
                } else {
                  showDialog(
                      context: context,
                      builder: (_) => ResultOverlay(value['message']));
                }
              }
            });
          },
          itemBuilder: (context, item) {
            // ui for the autocompelete row
            return row(item);
          },
        ),
      ),
    );
  }

  Widget row(Product productModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          productModel.name.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          productModel.carMadeName.toString(),
        ),
      ],
    );
  }
}
