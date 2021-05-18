import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/ResultOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/productCarPage.dart';
import 'package:flutter_pos/utils/navigator.dart';

import '../model/cart_category.dart';
import '../model/manufacturers.dart';
import '../model/origins.dart';
import '../service/api.dart';
import '../utils/screen_size.dart';

class Filterdialog extends StatefulWidget {
  const Filterdialog({Key key}) : super(key: key);

  @override
  _FilterdialogState createState() => _FilterdialogState();
}

class _FilterdialogState extends State<Filterdialog> {
  List<Category> parts;
  List<Origin> origin;
  List<Manufacturer> manufacturer;
  List<Products> product;
  List<int> partSelect = [];
  List<int> originSelect = [];
  List<int> manufacturerSelect = [];
  @override
  void initState() {
    API(context).get('fetch/categories/nested/part').then((value) {
      if (value != null) {
        setState(() {
          parts = PartCategory.fromJson(value).data;
          parts.forEach((element) {});
        });
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
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
                      'تصفية',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff7B7B7B)),
                    ),
                    IconButton(
                        icon: Icon(Icons.close,
                            size: 35, color: Color(0xff7B7B7B)),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
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
                    'الفئة',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  expanded: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: parts == null
                        ? Container()
                        : ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: parts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ExpansionTile(
                                title: Text(parts[index].name),
                                children: [
                                  ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          parts[index].partCategories.length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return Row(
                                          children: [
                                            Checkbox(
                                                value: parts[index]
                                                    .partCategories[i]
                                                    .partsCheck,
                                                activeColor: Colors.orange,
                                                onChanged: (value) {
                                                  setState(() {
                                                    parts[index]
                                                        .partCategories[i]
                                                        .partsCheck = value;
                                                  });
                                                  partSelect.add(parts[index]
                                                      .partCategories[i]
                                                      .id);
                                                }),
                                            Text(
                                              parts[index]
                                                  .partCategories[i]
                                                  .categoryName,
                                              softWrap: true,
                                            ),
                                          ],
                                        );
                                      })
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
                    'الجهة المنتجة',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  expanded: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: manufacturer == null
                        ? Container()
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
                                        manufacturerSelect
                                            .add(manufacturer[index].id);
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
                    'بلد المنشأ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  expanded: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: origin == null
                        ? Container()
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
                                        originSelect.add(origin[index].id);
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
                    'السعر',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  expanded: Padding(
                      padding: const EdgeInsets.all(16.0), child: Container()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      API(context).post('site/checkbox/filter', {
                        "part_categories": partSelect.toString(),
                        "manufacturers": manufacturerSelect.toString(),
                        "origins": originSelect.toString(),
                      }).then((value) {
                        if (value != null) {
                          if (value['status_code'] == 200) {
                            Nav.route(
                                context,
                                ProductCarPage(
                                  product: Product_model.fromJson(value).data,
                                ));
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) =>
                                    ResultOverlay(value['message']));
                          }
                        }
                      });
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
                            'تطبيق',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                        ],
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
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
                            'إعادة ضبط',
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
    );
  }
}
