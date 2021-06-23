import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/category/productCategory.dart';
import 'package:flutter_pos/screens/productCarPage.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/screen_size.dart';

import '../../utils/navigator.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    Key key,
    @required this.themeColor,
    this.product,
  }) : super(key: key);

  final Provider_control themeColor;
  final Product product;

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8,top: 8, right: 8, bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
        Nav.route(context, ProductCategory(id: widget.product.id,name: widget.product.categoryName,));
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  height:  ScreenUtil.getHeight(context)/11       ,
                    width: ScreenUtil.getWidth(context) / 3.2,
                  imageUrl: (widget.product.photo == null)
                      ? 'http://arabimagefoundation.com/images/defaultImage.png'
                      : widget.product.photo[0].image,
                  errorWidget: (context, url, error) => Icon(Icons.image,color: Colors.black12,),
                ),
              ),
            ),
            SizedBox(height: 5,),
            AutoSizeText(
             "${ widget.product.categoryName}",
              maxLines: 1,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              minFontSize: 14,
              maxFontSize: 20,
            )
          ],
        ),
      ),
    );
  }

  bool onLikeTapped() {
    // API(context)
    //     .post('wishlist', {"product_id": widget.product.id}).then((value) => {
    //           if (value['status'] != 'error')
    //             {
    //               setState(() {
    //                 widget.product.w = false;
    //               }),
    //               Scaffold.of(context).showSnackBar(SnackBar(
    //                   backgroundColor: mainColor,
    //                   content: Text(value['message'])))
    //             }
    //           else
    //             {
    //               setState(() {
    //                 widget.product.is_wishlisted = true;
    //               }),
    //               Scaffold.of(context).showSnackBar(SnackBar(
    //                   backgroundColor: mainColor,
    //                   content: Text(value['message'])))
    //             }
    //         });
  }
}
