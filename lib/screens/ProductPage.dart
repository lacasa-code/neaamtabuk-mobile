import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/question_model.dart';
import 'package:flutter_pos/model/review.dart';
import 'package:flutter_pos/screens/Quastions.dart';
import 'package:flutter_pos/screens/ratepage.dart';
import 'package:flutter_pos/screens/writeQuastions.dart';
import 'package:flutter_pos/screens/writerate.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:share/share.dart';
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
  Reviews reviews;
  List<Question> _question;
  String dropdownValue = "1";
  final _formKey = GlobalKey<FormState>();
  List<String> items = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "other",
  ];

  @override
  void initState() {
    getreview();
    getQuastion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final ServiceData = Provider.of<Provider_Data>(context);
    return Scaffold(
      body: Column(
        children: [
          AppBarCustom(
            isback: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "${widget.product.name}",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  CarouselSlider(
                    items: widget.product.photo
                        .map((item) => CachedNetworkImage(
                              imageUrl: item.image,
                              fit: BoxFit.contain,
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
                          onTap: () {
                            widget.product.inWishlist == "0"
                                ? API(context).post('user/add/wishlist', {
                                    "product_id": widget.product.id
                                  }).then((value) {
                                    if (value != null) {
                                      if (value['status_code'] == 200) {
                                        setState(() {
                                          widget.product.inWishlist = "1";
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
                                  })
                                : API(context).post(
                                    'user/removeitem/wishlist', {
                                    "product_id": widget.product.id
                                  }).then((value) {
                                    if (value != null) {
                                      if (value['status_code'] == 200) {
                                        setState(() {
                                          widget.product.inWishlist = "0";
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
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                  widget.product.inWishlist == "0"
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  size: 25,
                                  color: Colors.grey),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: ScreenUtil.getWidth(context) / 4,
                                child: Text(
                                  getTransrlate(context, 'AddFavorit'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Share.share(
                                'https://trkar-frontend-5lqqa.ondigitalocean.app/product-details/${widget.product.id}',
                                subject: 'Trkar');
                          },
                          child: Row(
                            children: [
                              Icon(Icons.share_outlined,
                                  size: 25, color: Colors.grey),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: ScreenUtil.getWidth(context) / 4,
                                child: Text(
                                  getTransrlate(context, 'share'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: ScreenUtil.getWidth(context) / 4,
                          child: widget.product.quantity >= 1
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline_sharp,
                                      size: 25,
                                      color: Colors.lightGreen,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      getTransrlate(context, 'available'),
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
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "${widget.product.price} ${getTransrlate(context, 'Currency')} ",
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
                                  "${getTransrlate(context, 'brand')} : ",
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '${widget.product.carMadeName}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
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
                                  "${getTransrlate(context, 'carmade')} : ",
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '${widget.product.origincountryName}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
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
                              "${getTransrlate(context, 'saller')} : ",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '${widget.product.vendorName}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
                              "${getTransrlate(context, 'auto')} : ",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '${widget.product.transmissionName}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
                              Icons.circle,
                              size: 15,
                            ),
                            Text(
                              '   ${widget.product.categoryName}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
                              Icons.circle,
                              size: 15,
                            ),
                            Text(
                              '   ${widget.product.partCategoryName}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
                              Icons.circle,
                              size: 15,
                            ),
                            Text(
                              '   ${widget.product.cartypeName}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${getTransrlate(context, 'compatible')} : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'تويوتا كامري  2015 سيدان \nتويوتا كامري 2015 هاتشباك',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.local_shipping_outlined,
                              size: 20,
                            ),
                            Text(
                              "${getTransrlate(context, 'ShippingBy')} : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'أراميكس. الوصول المتوقع: الخميس 29 مارس - الثلاثاء 3 ابريل',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.money,
                              size: 20,
                            ),
                            Text(
                              getTransrlate(context, 'paymentsMethod'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/images/Companies - MasterCard.png",
                          width: 60,
                        ),
                        Image.asset(
                          "assets/images/Companies - Visa.png",
                          width: 60,
                        ),
                        SvgPicture.asset(
                          "assets/icons/Path 1715.svg",
                          width: 60,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: ScreenUtil.getHeight(context) / 2,
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
                                Tab(
                                    icon: Text(
                                  "التقييمات",
                                )),
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
                            reviews == null
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 5),
                                        reviews.avgValuations == null
                                            ? Container()
                                            : Row(
                                                children: [
                                                  RatingBar.builder(
                                                    ignoreGestures: true,
                                                    initialRating:
                                                        double.parse('3.5'),
                                                    itemSize: 25.0,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 1,
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.orange,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                  Text(
                                                    "${reviews.avgValuations ?? 0}/5 ",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.orange,
                                                    ),
                                                  ),
                                                  Text(
                                                    " (${reviews.reviewsCount} تقييم ) ",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        SizedBox(height: 5),
                                        ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              reviews.reviewsData.length <= 2
                                                  ? reviews.reviewsData.length
                                                  : 2,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RatingBar.builder(
                                                    ignoreGestures: true,
                                                    initialRating: reviews
                                                        .reviewsData[index].id
                                                        .toDouble(),
                                                    itemSize: 20.0,
                                                    minRating: 5,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.orange,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    reviews.reviewsData[index]
                                                        .bodyReview,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    '${reviews.reviewsData[index].createdAt} بواسطة ${reviews.reviewsData[index].userName}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                    height: 1,
                                                    color: Colors.black12,
                                                  ),
                                                  SizedBox(height: 10),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        reviews.reviewsData.isEmpty
                                            ? Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/reload.svg",
                                                      width:
                                                          ScreenUtil.getWidth(
                                                                  context) /
                                                              3,
                                                      color: Colors.black12,
                                                    ),
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Text(
                                                      getTransrlate(
                                                          context, 'EmptyRate'),
                                                      style: TextStyle(
                                                          color: Colors.black45,
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              Ratedialog(
                                                                  reviews,
                                                                  widget.product
                                                                      .id));
                                                    },
                                                    child: Container(
                                                      width:
                                                          ScreenUtil.getWidth(
                                                                  context) /
                                                              2.5,
                                                      //  margin: const EdgeInsets.all(10.0),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey)),
                                                      child: Container(
                                                        width:
                                                            ScreenUtil.getWidth(
                                                                    context) /
                                                                4,
                                                        child: Center(
                                                          child: AutoSizeText(
                                                            "جميع التقييمات",
                                                            maxFontSize: 16,
                                                            minFontSize: 10,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              WriteRatedialog(widget.product.id));
                                                    },
                                                    child: Container(
                                                      width:
                                                          ScreenUtil.getWidth(
                                                                  context) /
                                                              2.5,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey)),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.edit_outlined,
                                                            color: Colors.black,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                            width: ScreenUtil
                                                                    .getWidth(
                                                                        context) /
                                                                4,
                                                            child: AutoSizeText(
                                                              'كتابة تقييم',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxFontSize: 14,
                                                              maxLines: 1,
                                                              minFontSize: 10,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
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
                            _question == null
                                ? Container()
                                : _question.isEmpty
                                    ? Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/reload.svg",
                                              width:
                                                  ScreenUtil.getWidth(context) /
                                                      3,
                                              color: Colors.black12,
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Text(
                                              getTransrlate(
                                                  context, 'EmptyQuastion'),
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 25),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            ListView.builder(
                                              primary: false,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: 1,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/icons/User Icon.svg',
                                                            color: Colors.grey,
                                                            height: 35,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: ScreenUtil
                                                                        .getWidth(
                                                                            context) /
                                                                    1.4,
                                                                child: Text(
                                                                  '${_question[index].bodyQuestion}',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                '${_question[index].createdAt} بواسطة ${_question[index].userName}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    _question[index].answer ==
                                                            null
                                                        ? Container()
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(25.0),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .message_outlined,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 35,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Center(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width: ScreenUtil.getWidth(context) /
                                                                            1.6,
                                                                        child:
                                                                            Text(
                                                                          '${_question[index].answer ?? ''}',
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              1,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        '${_question[index].updatedAt} بواسطة ${_question[index].vendor.vendorName}',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: Colors.grey),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
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
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            Qeastionsdialog(
                                                                _question,
                                                                widget.product
                                                                    .id));
                                                  },
                                                  child: Container(
                                                    width: ScreenUtil.getWidth(
                                                            context) /
                                                        2.5,
                                                    //  margin: const EdgeInsets.all(10.0),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.grey)),
                                                    child: Container(
                                                      width:
                                                          ScreenUtil.getWidth(
                                                                  context) /
                                                              4,
                                                      child: Center(
                                                        child: AutoSizeText(
                                                          "جميع الأسئلة",
                                                          maxFontSize: 16,
                                                          minFontSize: 10,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            WriteQuastionsdialog(
                                                                widget.product
                                                                    .id));
                                                  },
                                                  child: Container(
                                                    width: ScreenUtil.getWidth(
                                                            context) /
                                                        2.5,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.grey)),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.edit_outlined,
                                                          color: Colors.black,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Container(
                                                          width: ScreenUtil
                                                                  .getWidth(
                                                                      context) /
                                                              4,
                                                          child: AutoSizeText(
                                                            'كتابة سؤال',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxFontSize: 14,
                                                            maxLines: 1,
                                                            minFontSize: 10,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
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
          ),
          Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black26)),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("${getTransrlate(context, 'quantity')} :"),
                  dropdownValue == 'other'
                      ? Container(
                          width: 100,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 12),
                          padding: const EdgeInsets.all(3.0),
                          child: MyTextFormField(
                            istitle: true,
                            intialLabel: '',
                            keyboard_type: TextInputType.number,
                            labelText: getTransrlate(context, 'quantity'),
                            hintText: getTransrlate(context, 'quantity'),
                            isPhone: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "كمية";
                              }
                              _formKey.currentState.save();
                              return null;
                            },
                            onSaved: (String value) {
                              dropdownValue = value;
                            },
                          ),
                        )
                      : items == null
                          ? Container()
                          : items.isEmpty
                              ? Container()
                              : dropdownValue == null
                                  ? Container()
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 2),
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12)),
                                      child: DropdownButton<String>(
                                        value: dropdownValue,
                                        icon: const Icon(
                                            Icons.arrow_drop_down_outlined),
                                        iconSize: 24,
                                        elevation: 16,
                                        underline: Container(),
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownValue = newValue;
                                          });
                                        },
                                        items: items
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text("$value"),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        API(context).post('add/to/cart', {
                          "product_id": widget.product.id,
                          "quantity": dropdownValue
                        }).then((value) {
                          if (value != null) {
                            if (value['status_code'] == 200) {
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      ResultOverlay(value['message']));
                              setState(() {
                                dropdownValue = "1";
                              });
                              ServiceData.getCart(context);
                            } else {
                              setState(() {
                                dropdownValue = "1";
                              });
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      ResultOverlay(value['message']));
                            }
                          }
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 1),
                      padding: const EdgeInsets.all(12.0),
                      color: Colors.lightGreen,
                      child: Center(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.cart,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            getTransrlate(context, 'ADDtoCart'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void getreview() {
    API(context).get('home/review/product/${widget.product.id}').then((value) {
      setState(() {
        reviews = Review.fromJson(value).data;
      });
    });
  }

  void getQuastion() {
    API(context).get('prod/all/questions/${widget.product.id}').then((value) {
      setState(() {
        _question = Question_model.fromJson(value).data;
      });
    });
  }
}
