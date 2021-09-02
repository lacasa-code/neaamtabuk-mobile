import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:provider/provider.dart';
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Main_Category> Mcategories;
  int checkboxType = 0;
  int checkboxPart = 0;

  @override
  void initState() {
    API(context).get('fetch/categories/nested/part').then((value) {
      if (value != null) {
        setState(() {
          Mcategories = Category_model.fromJson(value).data;
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
            child: Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                    vertical:
                    BorderSide(color: Colors.grey)),
              ),
              child: Container(
                color: Colors.white70,
                child: Mcategories == null
                    ? Center(child: Custom_Loading())
                    : Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height:ScreenUtil.getHeight(context) / 1.25 ,
                              decoration: BoxDecoration(
                                border: Border.symmetric(
                                    vertical:
                                    BorderSide(color: Colors.grey)),
                              ),
                              child: SingleChildScrollView(
                                child: Container(
                                  width: ScreenUtil.getWidth(context) / 2.8,
                                 // height: ScreenUtil.getHeight(context) / 1.25,
                                  child: Container(
                                    child: ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.symmetric(horizontal: 2),
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: Mcategories.length,
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
                                            height: ScreenUtil.getHeight(context) /10,
                                            decoration: BoxDecoration(
                                                color: !selected
                                                    ? Colors.white
                                                    : Color(0xffF6F6F6),
                                                border: Border.symmetric(
                                                    horizontal: BorderSide(
                                                        color: selected
                                                            ? Colors.black12
                                                            : Colors.black26))),
                                            child: Row(
                                              children: [
                                                Container(
                                                    height: ScreenUtil.getHeight(context) /10,

                                                    width: 10,color: !selected
                                                    ? Colors.white
                                                    : Colors.orange),
                                                SizedBox(width: 5,),
                                                Container(
                                                  width: ScreenUtil.getWidth(context) / 3.5,
                                                  padding: const EdgeInsets.only(
                                                      right: 2,left: 2),
                                                  child: AutoSizeText(
                                                    "${themeColor.getlocal()=='ar'? Mcategories[index].mainCategoryName??Mcategories[index].nameEn :Mcategories[index].nameEn??Mcategories[index].mainCategoryName}",
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    minFontSize: 12,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: getList(
                                    Mcategories[checkboxType].categories),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getList(List<Categories> Categories) {
    final themeColor = Provider.of<Provider_control>(context);
    return Categories == null
        ? Container()
        : Categories.isEmpty
            ? Container(child: NotFoundProduct())
            : Column(
              children: [
                ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(1),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: Categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool selected = checkboxPart == index;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ExpandablePanel(
                              header: InkWell(
                                onTap: Categories[index].last_level == 0
                                    ? null
                                    : () {
                                        Nav.route(
                                            context,
                                            Products_Page(
                                              id: Categories[index].id,
                                              name: Categories[index].name,
                                              Url: "site/part/categories/${Categories[index].id}?cartype_id=${themeColor.getcar_type()}",
                                              Istryers: Mcategories[checkboxType].id==7,

                                            ));
                                      },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${themeColor.getlocal()=='ar'? Categories[index].name??Categories[index].name_en :Categories[index].name_en??Categories[index].name}",
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontWeight: FontWeight.w600,
                                            fontSize: 13),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              //theme: ExpandableThemeData(hasIcon: Categories[index].partCategories.isNotEmpty),
                              expanded: Categories[index].last_level != 0
                                  ? Container()
                                  : Container(
                                      padding: EdgeInsets.only(right: 7, left: 10),
                                      child: getPartCategories(
                                          Categories[index].partCategories,Categories[index].id),
                                    ),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.black12,
                          )
                        ],
                      );
                    },
                  ),
                SizedBox(height: 25,)
              ],
            );
  }

  getPartCategories(List<PartCategories> partCategories,int catId) {
    final themeColor = Provider.of<Provider_control>(context);

    return partCategories == null
        ? Container()
        : partCategories.isEmpty
            ? Container(child: Container(
      height: ScreenUtil.getWidth(context)/2,
        child: NotFoundProduct()))
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
                            Products_Page(
                              id: partCategories[index].id,
                              name:themeColor.getlocal()=='ar'?partCategories[index].categoryName??partCategories[index].name_en:partCategories[index].name_en??partCategories[index].categoryName,
                              Url: "site/part/categories/${partCategories[index].id}?cartype_id=${themeColor.getcar_type()}",
                              Istryers:catId==84,

                            ));
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              themeColor.getlocal()=='ar'?partCategories[index].categoryName??partCategories[index].name_en:partCategories[index].name_en??partCategories[index].categoryName,
                              maxLines: 2,
                              style: TextStyle(fontWeight: FontWeight.w600,
                                  fontSize: 11),
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
