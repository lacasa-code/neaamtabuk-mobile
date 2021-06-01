import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/Filter.dart';
import 'package:flutter_pos/screens/Sort.dart';
import 'package:flutter_pos/screens/MyCars/myCars.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/widget/List/gridview.dart';
import 'package:flutter_pos/widget/List/listview.dart';
import 'package:flutter_pos/widget/product/product_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<Product> product;
  ScrollController _scrollController = new ScrollController();
  int value=2;
  bool list = false;
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ubdateProduct();
      }
    });
    API(context).get('home/all/products').then((value) {
      if (value != null) {
        setState(() {
          product = Product_model.fromJson(value).data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      body: SingleChildScrollView(
        controller:  _scrollController,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              color: themeColor.getColor(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                    ),
                    color: Color(0xffE4E4E4),
                  ),
                  Text(
                    'نتائج البحث ',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  FlatButton(
                    onPressed: () {
                      Nav.route(context, MyCars());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/car2.svg',
                          fit: BoxFit.contain,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(themeColor.getCar_made(),style: TextStyle(
                            color: Colors.white
                        ),)
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context, builder: (_) => SearchOverlay());
                    },
                    icon: Icon(
                      Icons.search,
                      size: 30,
                    ),
                    color: Color(0xffE4E4E4),
                  ),
                ],
              ),
            ),
            product == null
                ? Container()
                : Container(
                    color: Colors.black26,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              list ? list = false : list = true;
                            });
                          },
                          icon: Icon(
                            list
                                ? Icons.table_rows_outlined
                                : Icons.apps_outlined,
                            color: Colors.black45,
                            size: 25,
                          ),
                          // color: Color(0xffE4E4E4),
                        ),
                        Text('${product.length} منتج'),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => Filterdialog());
                          },
                          child: Row(
                            children: [
                              Text('تصفية'),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {

                            showDialog(
                                context: context, builder: (_) => Sortdialog()).then((val){
                              print(val);

                            });
                          },
                          child: Row(
                            children: [
                              Text('ترتيب'),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
            product == null
                ? Container()
                : list
                    ? grid_product(

                        product: product,
                      )
                    : List_product(
                        product: product,
                      ),
          ],
        ),
      ),
    );
  }

  Widget list_product(Provider_control themeColor) {
    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      padding: EdgeInsets.all(1),

      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.77,
        crossAxisCount: 2,
      ),
      itemCount: product.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ProductCard(
            themeColor: themeColor,
            product: product[index],
          ),
        );
      },
    );
  }

  void ubdateProduct() {
    API(context).get('home/all/products?page=${value++}').then((value)  {
      setState(() {
        product.addAll(Product_model.fromJson(value).data);
      });

    });
  }
}
