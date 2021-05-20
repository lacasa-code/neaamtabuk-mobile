import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/SearchOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/widget/slider/Banner.dart';
import 'package:flutter_pos/widget/slider/slider_dot.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  int _carouselCurrentPage = 0;
  int dropdownValue = 1;

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: themeColor.getColor(),
              padding: const EdgeInsets.only(top: 35, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Center(
                  //   child: Image.asset(
                  //     'assets/images/logo.png',
                  //     height: ScreenUtil.getHeight(context) / 10,
                  //     width: ScreenUtil.getWidth(context) / 3,
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                    ),
                    color: Color(0xffE4E4E4),
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
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "${widget.product.name}",
                style: TextStyle(fontSize: 22),
              ),
            ),
            CarouselSlider(
              items: widget.product.photo
                  .map((item) => Banner_item(
                        item: item.image,
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
            SliderDot(_carouselCurrentPage, widget.product.photo),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "${widget.product.price} ريال ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(child: SizedBox(height: 10)),
                  Row(
                    children: [
                      RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: double.parse('3.5'),
                        itemSize: 25.0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 1,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(
                        "3.5/5 ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),

                    ],
                  ),
                  SizedBox(width: 20)

                ],
              ),
            ),
            Row(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "العلامة التجارية : ",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${widget.product.carMadeName}',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                        ],
                      ),
                    )),
                Expanded(child: SizedBox(height: 10)),
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "بلد المنشأ : ",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${widget.product.origincountryName}',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                        ],
                      ),
                    )),
                SizedBox(width: 10)
              ],
            ),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "البائع : ",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${widget.product.vendorName}',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                    ],
                  ),
                )),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "المحرك : ",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${widget.product.transmissionName}',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                    ],
                  ),
                )),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,size: 20,),
                      Text(
                        '   ${widget.product.categoryName}',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                    ],
                  ),
                )),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,size: 20,),
                      Text(
                        '   ${widget.product.partCategoryName}',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                    ],
                  ),
                )),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,size: 20,),
                      Text(
                        '   ${widget.product.cartypeName}',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                    ],
                  ),
                )),
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
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87) ,
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
                )) ,
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.money,size: 20,),
                      Text(
                        ' خيارات الدفع ',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/Companies - MasterCard.png",width: 70,),
                  Image.asset("assets/images/Companies - Visa.png",width: 70,),
                  SvgPicture.asset("assets/icons/Path 1715.svg",width: 70,),
                ],
              ),
            ),
            SizedBox(height: 25,)

          ],
        ),
      ),
    );
  }
}
