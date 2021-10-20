import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../model/product_model.dart';
import '../../utils/Provider/provider.dart';
import '../product/product_card.dart';

class grid_product extends StatefulWidget {
  const grid_product({Key key, this.product}) : super(key: key);
  final List<Product> product;

  @override
  _grid_productState createState() => _grid_productState();
}

class _grid_productState extends State<grid_product> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return ResponsiveGridList(
        desiredItemWidth: 150,
        minSpacing: 10,
        //rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
        scroll: false,
    children: widget.product.map((e) =>Padding(
      padding: const EdgeInsets.all(2.0),
      child: ProductCard(
        themeColor: themeColor,
        product: e,
      ),
    )).toList()
    );
  }
}
