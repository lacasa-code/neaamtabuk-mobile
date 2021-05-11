import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/SearchOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/slider/Banner.dart';
import 'package:flutter_pos/widget/slider/slider_dot.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'myCars.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key key, this.product}) : super(key: key);
  final Products product;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final sliders = [
    'https://cdn-sharing.adobecc.com/content/storage/id/urn:aaid:sc:US:642cddc5-5583-433a-92cc-56baee945e76;revision=0?component_id=d4ec3884-325d-4605-bc3d-2b87ff1a77d6&api_key=CometServer1&access_token=1620761554_urn%3Aaaid%3Asc%3AUS%3A642cddc5-5583-433a-92cc-56baee945e76%3Bpublic_e75e5faa4055f5a2bb56145a3f67e47e57936479',
    'https://cdn-sharing.adobecc.com/content/storage/id/urn:aaid:sc:US:642cddc5-5583-433a-92cc-56baee945e76;revision=0?component_id=0efbdc5f-d11e-4bd6-ac5b-4d12c3a78d0b&api_key=CometServer1&access_token=1620761554_urn%3Aaaid%3Asc%3AUS%3A642cddc5-5583-433a-92cc-56baee945e76%3Bpublic_e75e5faa4055f5a2bb56145a3f67e47e57936479',
    'https://cdn-sharing.adobecc.com/content/storage/id/urn:aaid:sc:US:642cddc5-5583-433a-92cc-56baee945e76;revision=0?component_id=996ae476-b356-4c68-b9d4-3d9b6b6e9416&api_key=CometServer1&access_token=1620676996_urn%3Aaaid%3Asc%3AUS%3A642cddc5-5583-433a-92cc-56baee945e76%3Bpublic_1c61409196c095dd29fd1e92f122a1deb24e63e9'
  ];
  int _carouselCurrentPage = 0;
  int dropdownValue = 1;

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      body: Container(
        child: Column(
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
                        Text('إختر المركبة')
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
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "${widget.product.name}",
                style: TextStyle(fontSize: 22),
              ),
            ),
            CarouselSlider(
              items: sliders
                  .map((item) => Banner_item(
                        item: item,
                      ))
                  .toList(),
              options: CarouselOptions(
                  autoPlay: true,
                  height: 175,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _carouselCurrentPage = index;
                    });
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            SliderDot(_carouselCurrentPage, sliders),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite_border, size: 30, color: Colors.grey),
                      Text(
                        'أضف للمفضلة',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.share_outlined, size: 30, color: Colors.grey),
                      Text(
                        'أرسل لصديق',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline_sharp,
                        size: 30,
                        color: Colors.lightGreen,
                      ),
                      Text(
                        'متوفر',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: DropdownButton<int>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (int newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <int>[1, 2, 3, 4, 5]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text("$value"),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(12.0),
                  color: Colors.lightGreen,
                  child: Center(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_sharp,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'أضف إلى عربة التسوق',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  )),
                ),
              ],
            ),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'متوافق مع',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'تويوتا كامري  2015 سيدان \nتويوتا كامري 2015 هاتشباك',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
