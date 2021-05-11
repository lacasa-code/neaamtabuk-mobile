import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(bottom: 4),
        height: 72,
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
            return a.compareTo(b);
          },
          itemSubmitted: (item) {
            setState(() {
              searchTextField.textField.controller.text = item.toString();
            });
          },
          textChanged: (string) {},
          itemBuilder: (context, item) {
            // ui for the autocompelete row
            return row(item);
          },
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
        Text(
          productModel.toString(),
        ),
      ],
    );
  }
}
