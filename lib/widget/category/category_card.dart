import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/screen_size.dart';

import '../../utils/navigator.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    Key key,
    @required this.themeColor,
    this.product,
    this.cartType,
  }) : super(key: key);

  final Provider_control themeColor;
  final Product product;
  final int  cartType;

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
      margin: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          print('site/categories/${widget.product.categoryId}?cartype_id=${widget.cartType}');
          Nav.route(
              context,
              Products_Page(
                id: widget.product.id,
                name: widget.product.categoryName.name,
                Url: 'site/categories/${widget.product.categoryId}?cartype_id=${widget.cartType}',
              ));
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CachedNetworkImage(
                  height: ScreenUtil.getHeight(context) / 12,
                  width: ScreenUtil.getWidth(context) / 3.2,
                  imageUrl: (widget.product.categoryName == null)
                      ? 'http://arabimagefoundation.com/images/defaultImage.png'
                      : widget.product.categoryName.photo.image,
                  errorWidget: (context, url, error) => Icon(
                    Icons.image,
                    color: Colors.black12,
                  ),
                ),
              ),
            ),
            AutoSizeText(
              "${widget.product.categoryName.name}",
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
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
