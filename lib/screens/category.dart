import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/screens/category/productCategory.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:flutter_pos/widget/not_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'MyCars/myCars.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> categories;
  int checkboxType = 0;

  @override
  void initState() {
    API(context).get('fetch/categories/nested/part').then((value) {
      if (value != null) {
        setState(() {
          categories = Category_model.fromJson(value).data;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            //height: ScreenUtil.getHeight(context) - ScreenUtil.getHeight(context) / 1.2,
            color: themeColor.getColor(),
            padding: const EdgeInsets.only(top: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: ScreenUtil.getHeight(context) / 10,
                    width: ScreenUtil.getWidth(context) / 3,
                    fit: BoxFit.contain,
                  ),
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
                      Text(
                        themeColor.getCar_made(),
                        style: TextStyle(color: Colors.white),
                      )
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

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  categories == null
                      ? Container()
                      : Container(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: ScreenUtil.getWidth(context) / 2.5,
                                  height: ScreenUtil.getHeight(context) / 1.25,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF6F6F6),
                                        image: DecorationImage(
                                            image: new ExactAssetImage(
                                                'assets/images/trkar_logo_white.png',),
                                            alignment: Alignment.bottomCenter,
                                            fit: BoxFit.scaleDown),
                                    border: Border.symmetric(
                                        vertical: BorderSide(color: Colors.grey)),
                                  ),
                                  child: Container(
                                    color: Colors.white70,
                                    child: ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(1),
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: categories.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        bool selected = checkboxType == index;
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              checkboxType = index;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                bottom: 20.0,
                                                right: 20,
                                                left: 20),
                                            decoration: BoxDecoration(
                                                color: selected
                                                    ? Colors.white
                                                    : Color(0xffF6F6F6),
                                                border: Border.symmetric(
                                                    horizontal: BorderSide(
                                                        color: selected
                                                            ? Colors.black12
                                                            : Colors.black26))),
                                            child: AutoSizeText(
                                              categories[index].name,
                                              maxLines: 2,
                                              minFontSize: 10,
                                              maxFontSize: 16,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: getList(
                                        categories[checkboxType].partCategories),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getList(List<PartCategories> partCategories) {
    return categories == null
        ? Container()
        : partCategories.isEmpty?NotFoundLogin():ListView.builder(
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.all(1),
            physics: NeverScrollableScrollPhysics(),
            itemCount: partCategories.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Nav.route(
                        context,
                        ProductCategory(
                          id: partCategories[index].id,
                          name: partCategories[index].categoryName,
                        ));
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          partCategories[index].categoryName,
                          maxLines: 1,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16, top: 8, left: 16),
                          child: Container(
                            height: 1,
                            color: Colors.black12,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
