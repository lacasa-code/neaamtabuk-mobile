import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
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
import 'package:flutter_pos/widget/app_bar_custom.dart';
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
  List<Main_Category> categories;
  int checkboxType = 0;
  int checkboxPart = 0;

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
          AppBarCustom(),
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
                                  width: ScreenUtil.getWidth(context) / 3,
                                  height: ScreenUtil.getHeight(context) / 1.25,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF6F6F6),
                                    image: DecorationImage(
                                        image: new ExactAssetImage(
                                          'assets/images/trkar_logo_white.png',
                                        ),
                                        alignment: Alignment.bottomCenter,
                                        fit: BoxFit.scaleDown),
                                    border: Border.symmetric(
                                        vertical:
                                            BorderSide(color: Colors.grey)),
                                  ),
                                  child: Container(
                                    color: Colors.white70,
                                    child: ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(1),
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: categories.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        bool selected = checkboxType == index;
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              checkboxType = index;
                                              checkboxPart = 0;
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
                                              "${categories[index].mainCategoryName}",
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
                                        categories[checkboxType].categories),
                                  ),
                                ),
                                // Container(
                                //  width: ScreenUtil.getWidth(context) / 3,
                                //  height: ScreenUtil.getHeight(context) / 1.25,
                                //   child:  getPartCategories(
                                //       categories[checkboxType].categories[checkboxPart].partCategories),
                                // ),
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

  getList(List<Categories> Categories) {
    return Categories == null
        ? Container()
        : Categories.isEmpty
            ? Container()
            : ListView.builder(
                primary: false,
                shrinkWrap: true,
                padding: EdgeInsets.all(1),
                physics: NeverScrollableScrollPhysics(),
                itemCount: Categories.length,
                itemBuilder: (BuildContext context, int index) {
                  bool selected = checkboxPart == index;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ExpandablePanel(
                      header: InkWell(
                        onTap: Categories[index].last_level == 0
                            ? null
                            : () {
                                Nav.route(
                                    context,
                                    ProductCategory(
                                      id: Categories[index].id,
                                      name: Categories[index].name,
                                    ));
                              },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Categories[index].name,
                                maxLines: 2,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  height: 1,
                                  color: Colors.black12,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      theme: ExpandableThemeData(
                          hasIcon: Categories[index].last_level == 0),
                      expanded: Categories[index].last_level != 0
                          ? Container()
                          : Container(
                              padding: EdgeInsets.only(right: 7, left: 10),
                              child: getPartCategories(
                                  Categories[index].partCategories),
                            ),
                    ),
                  );
                },
              );
  }

  getPartCategories(List<PartCategories> partCategories) {
    return partCategories == null
        ? Container()
        : partCategories.isEmpty
            ? Container()
            : ListView.builder(
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
                              maxLines: 2,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
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
