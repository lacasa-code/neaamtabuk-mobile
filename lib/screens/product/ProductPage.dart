import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pos/model/question_model.dart';
import 'package:flutter_pos/model/review.dart';
import 'package:flutter_pos/screens/product/photo.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/screens/product/Quastions.dart';
import 'package:flutter_pos/screens/product/ratepage.dart';
import 'package:flutter_pos/screens/product/writeQuastions.dart';
import 'package:flutter_pos/screens/product/writerate.dart';
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
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:intl/intl.dart' as intl;
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:share/share.dart';
import 'package:flutter_pos/widget/slider/slider_dot.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../MyCars/myCars.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key, this.product, this.product_id}) : super(key: key);
  Product product;
  final String product_id;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _carouselCurrentPage = 0;
  Reviews reviews;
  String Vendor;
  List<Question> _question;
  String dropdownValue = "1";
  final _formKey = GlobalKey<FormState>();
  bool wloading = false;
  bool loading = false;

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
    API(context).get('home/show/product/${widget.product_id}').then((value) {
      print(value);
      setState(() {
        widget.product = Product.fromJson(value['data']);
        widget.product.noOfOrders == null
            ? dropdownValue = '1'
            : dropdownValue = 'other';
      });
    });
    widget.product == null
        ? null
        : widget.product.producttypeId != 2
            ? dropdownValue = '1'
            : dropdownValue = 'other';

    SharedPreferences.getInstance().then((value) {
      setState(() {
        Vendor = value.getString('vendor');
      });
    });
    getreview();
    getQuastion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final ServiceData = Provider.of<Provider_Data>(context);
    return Scaffold(
      body: widget.product == null
          ? Center(child: Custom_Loading())
          : Column(
              children: [
                AppBarCustom(
                  isback: true,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        widget.product.producttypeId != 2
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xffF2E964),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "${getTransrlate(context, 'wholesale')} : ${widget.product.noOfOrders ?? ' '} ${getTransrlate(context, 'piece')} ",
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11),
                                    ),
                                  ),
                                )),
                        ResponsiveGridList(
                          maxItemsPerRow: 10,
                        horizontalGridSpacing: 1, // Vertical space between grid items
                        horizontalGridMargin: 10, // Horizontal space around the grid
                        verticalGridMargin: 10,
                       verticalGridSpacing: 10,
                        minItemWidth: ScreenUtil.getWidth(context)/4, // The minimum item width (can be smaller, if the layout constraints are smaller)maxItemsPerRow, // The maximum items to show in a single row. Can be useful on large screens
                        shrinkWrap: true, // shrinkWrap property of the ListView.builder()
                          children: widget.product.allcategory
                              .map((e) => InkWell(
                            onTap: () {
                              Nav.route(
                                  context,
                                  Products_Page(
                                    id: widget.product.id,
                                    name:
                                    "${themeColor.getlocal() == 'ar' ? e.name ?? e.nameEn : e.nameEn ?? e.name}",
                                    Url:
                                    'ahmed/allcategories/products/${e.id}?cartype_id=${themeColor.car_type}',
                                    Istryers:
                                    e.id == 1711 || e.id == 682,
                                    Category: true,
                                    Category_id: e.id,
                                  ));
                            },
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  children: [
                                    Container(
                                      width: ScreenUtil.getWidth(context)/4.5,
                                      child: Text(
                                        "  ${themeColor.getlocal() == 'ar' ? e.name ?? e.nameEn : e.nameEn ?? e.name}",
                                        maxLines: 2,
                                        textDirection:
                                        TextDirection.ltr,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight:
                                            FontWeight.w300,
                                            color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    widget.product.allcategory.last
                                        .id ==
                                        e.id
                                        ? Container()
                                        : Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                      color: Colors.black45,
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                  ],
                                )),
                          ))
                              .toList(),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        //   child: Row(
                        //     children: widget.product.allcategory
                        //         .map((e) => InkWell(
                        //               onTap: () {
                        //                 Nav.route(
                        //                     context,
                        //                     Products_Page(
                        //                       id: widget.product.id,
                        //                       name:
                        //                           "${themeColor.getlocal() == 'ar' ? e.name ?? e.nameEn : e.nameEn ?? e.name}",
                        //                       Url:
                        //                           'ahmed/allcategories/products/${e.id}?cartype_id=${themeColor.car_type}',
                        //                       Istryers:
                        //                           e.id == 1711 || e.id == 682,
                        //                       Category: true,
                        //                       Category_id: e.id,
                        //                     ));
                        //               },
                        //               child: Align(
                        //                   alignment: Alignment.topRight,
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.symmetric(
                        //                         horizontal: 1.0),
                        //                     child: Row(
                        //                       children: [
                        //                         Text(
                        //                           "  ${themeColor.getlocal() == 'ar' ? e.name ?? e.nameEn : e.nameEn ?? e.name}",
                        //                           maxLines: 2,
                        //                           textDirection:
                        //                               TextDirection.ltr,
                        //                           style: TextStyle(
                        //                               fontSize: 12,
                        //                               fontWeight:
                        //                                   FontWeight.w300,
                        //                               color: Colors.black),
                        //                         ),
                        //                         SizedBox(
                        //                           width: 10,
                        //                         ),
                        //                         widget.product.allcategory.last
                        //                                     .id ==
                        //                                 e.id
                        //                             ? Container()
                        //                             : Icon(
                        //                                 Icons.arrow_forward_ios,
                        //                                 size: 12,
                        //                                 color: Colors.black45,
                        //                               ),
                        //                         SizedBox(
                        //                           width: 10,
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   )),
                        //             ))
                        //         .toList(),
                        //   ),
                        // ),
                        // Align(
                        //     alignment: Alignment.topRight,
                        //     child: Padding(
                        //       padding: const EdgeInsets.symmetric( horizontal: 1.0),
                        //       child: Text(
                        //         '${themeColor.getlocal()=='ar'? widget.product.name??widget.product.nameEN:widget.product.nameEN??widget.product.name}',
                        //         maxLines: 1,
                        //         textDirection: TextDirection.ltr,
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w300,
                        //             color: Colors.orange),
                        //       ),
                        //     )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          child: Text(
                            "${themeColor.getlocal() == 'ar' ? widget.product.name ?? widget.product.nameEN : widget.product.nameEN ?? widget.product.name}",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Nav.route(
                                context,
                                Photo_Slider(
                                  title:
                                      "${themeColor.getlocal() == 'ar' ? widget.product.name ?? widget.product.nameEN : widget.product.nameEN ?? widget.product.name}",
                                  photos: widget.product.photo,
                                ));
                          },
                          child: CarouselSlider(
                            items: widget.product.photo
                                .map((item) => CachedNetworkImage(
                                      imageUrl: item.image,
                                      fit: BoxFit.contain,
                                    ))
                                .toList(),
                            options: CarouselOptions(
                                autoPlay: true,
                                height: ScreenUtil.getHeight(context) / 6,
                                viewportFraction: 1.0,
                                enlargeCenterPage: false,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _carouselCurrentPage = index;
                                  });
                                }),
                          ),
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
                              wloading
                                  ? Container(
                                      width: ScreenUtil.getWidth(context) / 4,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.orange),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() => wloading = true);

                                        widget.product.inWishlist == 0
                                            ? API(context).post(
                                                'user/add/wishlist', {
                                                "product_id": widget.product_id
                                              }).then((value) {
                                                if (value != null) {
                                                  setState(
                                                      () => wloading = false);

                                                  if (value['status_code'] ==
                                                      200) {
                                                    ServiceData.getWishlist(
                                                        context);
                                                    setState(() {
                                                      widget.product
                                                          .inWishlist = 1;
                                                    });
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            ResultOverlay(value[
                                                                'message']));
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            ResultOverlay(value[
                                                                    'data'] ??
                                                                value[
                                                                    'errors'] ??
                                                                value[
                                                                    'message']));
                                                  }
                                                }
                                              })
                                            : API(context).post(
                                                'user/removeitem/wishlist', {
                                                "product_id": widget.product_id
                                              }).then((value) {
                                                setState(
                                                    () => wloading = false);

                                                print(value);
                                                if (value != null) {
                                                  if (value['status_code'] ==
                                                      200) {
                                                    ServiceData.getWishlist(
                                                        context);

                                                    setState(() {
                                                      widget.product
                                                          .inWishlist = 0;
                                                    });
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            ResultOverlay(value[
                                                                'message']));
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            ResultOverlay(value[
                                                                    'message'] ??
                                                                ''));
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
                                              widget.product.inWishlist == 0
                                                  ? Icons.favorite_border
                                                  : Icons.favorite,
                                              size: 25,
                                              color: Colors.grey),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            width:
                                                ScreenUtil.getWidth(context) /
                                                    4,
                                            child: Text(
                                              getTransrlate(
                                                  context, 'AddFavorit'),
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
                                      'https://trkar-frontend-5lqqa.ondigitalocean.app/product-details/${widget.product_id}',
                                      subject: 'Trkar');
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.share_outlined,
                                        size: 20, color: Colors.grey),
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
                                child: widget.product.producttypeId == 2
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
                                    : widget.product.quantity >= 1
                                        ? Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .check_circle_outline_sharp,
                                                size: 25,
                                                color: Colors.lightGreen,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                getTransrlate(
                                                    context, 'available'),
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
                                                Icons.cancel_outlined,
                                                size: 30,
                                                color: Colors.red,
                                              ),
                                              Text(
                                                '${getTransrlate(context, 'available')}',
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
                              widget.product.producttypeId == 2
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${getTransrlate(context, 'wholesalePrice')}  : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              '${widget.product.holesalePrice ?? ' '} ${getTransrlate(context, 'Currency')} ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${getTransrlate(context, 'minOfOrder')}  : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              '${widget.product.noOfOrders ?? ' '} ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          "${widget.product.price} ${getTransrlate(context, 'Currency')} ",
                                          style: TextStyle(
                                            fontSize: 17,
                                            decoration:
                                                widget.product.discount != "0"
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        widget.product.discount == "0"
                                            ? Container()
                                            : Text(
                                                "${widget.product.action_price.floorToDouble()} ${getTransrlate(context, 'Currency')} ",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )
                                      ],
                                    ),
                              Expanded(child: SizedBox(height: 10)),
                              Row(
                                children: [
                                  reviews == null
                                      ? Container()
                                      : RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating: double.parse(
                                              "${reviews.avgValuations ?? '0'}"),
                                          itemSize: 25.0,
                                          minRating: 0.5,
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
                                  reviews == null
                                      ? Container()
                                      : Text(
                                          "${reviews.avgValuations ?? '0'}/5 ",
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
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "${getTransrlate(context, 'manufacturer')} : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    '${widget.product.manufacturerName ?? '${getTransrlate(context, 'NoSelect')}'}',
                                    maxLines: 1,
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
                                    "${getTransrlate(context, 'carmade')} : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
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
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "${getTransrlate(context, 'saller')} : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    '${widget.product.vendorSerial}',
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
                                    "${getTransrlate(context, 'Productsaller')} : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Nav.route(
                                          context,
                                          Products_Page(
                                            name: widget.product.vendorSerial,
                                            id: widget.product.vendorId,
                                            Url:
                                                'ahmed/vendor/products/${widget.product.vendorId}?cartype_id=${themeColor.getcar_type()}&',
                                            Istryers: false,
                                          ));
                                    },
                                    child: Text(
                                      '${widget.product.vendorSerial}',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        widget.product.tyres_belong == 1
                            ? Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        " ${getTransrlate(context, 'tayars')} :",
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "${widget.product.width ?? ''}/ ${widget.product.height ?? ''}/ ${widget.product.size ?? ''}",
                                        maxLines: 1,
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ))
                            : Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "${getTransrlate(context, 'compatible')} ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      )),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${widget.product.carMadeName == null ? '' : themeColor.getlocal() == 'ar' ? widget.product.carMadeName.carMade ?? widget.product.carMadeName.name_en : widget.product.carMadeName.name_en ?? widget.product.carMadeName.carMade} , ${widget.product.carModelName == null ? '' : widget.product.carModelName.map((e) => "${themeColor.getlocal() == 'ar' ? e.carmodel ?? e.name_en : e.name_en ?? e.carmodel} ${widget.product.carModelName.last.id == e.id ? '' : '/'}").toList().toString().replaceAll('[', '').replaceAll(']', '')} ${widget.product.yearFrom == null ? '' : "( ${widget.product.yearFrom.year} - "}${widget.product.yearTo == null ? '' : "${widget.product.yearTo.year} ) "},${widget.product.transmissionName ?? ''}',
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      )),
                                ],
                              ),
                        // Align(
                        //     alignment: Alignment.topRight,
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Row(
                        //         children: [
                        //           Icon(
                        //             Icons.circle,
                        //             size: 15,
                        //           ),
                        //           Text(
                        //             '   ${widget.product.categoryName.runtimeType == String ? widget.product.categoryName : widget.product.categoryName.name}',
                        //             style: TextStyle(
                        //                 fontWeight: FontWeight.bold,
                        //                 color: Colors.black),
                        //           ),
                        //         ],
                        //       ),
                        //     )),
                        // Align(
                        //     alignment: Alignment.topRight,
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Row(
                        //         children: [
                        //           Icon(
                        //             Icons.circle,
                        //             size: 15,
                        //           ),
                        //           Text(
                        //             '   ${widget.product.partCategoryName}',
                        //             style: TextStyle(
                        //                 fontWeight: FontWeight.bold,
                        //                 color: Colors.black),
                        //           ),
                        //         ],
                        //       ),
                        //     )),
                        // widget.product.cartypeName == null
                        //     ? Container()
                        //     : Align(
                        //     alignment: Alignment.topRight,
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Row(
                        //         children: [
                        //           Icon(
                        //             Icons.circle,
                        //             size: 15,
                        //           ),
                        //           Text(
                        //             '   ${widget.product.cartypeName}',
                        //             style: TextStyle(
                        //                 fontWeight: FontWeight.bold,
                        //                 color: Colors.black),
                        //           ),
                        //         ],
                        //       ),
                        //     )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${themeColor.getlocal() == 'ar' ? widget.product.description ?? widget.product.description_en : widget.product.description_en ?? widget.product.description}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    height:
                                        1.5 //You can set your custom height here
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                color: Colors.black12,
                                width: ScreenUtil.getWidth(context),
                                height: 1,
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
                                  SizedBox(
                                    width: 5,
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
                                '${getTransrlate(context, 'shipingditils')} : ${intl.DateFormat(intl.DateFormat.ABBR_MONTH_DAY, '${themeColor.getlocal()}').format(DateTime.now().add(Duration(days: 3)))} - ${intl.DateFormat(intl.DateFormat.ABBR_MONTH_DAY, '${themeColor.getlocal()}').format(DateTime.now().add(Duration(days: 5)))}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            color: Colors.black12,
                            width: ScreenUtil.getWidth(context),
                            height: 1,
                          ),
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
                          padding: const EdgeInsets.only(
                              top: 8, left: 1, right: 1, bottom: 10),
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
                              Column(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/Path 1715.svg",
                                    width: 40,
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        getTransrlate(context, 'cod'),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            color: Colors.black12,
                            width: ScreenUtil.getWidth(context),
                            height: 1,
                          ),
                        ),

                        reviews == null
                            ? Custom_Loading()
                            : DefaultTabController(
                                length: 2,
                                child: ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.all(1),
                                  shrinkWrap: true,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      child: TabBar(
                                        tabs: [
                                          Tab(
                                              icon: Text(
                                            "${getTransrlate(context, 'Reviews')}",
                                          )),
                                          Tab(
                                              icon: Text(
                                                  "${getTransrlate(context, 'questions')}")),
                                        ],
                                        indicatorColor: Colors.orange,
                                        unselectedLabelColor: Colors.grey,
                                        labelColor: Colors.orange,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 300.0,
                                      child: TabBarView(
                                        children: [
                                          reviews == null
                                              ? Custom_Loading()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      reviews.avgValuations ==
                                                              null
                                                          ? Container()
                                                          : Row(
                                                              children: [
                                                                RatingBar
                                                                    .builder(
                                                                  ignoreGestures:
                                                                      true,
                                                                  initialRating:
                                                                      double.parse(
                                                                          '3.5'),
                                                                  itemSize:
                                                                      25.0,
                                                                  minRating:
                                                                      0.5,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  itemCount: 1,
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    print(
                                                                        rating);
                                                                  },
                                                                ),
                                                                Text(
                                                                  "${reviews.avgValuations ?? 0}/5 ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  " (${reviews.reviewsCount} ${getTransrlate(context, 'rate')} ) ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                      reviews.reviewsData
                                                              .isEmpty
                                                          ? Container(
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        20),
                                                                child: Column(
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                      "assets/icons/open-cardboard-box.svg",
                                                                      width:
                                                                          ScreenUtil.getWidth(context) /
                                                                              5,
                                                                      color: Colors
                                                                          .black12,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(getTransrlate(
                                                                        context,
                                                                        'EmptyRate')),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : ListView.builder(
                                                              primary: false,
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: reviews
                                                                          .reviewsData
                                                                          .length <=
                                                                      1
                                                                  ? reviews
                                                                      .reviewsData
                                                                      .length
                                                                  : 1,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      RatingBar
                                                                          .builder(
                                                                        ignoreGestures:
                                                                            true,
                                                                        initialRating: reviews
                                                                            .reviewsData[index]
                                                                            .evaluationValue
                                                                            .toDouble(),
                                                                        itemSize:
                                                                            20.0,
                                                                        minRating:
                                                                            0.5,
                                                                        direction:
                                                                            Axis.horizontal,
                                                                        allowHalfRating:
                                                                            true,
                                                                        itemCount:
                                                                            5,
                                                                        itemBuilder:
                                                                            (context, _) =>
                                                                                Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.orange,
                                                                        ),
                                                                        onRatingUpdate:
                                                                            (rating) {
                                                                          print(
                                                                              rating);
                                                                        },
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              5),
                                                                      Text(
                                                                        reviews
                                                                            .reviewsData[index]
                                                                            .bodyReview,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: Colors.black),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              5),
                                                                      Text(
                                                                        '${reviews.reviewsData[index].createdAt} بواسطة ${reviews.reviewsData[index].userName}',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: Colors.grey),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              5),
                                                                      Container(
                                                                        height:
                                                                            1,
                                                                        color: Colors
                                                                            .black12,
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              5),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (_) =>
                                                                      Ratedialog(
                                                                          reviews,
                                                                          widget
                                                                              .product
                                                                              .id)).then(
                                                                  (value) =>
                                                                      getreview());
                                                            },
                                                            child: Container(
                                                              width: ScreenUtil
                                                                      .getWidth(
                                                                          context) /
                                                                  2.5,
                                                              //  margin: const EdgeInsets.all(10.0),
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey)),
                                                              child: Container(
                                                                width: ScreenUtil
                                                                        .getWidth(
                                                                            context) /
                                                                    4,
                                                                child: Center(
                                                                  child:
                                                                      AutoSizeText(
                                                                    '${getTransrlate(context, 'allrate')}',
                                                                    maxFontSize:
                                                                        16,
                                                                    minFontSize:
                                                                        10,
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
                                                                  context:
                                                                      context,
                                                                  builder: (_) =>
                                                                      WriteRatedialog(widget
                                                                          .product
                                                                          .id)).then(
                                                                  (value) =>
                                                                      getreview());
                                                            },
                                                            child: Container(
                                                              width: ScreenUtil
                                                                      .getWidth(
                                                                          context) /
                                                                  2.5,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey)),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .edit_outlined,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Container(
                                                                    width: ScreenUtil.getWidth(
                                                                            context) /
                                                                        5,
                                                                    child:
                                                                        AutoSizeText(
                                                                      '${getTransrlate(context, 'writerate')}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxFontSize:
                                                                          14,
                                                                      maxLines:
                                                                          1,
                                                                      minFontSize:
                                                                          10,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.black),
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
                                              ? Custom_Loading()
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    _question.isEmpty
                                                        ? Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          10),
                                                              child: Column(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    "assets/icons/open-cardboard-box.svg",
                                                                    width: ScreenUtil.getWidth(
                                                                            context) /
                                                                        5,
                                                                    color: Colors
                                                                        .black12,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(getTransrlate(
                                                                      context,
                                                                      'EmptyQuastion')),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(14.0),
                                                            child: Column(
                                                              children: [
                                                                _question
                                                                        .isEmpty
                                                                    ? Container(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(vertical: 20),
                                                                          child: Text(getTransrlate(
                                                                              context,
                                                                              'EmptyRate')),
                                                                        ),
                                                                      )
                                                                    : ListView
                                                                        .builder(
                                                                        primary:
                                                                            false,
                                                                        shrinkWrap:
                                                                            true,
                                                                        physics:
                                                                            NeverScrollableScrollPhysics(),
                                                                        itemCount:
                                                                            1,
                                                                        padding:
                                                                            EdgeInsets.all(1),
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
                                                                                padding: const EdgeInsets.all(10.0),
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
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: ScreenUtil.getWidth(context) / 1.4,
                                                                                          child: Text(
                                                                                            '${_question[index].bodyQuestion}',
                                                                                            maxLines: 1,
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        Container(
                                                                                          width: ScreenUtil.getWidth(context) / 1.5,
                                                                                          child: Text(
                                                                                            '${_question[index].createdAt} بواسطة ${_question[index].userName}',
                                                                                            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              _question[index].answer == null
                                                                                  ? Container()
                                                                                  : Padding(
                                                                                      padding: const EdgeInsets.all(25.0),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.message_outlined,
                                                                                            color: Colors.grey,
                                                                                            size: 30,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 5,
                                                                                          ),
                                                                                          Center(
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: ScreenUtil.getWidth(context) / 1.6,
                                                                                                  child: Text(
                                                                                                    '${_question[index].answer ?? ''}',
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                    maxLines: 1,
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 10,
                                                                                                ),
                                                                                                Text(
                                                                                                  '${_question[index].updatedAt} بواسطة ${_question[index].vendor.vendorName}',
                                                                                                  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
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
                                                              ],
                                                            ),
                                                          ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (_) =>
                                                                    Qeastionsdialog(
                                                                        _question,
                                                                        widget
                                                                            .product
                                                                            .id)).then(
                                                                (value) =>
                                                                    getQuastion());
                                                          },
                                                          child: Container(
                                                            width: ScreenUtil
                                                                    .getWidth(
                                                                        context) /
                                                                2.5,
                                                            //  margin: const EdgeInsets.all(10.0),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child: Container(
                                                              width: ScreenUtil
                                                                      .getWidth(
                                                                          context) /
                                                                  4,
                                                              child: Center(
                                                                child:
                                                                    AutoSizeText(
                                                                  "${getTransrlate(context, 'allquestions')}",
                                                                  maxFontSize:
                                                                      16,
                                                                  minFontSize:
                                                                      10,
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
                                                                context:
                                                                    context,
                                                                builder: (_) =>
                                                                    WriteQuastionsdialog(widget
                                                                        .product
                                                                        .id)).then(
                                                                (value) =>
                                                                    getQuastion());
                                                          },
                                                          child: Container(
                                                            width: ScreenUtil
                                                                    .getWidth(
                                                                        context) /
                                                                2.5,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .edit_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  width: ScreenUtil
                                                                          .getWidth(
                                                                              context) /
                                                                      4,
                                                                  child:
                                                                      AutoSizeText(
                                                                    '${getTransrlate(context, 'writequestions')}',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxFontSize:
                                                                        14,
                                                                    maxLines: 1,
                                                                    minFontSize:
                                                                        10,
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
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                ),
                widget.product.cartEnable == 0
                    ? Container()
                    : Form(
                        key: _formKey,
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 5, bottom: 25, left: 2, right: 2),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: widget.product.inCart == 1
                                      ? Colors.white
                                      : Colors.black26)),
                          child: widget.product.inCart == 1
                              ? Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.lightGreen)),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 1),
                                  padding: const EdgeInsets.all(12.0),
                                  child: Center(
                                      child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        getTransrlate(context, 'foundCart'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.lightGreen),
                                      ),
                                    ],
                                  )),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "${getTransrlate(context, 'quantity')} :",
                                    ),
                                    dropdownValue == 'other'
                                        ? Container(
                                            width: 100,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 12),
                                            padding: const EdgeInsets.all(3.0),
                                            child: MyTextFormField(
                                              istitle: true,
                                              intialLabel:
                                                  "${widget.product.producttypeId == 2 ? widget.product.noOfOrders ?? '1' : '1'}",
                                              keyboard_type:
                                                  TextInputType.number,
                                              labelText: getTransrlate(
                                                  context, 'quantity'),
                                              hintText: getTransrlate(
                                                  context, 'quantity'),
                                              isPhone: true,
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return "${getTransrlate(context, 'quantity')}";
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
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 2,
                                                            vertical: 2),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black12)),
                                                        child: DropdownButton<
                                                            String>(
                                                          value: dropdownValue,
                                                          icon: const Icon(Icons
                                                              .arrow_drop_down_outlined),
                                                          iconSize: 24,
                                                          elevation: 16,
                                                          underline:
                                                              Container(),
                                                          style: const TextStyle(
                                                              height: 1,
                                                              color: Colors
                                                                  .deepPurple),
                                                          onChanged: (String
                                                              newValue) {
                                                            setState(() {
                                                              dropdownValue =
                                                                  newValue;
                                                            });
                                                          },
                                                          items: items.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Center(
                                                                  child: Text(
                                                                "$value",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              )),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                    loading
                                        ? CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.lightGreen),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _formKey.currentState.save();
                                                setState(() => loading = true);

                                                API(context)
                                                    .post('add/to/cart', {
                                                  "product_id":
                                                      widget.product_id,
                                                  "quantity":
                                                      dropdownValue == 'other'
                                                          ? 1
                                                          : dropdownValue
                                                }).then((value) {
                                                  setState(
                                                      () => loading = false);

                                                  if (value != null) {
                                                    if (value['status_code'] ==
                                                        200) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              ResultOverlay(
                                                                  value[
                                                                      'message'],
                                                                  icon: Icon(
                                                                    Icons
                                                                        .check_circle_outline,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 80,
                                                                  )));
                                                      setState(() {
                                                        dropdownValue = "1";
                                                        widget.product.inCart =
                                                            1;
                                                      });
                                                      ServiceData.getCart(
                                                          context);
                                                    } else {
                                                      setState(() {
                                                        dropdownValue = "1";
                                                      });
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              ResultOverlay(
                                                                  '${value['message'] ?? ''}\n${value['errors'] ?? ""}',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .info_outline,
                                                                    color: Colors
                                                                        .yellow,
                                                                    size: 80,
                                                                  )));
                                                    }
                                                  }
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: 50,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 1),
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              color: Colors.lightGreen,
                                              child: Center(
                                                  child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    CupertinoIcons.cart,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    getTransrlate(
                                                        context, 'ADDtoCart'),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
    API(context).get('home/review/product/${widget.product_id}').then((value) {
      setState(() {
        reviews = Review_model.fromJson(value).data;
      });
    });
  }

  void getQuastion() {
    API(context).get('prod/all/questions/${widget.product_id}').then((value) {
      setState(() {
        _question = Question_model.fromJson(value).data;
      });
    });
  }
}
