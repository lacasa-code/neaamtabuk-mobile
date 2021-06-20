import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/Filter.dart';
import 'package:flutter_pos/screens/Sort.dart';
import 'package:flutter_pos/screens/MyCars/myCars.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/widget/List/gridview.dart';
import 'package:flutter_pos/widget/List/listview.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProductCarmade extends StatefulWidget {
   List<Product> product;
   String api;
   int id;
   String name;
   ProductCarmade({this.product, this.id, this.name, this.api});
  @override
  _ProductCarmadeState createState() => _ProductCarmadeState();
}

class _ProductCarmadeState extends State<ProductCarmade> {
  bool list = false;
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarCustom(isback: true,title:   widget.name == null
                ? "نتائج البحث"
                : 'نتائج البحث عن\n${widget.name}'),
            widget.product == null
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
                        Text('${widget.product.length}  ${getTransrlate(context, 'product')}'),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => Filterdialog());
                          },
                          child: Row(
                            children: [
                              Text(' ${getTransrlate(context, 'filter')}'),
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
                              API(context)
                                  .get('${widget.api}?sort_type=${val}')
                                  .then((value) {
                                if (value != null) {
                                  if (value['status_code'] == 200) {
                                 setState(() {
                                   widget.product= Product_model.fromJson(value).data;

                                 });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => ResultOverlay(value['message']));
                                  }
                                }
                              });
                            });
                          },
                          child: Row(
                            children: [
                              Text(' ${getTransrlate(context, 'Sort')}'),
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
            widget.product == null
                ? Container()
                : widget.product.isEmpty
                ? Container(
              height: ScreenUtil.getHeight(context) / 1.5,
              child: NotFoundProduct(),
            ):list
                    ? grid_product(
                        product: widget.product,
                      )
                    : List_product(
                        product: widget.product,
                      ),
            SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }
}
