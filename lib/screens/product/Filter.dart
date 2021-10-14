import 'package:dropdown_search/dropdown_search.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/Categories_model.dart';
import 'package:flutter_pos/model/carmodel.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../../model/cart_category.dart';
import '../../model/manufacturers.dart';
import '../../model/origins.dart';
import '../../service/api.dart';
import '../../utils/screen_size.dart';

class Filterdialog extends StatefulWidget {
  Filterdialog({Key key, this.Istryers, this.Category, this.Category_id}) : super(key: key);

  bool Istryers = false;
  bool Category = false;
  int Category_id ;

  @override
  _FilterdialogState createState() => _FilterdialogState();
}

class _FilterdialogState extends State<Filterdialog> {
  final _formKey = GlobalKey<FormState>();
  List<PartCategories> partss;
  List<Origin> origin;
  List<Manufacturer> manufacturer;
  List<Product> product;
  List<int> partSelect = [];
  List<int> originSelect = [];
  List<int> manufacturerSelect = [];
  List<String> width = [];
  List<String> height = [];
  List<String> size = [];
  String widthID;
  String heightID;

  String sizeID;

  RangeValues _currentRangeValues;
  double min = 1, max = 10000;

  @override
  void initState() {
    _currentRangeValues = RangeValues(min, max);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final data = Provider.of<Provider_Data>(context);

    return Material(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 4),
                height: 72,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Color(0xffCCCCCC),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    top: 8,
                    left: 24,
                    right: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${getTransrlate(context, 'filter')}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff7B7B7B)),
                      ),
                      IconButton(
                          icon: Icon(Icons.close,
                              size: 35, color: Color(0xff7B7B7B)),
                          onPressed: () {
                            Navigator.pop(
                              context,
                              // "part_categories:[],manufacturers:[],origins: [],"
                              //"start_price": [],
                              //  "end_price": [],
                            );
                          })
                    ],
                  ),
                ),
              ),
              widget.Istryers
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                          top: 8,
                          left: 24,
                          right: 24,
                        ),
                        child: ExpandablePanel(
                          header: Text(
                            '${getTransrlate(context, 'frameDimensions')}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          expanded: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: ScreenUtil.getHeight(context)/3,
                              width: ScreenUtil.getWidth(context) ,
                              child: Stack(

                                children: [
                                  Positioned(
                                    right: 1,
                                    child: Container(
                                      width: ScreenUtil.getWidth(context) / 2.5,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<String>(
                                              label:
                                                  " ${getTransrlate(context, 'width')} ",
                                              showSearchBox: true,
                                              showClearButton: false,
                                              mode: Mode.MENU,

                                              items: width,
                                              validator: (String item) {
                                                if (item == null) {
                                                  return "${getTransrlate(context, 'width')}";
                                                } else
                                                  return null;
                                              },
                                              onChanged: (String item) {
                                                widthID = item;
                                              },
                                              //  onFind: (String filter) => getData(filter),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<String>(
                                              label:
                                                  " ${getTransrlate(context, 'height')} ",
                                              showSearchBox: true,
                                              showClearButton: false,
                                              mode: Mode.MENU,

                                              items: height,
                                              validator: (String item) {
                                                if (item == null) {
                                                  return "${getTransrlate(context, 'height')}";
                                                } else
                                                  return null;
                                              },
                                              onChanged: (String item) {
                                                heightID = item;
                                              },
                                              //  onFind: (String filter) => getData(filter),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<String>(
                                              label:
                                                  " ${getTransrlate(context, 'size')} ",
                                              showSearchBox: true,
                                              showClearButton: false,
                                              mode: Mode.MENU,

                                              items: size,
                                              validator: (String item) {
                                                if (item == null) {
                                                  return "${getTransrlate(context, 'size')}";
                                                } else
                                                  return null;
                                              },
                                              onChanged: (String item) {
                                                sizeID = item;
                                              },
                                              //  onFind: (String filter) => getData(filter),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 1,
                                    child: Image.asset(
                                      'assets/images/tire.png',
                                      width: ScreenUtil.getWidth(context) / 2.5,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  :widget.Category?Container(): Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                          top: 8,
                          left: 24,
                          right: 24,
                        ),
                        child: ExpandablePanel(
                          header: Text(
                            '${getTransrlate(context, 'category')}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          expanded: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: data.categories == null
                                ? Custom_Loading()
                                : data.categories.isEmpty
                                    ? Container()
                                    : ListView.builder(
                                        primary: false,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: data.categories.firstWhere((element) => element.id==themeColor.car_type).categories.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return  ExpansionCatgory(data.categories.firstWhere((element) => element.id==themeColor.car_type).categories[index],themeColor);
                                        }),
                          ),
                        ),
                      ),
                    ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    top: 8,
                    left: 24,
                    right: 24,
                  ),
                  child: ExpandablePanel(
                    header: Text(
                      '${getTransrlate(context, 'manufacturers')}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    expanded: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: manufacturer == null
                          ? Custom_Loading()
                          : ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: manufacturer.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Checkbox(
                                        activeColor: Colors.orange,
                                        value: manufacturer[index].check,
                                        onChanged: (value) {
                                          setState(() {
                                            manufacturer[index].check = value;
                                          });
                                          value
                                              ? manufacturerSelect
                                                  .add(manufacturer[index].id)
                                              : manufacturerSelect
                                                  .remove(manufacturer[index].id);
                                        }),
                                    Text(
                                      manufacturer[index].manufacturerName,
                                      softWrap: true,
                                    ),
                                  ],
                                );
                              }),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    top: 8,
                    left: 24,
                    right: 24,
                  ),
                  child: ExpandablePanel(
                    header: Text(
                      '${getTransrlate(context, 'carmade')}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    expanded: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: origin == null
                          ? Custom_Loading()
                          : ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: origin.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Checkbox(
                                        value: origin[index].check,
                                        activeColor: Colors.orange,
                                        onChanged: (value) {
                                          setState(() {
                                            origin[index].check = value;
                                          });
                                          value
                                              ? originSelect.add(origin[index].id)
                                              : originSelect
                                                  .remove(origin[index].id);
                                        }),
                                    Text(
                                      origin[index].countryName,
                                      softWrap: true,
                                    ),
                                  ],
                                );
                              }),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    top: 8,
                    left: 24,
                    right: 24,
                  ),
                  child: ExpandablePanel(
                    header: Text(
                      '${getTransrlate(context, 'price')}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    expanded: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: ScreenUtil.getWidth(context) * 0.10,
                                child: Text(_currentRangeValues.start
                                    .round()
                                    .toString())),
                            Container(
                              width: ScreenUtil.getWidth(context) / 1.6,
                              child: RangeSlider(
                                activeColor: Colors.orange,
                                inactiveColor: Colors.black26,
                                values: _currentRangeValues,
                                min: min,
                                max: max,
                                divisions: 10000,
                                labels: RangeLabels(
                                  _currentRangeValues.start.round().toString(),
                                  _currentRangeValues.end.round().toString(),
                                ),
                                onChanged: (RangeValues values) {
                                  setState(() {
                                    _currentRangeValues = values;
                                  });
                                },
                              ),
                            ),
                            Container(
                                width: ScreenUtil.getWidth(context) * 0.10,
                                child: Text(
                                    _currentRangeValues.end.round().toString())),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: ScreenUtil.getWidth(context) * 0.10,
                                child: Text("${getTransrlate(context, 'from')}")),
                            Container(
                              width: ScreenUtil.getWidth(context) / 3,
                              child: MyTextFormField(
                                enabled: false,
                                intialLabel: min.toString(),
                                onChange: (v) {
                                  setState(() {
                                    _currentRangeValues =
                                        RangeValues(double.parse(v), max);
                                    min = double.parse(v);
                                  });
                                },
                              ),
                            ),
                            Container(
                                width: ScreenUtil.getWidth(context) * 0.10,
                                child: Text("${getTransrlate(context, 'to')}")),
                            Container(
                              width: ScreenUtil.getWidth(context) / 3,
                              child: MyTextFormField(
                                keyboard_type:TextInputType.number,
                                intialLabel: max.toString(),
                                onChange: (v) {
                                  setState(() {
                                    _currentRangeValues =
                                        RangeValues(min, double.parse(v));
                                    max = double.parse(v);
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Navigator.pop(
                    context,
                    "${!widget.Istryers ? '' : "?width=${widthID ??
                        ''}&height=${heightID ?? ''}&size=${sizeID ?? ''}"}"
                        "${manufacturerSelect.isEmpty
                        ? ''
                        : "&manufacturers=${manufacturerSelect.toString()}"}"
                        "${partSelect.isEmpty
                        ? ''
                        : "&part_categories=${partSelect.toString()}"}"
                        "${originSelect.isEmpty ? '' : "&origins=${originSelect
                        .toString()}"}"
                        "${_currentRangeValues.start
                        .round()
                        .toString()
                        .isEmpty ? '' : "&start_price=${_currentRangeValues
                        .start.round().toString()}"}"
                        "${_currentRangeValues.end
                        .round()
                        .toString()
                        .isEmpty ? '' : "&end_price=${_currentRangeValues.end
                        .round().toString()}"}");
              }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        width: ScreenUtil.getWidth(context) / 2.5,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange)),
                        child: Center(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle_outline_sharp,
                              color: Colors.orange,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${getTransrlate(context, 'Accept')}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
                          ],
                        )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getData();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        width: ScreenUtil.getWidth(context) / 2.5,
                        decoration:
                            BoxDecoration(border: Border.all(color: Colors.grey)),
                        child: Center(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.refresh,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${getTransrlate(context, 'ReSet')}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getData() {
    partSelect = [];
    originSelect = [];
    manufacturerSelect = [];

  widget.Istryers? API(context).get('part/category/attributes/${widget.Category_id}').then((value) {
     print(value);

     if (value != null) {
        setState(() {
          if (value['data'] != null) {
            width = value['data']['width'].cast<String>();
            height = value['data']['height'].cast<String>();
            size = value['data']['size'].cast<String>();
          }
        });
      }
    }):null;
    API(context).get('site/origins/list').then((value) {
      if (value != null) {
        setState(() {
          origin = Origins.fromJson(value).data;
          origin.forEach((element) {});
        });
      }
    });
    API(context).get('site/manufacturers/list').then((value) {
      if (value != null) {
        setState(() {
          manufacturer = Manufacturers.fromJson(value).data;
          manufacturer.forEach((element) {});
        });
      }
    });
  }

  ExpansionCatgory(Categories_item categories_item,Provider_control themeColor){
    return categories_item.id==1711||categories_item.id==682?Container(): ExpansionTile(
      textColor: Colors.orange,
      iconColor: Colors.orange,
      collapsedTextColor: Colors.black,
      title: Text(
          "${themeColor.getlocal() == 'ar' ? categories_item.name : categories_item.nameEn}"),
      children: [
        categories_item.categories == null
            ? Container()
            : ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: categories_item.categories
                .length,
            itemBuilder:
                (BuildContext context,
                int i) {
              return categories_item.categories[i].level==0? itemCatgory(categories_item.categories[i],themeColor):ExpansionCatgory(categories_item.categories[i],themeColor);
            })
      ],
    );
  }
  itemCatgory(Categories_item categories_item,Provider_control themeColor){
    return Row(
      children: [
        Checkbox(
            value: categories_item
                .Check,
            activeColor:
            Colors.orange,
            onChanged: (value) {
              setState(() {
                categories_item.Check = value;
              });
              value
                  ? partSelect.add(categories_item.id)
                  : partSelect.remove(categories_item.id);
            }),
        Text(
          "${themeColor.getlocal() == 'ar' ? categories_item.name ?? categories_item.name : categories_item.nameEn ?? categories_item.name}",
          softWrap: true,
        ),
      ],
    );
  }
}
