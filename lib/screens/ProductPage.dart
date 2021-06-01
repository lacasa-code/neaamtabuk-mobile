import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/Quastions.dart';
import 'package:flutter_pos/screens/ratepage.dart';
import 'package:flutter_pos/screens/writeQuastions.dart';
import 'package:flutter_pos/screens/writerate.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/widget/slider/Banner.dart';
import 'package:flutter_pos/widget/slider/slider_dot.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'MyCars/myCars.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key key, this.product}) : super(key: key);
  final Product product;

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
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(themeColor.getCar_made(),style: TextStyle(
                            color: Colors.white
                        ),)
                      ],
                    ),
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
                  InkWell(
                    onTap: (){
                      API(context).post('user/add/wishlist',{
                        "product_id":widget.product.id
                      }).then((value) {
                        if (value != null) {
                          if (value['status_code'] == 200) {
                            setState(() {
                              widget.product.inWishlist="1";

                            });
                            showDialog(
                                context: context,
                                builder: (_) => ResultOverlay(
                                    value['message']));
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) => ResultOverlay(
                                    value['message']));
                          }
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Icon(widget.product.inWishlist==0?
                        Icons.favorite_border:Icons.favorite, size: 30, color: Colors.grey),
                        Text(
                          'أضف للمفضلة',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ],
                    ),
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
                widget.product.quantity>=1?  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline_sharp,
                        size: 30,
                        color: Colors.lightGreen,
                      ),
                      Text(
                        ' متوفر ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen,
                        ),
                      ),
                    ],
                  )
                 : Row(
                    children: [
                      Icon(
                        Icons.remove_circle_outline,
                        size: 30,
                        color: Colors.red,
                      ),
                      Text(
                        ' غير متوفر ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
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
                    items: <int>[1, 2, 3, 4, 5,6,7,8,9,10]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text("$value"),
                      );
                    }).toList(),
                  ),
                ),

                InkWell(onTap: (){
                  API(context).post('add/to/cart',{
                    "product_id":widget.product.id,
                    "quantity":dropdownValue
                  }).then((value) {
                    if (value != null) {
                      if (value['status_code'] == 200) {
                        showDialog(
                            context: context,
                            builder: (_) => ResultOverlay(
                                value['message']));
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) => ResultOverlay(
                                value['message']));
                      }
                    }
                  });
                },
                  child: Container(
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
                        Icons.local_shipping_outlined,size: 20,),
                      Text(
                        ' الشحن بواسطة ',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                    ],
                  ),
                )),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'أراميكس. الوصول المتوقع: الخميس 29 مارس - الثلاثاء 3 ابريل',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                )) ,
            SizedBox(height: 25,) ,
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
              padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/Companies - MasterCard.png",width: 70,),
                  Image.asset("assets/images/Companies - Visa.png",width: 70,),
                  SvgPicture.asset("assets/icons/Path 1715.svg",width: 70,),
                ],
              ),
            ),
            Container(
        height: ScreenUtil.getHeight(context)/1,
        width: ScreenUtil.getWidth(context),
        child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(

              backgroundColor: Colors.white,
              bottom: TabBar(
                tabs: [
                  Tab(icon: Text("التقييمات",)),
                  Tab(icon: Text("أسئلة وأجوبة")),
                ],
                indicatorColor: Colors.orange,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.orange,
              ),
            ),
          ),
          body: TabBarView(
            children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
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
                      Text(
                        " (15 تقييم ) ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 25),
                  ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: double.parse('3.5'),
                            itemSize: 25.0,
                            minRating: 5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          Text(
                            'منتج جيد الصناعة ويعتمد عليه أنصح به',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                          Text(
                            '25-6-2020 بواسطة أحمد',
                            style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey),
                          ),
                          Container(height: 1,color: Colors.grey,)
                        ],
                      ),

                    );
                  },
          ),
                  SizedBox(height: 25,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => Ratedialog());
                        },
                        child: Container(
                          width: ScreenUtil.getWidth(context)/2.5,
                          //  margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:  Colors.grey
                              )),
                          child: Container(
                            width: ScreenUtil.getWidth(context)/4,
                            child: Center(
                              child: AutoSizeText(
                                "جميع التقييمات",
                                maxFontSize: 16,
                                minFontSize: 10,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => WriteRatedialog());
                        },
                        child: Container(
                          width: ScreenUtil.getWidth(context)/2.5,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:  Colors.grey
                              )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit_outlined,color: Colors.black,),
                              SizedBox(width: 5,),
                              Container(
                                width: ScreenUtil.getWidth(context)/4,
                                child: AutoSizeText(
                                  'كتابة تقييم',
                                  overflow: TextOverflow.ellipsis,
                                  maxFontSize: 14,
                                  maxLines: 1,
                                  minFontSize: 10,
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/User Icon.svg',color: Colors.grey,height: 35,),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: ScreenUtil.getWidth(context)/1.4,
                                        child: Text(
                                          'هل المنتج متوافق مع كامري 2014 ؟',
                                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        '25-6-2020 بواسطة أحمد',
                                        style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Row(
                                children: [
                                  Icon(Icons.message_outlined,color: Colors.grey,size: 35,),
                                  SizedBox(width: 10,),
                                  Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: ScreenUtil.getWidth(context)/1.6,
                                          child: Text(
                                            'نعم المنتج متوافق مع الموديل يجب التأكد من التركيب بشكل سليم في مركز معتمد لتجنب التلفيات اثناء تركيب المنتج',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                          ),
                                        ),
                                        Text(
                                          '25-6-2020 بواسطة أحمد',
                                          style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(height: 1,color: Colors.grey,)
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 25,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => Qeastionsdialog());
                          },
                          child: Container(
                            width: ScreenUtil.getWidth(context)/2.5,
                            //  margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:  Colors.grey
                                )),
                            child: Container(
                              width: ScreenUtil.getWidth(context)/4,
                              child: Center(
                                child: AutoSizeText(
                                  "جميع الأسئلة",
                                  maxFontSize: 16,
                                  minFontSize: 10,
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => WriteQuastionsdialog());
                          },
                          child: Container(
                            width: ScreenUtil.getWidth(context)/2.5,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:  Colors.grey
                                )),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit_outlined,color: Colors.black,),
                                SizedBox(width: 5,),
                                Container(
                                  width: ScreenUtil.getWidth(context)/4,
                                  child: AutoSizeText(
                                    'كتابة سؤال',
                                    overflow: TextOverflow.ellipsis,
                                    maxFontSize: 14,
                                    maxLines: 1,
                                    minFontSize: 10,
                                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
    ),
      )
          ],
        ),
      ),
    );
  }
}
