import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../model/product_model.dart';
import '../../utils/Provider/provider.dart';
import '../product/product_card.dart';

class grid_product extends StatefulWidget {
  const grid_product({Key key, this.product}) : super(key: key);
  final List<Products> product;

  @override
  _grid_productState createState() => _grid_productState();
}

class _grid_productState extends State<grid_product> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.77,
        crossAxisCount: 2,
      ),
      itemCount: widget.product.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ProductCard(
            themeColor: themeColor,
            product: widget.product[index],
          ),
        );
      },
    );
  }
}
