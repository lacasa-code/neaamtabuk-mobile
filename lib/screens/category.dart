import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/screens/category/productCategory.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
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
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(themeColor.getCar_made())
                    ],
                  ),
                  color: Color(0xffE4E4E4),
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
          categories == null
              ? Container()
              : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: ScreenUtil.getWidth(context)/3,
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
                        padding: const EdgeInsets.only(top: 12.0,bottom: 12.0),
                        decoration: BoxDecoration(

                            border: Border.all(
                                color: selected
                                    ? Colors.black
                                    : Colors.grey)),
                        child: Center(
                            child: Text(
                              categories[index].name,
                              maxLines: 1,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Container(
                  child: getList(categories[checkboxType].partCategories),
                ),
              ),

            ],
          )
        ],
      ),);
  }

  getList(List<PartCategories> partCategories) {
    return categories == null
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
              Nav.route(context, ProductCategory(id: partCategories[index].id,name:partCategories[index].categoryName,));

            },
            child: Row(
              children: [
                Icon(
                  Icons.circle,size: 15,),
                SizedBox(width: 5,),
                Text(
                  partCategories[index].categoryName,
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );

  }

}
