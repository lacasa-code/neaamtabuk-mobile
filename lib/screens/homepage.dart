import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/account/Account.dart';
import 'package:flutter_pos/screens/order/cart.dart';
import 'package:flutter_pos/screens/account/vendor_information.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/model/ads.dart';
import 'package:flutter_pos/model/car_type.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/product/category.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/category/category_card.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/product/product_card.dart';
import 'package:flutter_pos/widget/product/product_list_titlebar.dart';
import 'package:flutter_pos/widget/slider/Banner.dart';
import 'package:flutter_pos/widget/slider/slider_dotAds.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> product;
  List<Product> productMostView;
  List<Product> productMostSale;
  List<CarType> cartype;
  Ads ads;
  int checkboxType = 0;

  int complete;
  PersistentTabController _controller;
  final navigatorKey = GlobalKey<NavigatorState>();

  List<Widget> _buildScreens() {
    return [HomePage(), CategoryScreen(), Account(), CartScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final data = Provider.of<Provider_Data>(context);

    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("الرئيسية"),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.apps),
        title: (getTransrlate(context, 'category')),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.person,
          size: 35,
        ),
        title: (getTransrlate(context, 'MyProfile')),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Stack(
          children: [
            Center(child: Icon(CupertinoIcons.cart)),
            Center(
                child: Text(
              data.cart_model != null
                  ? " ${data.cart_model.data == null ? 0 : data.cart_model.data.count_pieces ?? 0} "
                  : '',
              style: TextStyle(
                  height: 1,
                  backgroundColor: Colors.white,
                  color: Colors.orange),
            )),
          ],
        ),
        iconSize: 35,
        title: (getTransrlate(context, 'Cart')),
        textStyle: TextStyle(height: 1),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);

    getData(1);
    API(context).get('car/types/list').then((value) {
      if (value != null) {
        setState(() {
          cartype = Car_type.fromJson(value).data;
        });
      }
    });

    SharedPreferences.getInstance().then((value) {
      complete = value.getInt('complete');
    });
    super.initState();
  }

  getData(int cartypeId) {
    API(context).get('site/ads/show/filter?cartype_id=$cartypeId&platform=mobile').then((value) {
    if (value != null) {
      setState(() {
        ads = Ads.fromJson(value['data']);
      });
    }
  });
    API(context, Check: false)
        .get('site/new/products?cartype_id=$cartypeId')
        .then((value) {
      if (value != null) {
        setState(() {
          product = Product_model.fromJson(value).data;
        });
      }
    });
    API(context)
        .get('mostly/viewed/products?cartype_id=$cartypeId')
        .then((value) {
      if (value != null) {
        setState(() {
          productMostView = Product_model.fromJson(value).data;
        });
      }
    });
    API(context)
        .get('best/seller/products?cartype_id=$cartypeId')
        .then((value) {
      if (value != null) {
        setState(() {
          productMostSale = Product_model.fromJson(value).data;
        });
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _carouselCurrentPage = 0;
  String pathImage;

  @override
  Widget build(BuildContext context) {
    final provider_Data = Provider.of<Provider_Data>(context);
    return Scaffold(
      key: _scaffoldKey,
      // drawer: HiddenMenu(),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarHeight: 60,
        margin: EdgeInsets.only(bottom: 10),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black12, width: 1),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        selectedTabScreenContext: (v) {
          if (_controller.index == 3) {
            provider_Data.getCart(context);
          }
        },
        popActionScreens: PopActionScreensType.once,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),

        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: false,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
    );
  }

  Widget HomePage() {
    final themeColor = Provider.of<Provider_control>(context);
    return Column(
      children: [
        AppBarCustom(),
        complete == 0
            ? Padding(
                padding: const EdgeInsets.only(top: 22, right: 22, left: 22),
                child: InkWell(
                  onTap: () {
                    Nav.route(context, VendorInfo());
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Attention.svg",
                        color: Colors.orange,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'حسابك كبائع حاليا غير مفعليرجى استكمال وإرسال البيانات التالية لتفعيل حسابك',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                cartype == null
                    ? Container()
                    : ResponsiveGridList(
                        desiredItemWidth: ScreenUtil.getWidth(context)/2.4,
                        minSpacing: 10,
                        rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        scroll: false,
                        children: cartype
                            .map((e) {
                          final selected=checkboxType==cartype.indexOf(e);
                         return InkWell(
                           onTap: () {
                             setState(() {
                               checkboxType = cartype.indexOf(e);
                               product = null;
                               productMostView = null;
                               productMostSale = null;
                             });
                             themeColor
                                 .setCar_type(e.id);
                             getData(e.id);
                           },
                           child: Container(
                             height:
                             ScreenUtil.getHeight(context) /
                                 7,
                            // width: ScreenUtil.getWidth(context) / 2.5,
                             decoration: BoxDecoration(
                               border: Border.all(
                                   width: 3.0,
                                   color: selected
                                       ? Colors.orange
                                       : Colors.black12),
                               image: DecorationImage(
                                   image: CachedNetworkImageProvider(
                                       "${e.image}"),
                                   fit: BoxFit.cover),
                               borderRadius: themeColor.local ==
                                   'ar'
                                   ? cartype.indexOf(e).isEven
                                   ? BorderRadius.only(
                                   topRight: Radius.circular(
                                       15.0),
                                   bottomRight:
                                   Radius.circular(
                                       15.0))
                                   : BorderRadius.only(
                                   topLeft: Radius.circular(
                                       15.0),
                                   bottomLeft:
                                   Radius.circular(
                                       15.0))
                                   : cartype.indexOf(e).isEven
                                   ? BorderRadius.only(
                                   topLeft: Radius.circular(
                                       15.0),
                                   bottomLeft:
                                   Radius.circular(
                                       15.0))
                                   : BorderRadius.only(
                                   topRight:
                                   Radius.circular(15.0),
                                   bottomRight: Radius.circular(15.0)),
                             ),
                             child: Align(
                               alignment: Alignment.bottomCenter,
                               child: Card(
                                 color: Colors.black12,
                                 child: Padding(
                                   padding:
                                   const EdgeInsets.all(4.0),
                                   child: AutoSizeText(
                                       e.typeName,
                                       maxLines: 1,
                                       maxFontSize: 18,
                                       minFontSize: 10,
                                       style: TextStyle(
                                           color: Colors.white,
                                           fontWeight:
                                           FontWeight.bold)),
                                 ),
                               ),
                             ),
                           ),
                         );
                        })
                            .toList()),
                ads == null
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: CarouselSlider(
                          items: ads.carousel
                              .map((item) => Banner_item(
                                    item: item.photo.image,
                                  ))
                              .toList(),
                          options: CarouselOptions(
                              height: ScreenUtil.getHeight(context) / 5,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              //onPageChanged: callbackFunction,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _carouselCurrentPage = index;
                                });
                              }),
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                ads == null
                    ? Container()
                    : SliderDotAds(_carouselCurrentPage, ads.carousel),
                productMostView == null
                    ? Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Custom_Loading(),
                      )
                    : Container(child: list_category(themeColor)),
                product == null
                    ? Container()
                    : product.isEmpty
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ProductListTitleBar(
                                themeColor: themeColor,
                                title: getTransrlate(context, 'offers'),
                                description: getTransrlate(context, 'showAll'),
                                url:
                                    'site/new/products?cartype_id=${cartype[checkboxType].id}',
                              ),
                              list_product(themeColor, product),
                            ],
                          ),
                ads == null
                    ? Container()
                    : ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: ads.middle.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Banner_item(item: ads.middle[index].photo.image),
                          );
                        },
                      ),
                productMostSale == null
                    ? Container()
                    : productMostSale.isEmpty
                        ? Container()
                        : Column(
                            children: [
                              ProductListTitleBar(
                                themeColor: themeColor,
                                title: getTransrlate(context, 'moresale'),
                                description: getTransrlate(context, 'showAll'),
                                url: 'best/seller/products?cartype_id=${cartype[checkboxType].id}',
                              ),
                              list_product(themeColor, productMostSale),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                ads == null
                    ? Container()
                    : ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: ads.bottom.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Banner_item(item: ads.bottom[index].photo.image),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget list_category(
    Provider_control themeColor,
  ) {
    return productMostView.isEmpty
        ? Container()
        : Center(
            child: ResponsiveGridList(
              scroll: false,
              desiredItemWidth: 100,
              rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
              minSpacing: 10,
              children: productMostView
                  .map((product) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: CategoryCard(
                          themeColor: themeColor,
                          product: product,
                          cartType: cartype[checkboxType].id,
                        ),
                      ))
                  .toList(),
            ),
          );
  }

  Widget list_product(Provider_control themeColor, List<Product> product) {
    return product.isEmpty
        ? Container()
        : ResponsiveGridList(
      scroll: false,
      desiredItemWidth: ScreenUtil.getWidth(context)/2.2,
      minSpacing: 10,
      children: product.map((e) => Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 16),
          child: ProductCard(
            themeColor: themeColor,
            product:e,
          ),
        ),
      )).toList(),
          );
  }
}
