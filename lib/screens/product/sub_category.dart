import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pos/model/Categories_model.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
class SubCategoryScreen extends StatefulWidget {
   SubCategoryScreen({Key key,this.Categories}) : super(key: key);
  List<Categories_item> Categories;
  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  int checkboxType = 0;
  int checkboxPart = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final data = Provider.of<Provider_Data>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarCustom(isback: true,),
            Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                    vertical:
                    BorderSide(color: Colors.grey)),
              ),
              child: Container(
                color: Colors.white70,
                child: data.categories == null
                    ? Center(child: Custom_Loading())
                    : Container(
                        child: SingleChildScrollView(
                          child: getList(
                              widget.Categories),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getList(List<Categories_item> Categories) {
    final themeColor = Provider.of<Provider_control>(context);
    final data = Provider.of<Provider_Data>(context);
    return Categories == null
        ? Container()
        : Categories.isEmpty
            ? Container(child: NotFoundProduct(title: getTransrlate(context, 'EmptyCate'),))
            : Column(
              children: [
                ResponsiveGridList(
                    desiredItemWidth: ScreenUtil.getWidth(context)/2.2,
                    minSpacing: 10,
                    //rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    scroll: false,
                    children: Categories.map((e) =>Padding(
                      padding: const EdgeInsets.all(2.0),
                      child:InkWell(
                        onTap:  () {
                          Nav.route(context, SubCategoryScreen(Categories: Categories[checkboxType].categories=e.categories,));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CachedNetworkImage(imageUrl: '${e.photo!=null?e.photo.image:' '}',height: 100,width: 75,fit: BoxFit.contain,
                            errorWidget: (context, url, error) =>Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/trkar_logo_white (copy).png',color: Colors.grey,),
                            ),),
                            Container(
                              width: ScreenUtil.getWidth(context)/7,
                              child: Text(
                                "${themeColor.getlocal()=='ar'? e.name??e.nameEn :e.nameEn??e.name}",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                            IconButton(onPressed: (){
                              Nav.route(
                                  context,
                                  Products_Page(
                                    id:e.id,
                                    name:
                                    "${themeColor.getlocal()=='ar'? e.name??e.nameEn :e.nameEn??e.name}",
                                    Url: "home/allcategories/products/${e.id}",
                                    Istryers: e.id==84,
                                    Category: true,
                                  ));
                            }, icon: Icon(Icons.search))
                          ],
                        ),
                      ),
                    )).toList()
                ),
                // ListView.builder(
                //     primary: false,
                //     shrinkWrap: true,
                //     padding: EdgeInsets.all(1),
                //     physics: NeverScrollableScrollPhysics(),
                //     itemCount: Categories.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       bool selected = checkboxPart == index;
                //       return Column(
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.all(10),
                //             child:InkWell(
                //                 onTap: Categories[index].last_level == 0
                //                     ? null
                //                     : () {
                //                         Nav.route(
                //                             context,
                //                             Products_Page(
                //                               id: Categories[index].id,
                //                               name: Categories[index].name,
                //                               Url: "site/part/categories/${Categories[index].id}?cartype_id=${themeColor.getcar_type()}",
                //                               Istryers: Provider.of<Provider_Data>(context,listen: false).categories[checkboxType].id==7,
                //
                //                             ));
                //                       },
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Container(
                //                       width: ScreenUtil.getWidth(context)/3,
                //                       child: Text(
                //                         "${themeColor.getlocal()=='ar'? Categories[index].name??Categories[index].name_en :Categories[index].name_en??Categories[index].name}",
                //                         maxLines: 2,
                //                         textAlign: TextAlign.start,
                //                         style: TextStyle(fontWeight: FontWeight.w600,
                //                             fontSize: 12),
                //                       ),
                //                     ),
                //                     IconButton(onPressed: (){
                //                       Nav.route(
                //                           context,
                //                           Products_Page(
                //                             id:Categories[index].id,
                //                             name: "${ themeColor.getlocal()=='ar'?Categories[index].name??Categories[index].name_en :Categories[index].name_en??Categories[index].name}",
                //                             Url: 'site/categories/${Categories[index].id}?cartype_id=${themeColor.car_type}',
                //                             Istryers: Categories[index].id==84,
                //                             Category: true,
                //                           ));
                //                     }, icon: Icon(Icons.search))
                //                   ],
                //                 ),
                //               ),
                //           ),
                //           Container(
                //             height: 1,
                //             color: Colors.black12,
                //           )
                //         ],
                //       );
                //     },
                //   ),
                // SizedBox(height: 25,)
              ],
            );
  }

}