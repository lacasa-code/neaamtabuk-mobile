import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/Account.dart';
import 'package:flutter_pos/screens/CarType/productCarType.dart';
import 'package:flutter_pos/screens/cart.dart';
import 'package:flutter_pos/screens/vendor_information.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/model/ads.dart';
import 'package:flutter_pos/model/car_type.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/category.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/category/category_card.dart';
import 'package:flutter_pos/widget/product/product_card.dart';
import 'package:flutter_pos/widget/product/product_list_titlebar.dart';
import 'package:flutter_pos/widget/slider/Banner.dart';
import 'package:flutter_pos/widget/slider/slider_dotAds.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> product;
  List<Product> productMostSale;
  List<CarType> cartype;
  List<Ads> ads;
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
                  backgroundColor: Colors.white, color: Colors.orange),
            )),
          ],
        ),
        iconSize: 35,
        title: (getTransrlate(context, 'Cart')),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    API(context, Check: false).post('site/new/products', {}).then((value) {
      if (value != null) {
        setState(() {
          product = Product_model.fromJson(value).data;
        });
      }
    });
    API(context).get('best/seller/products').then((value) {
      if (value != null) {
        setState(() {
          productMostSale = Product_model.fromJson(value).data;
        });
      }
    });

    API(context).get('car/types/list').then((value) {
      if (value != null) {
        setState(() {
          cartype = Car_type.fromJson(value).data;
        });
      }
    });
    API(context).get('site/ads').then((value) {
      if (value != null) {
        setState(() {
          ads = Ads_model.fromJson(value).data;
        });
      }
    });
    SharedPreferences.getInstance().then((value) {
      complete = value.getInt('complete');
      print('complete @@@@@@@@@@@@@@@@@@@@@@@@ $complete');
    });
    super.initState();
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
                    : Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: GridView.builder(
                          primary: false,
                          padding: EdgeInsets.only(top: 20),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.3,
                            crossAxisCount: 2,
                          ),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cartype.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Nav.route(
                                      context,
                                      ProductCarType(
                                          id: cartype[index].id,
                                          name: cartype[index].typeName));
                                },
                                child: Container(
                                  height: ScreenUtil.getHeight(context) / 10,
                                  width: ScreenUtil.getWidth(context) / 2.5,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 3.0, color: Colors.black12),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            "${cartype[index].image}"),
                                        fit: BoxFit.cover),
                                    borderRadius: themeColor.local == 'ar'
                                        ? index.isEven
                                            ? BorderRadius.only(
                                                topRight: Radius.circular(15.0),
                                                bottomRight:
                                                    Radius.circular(15.0))
                                            : BorderRadius.only(
                                                topLeft: Radius.circular(15.0),
                                                bottomLeft:
                                                    Radius.circular(15.0))
                                        : index.isEven
                                            ? BorderRadius.only(
                                                topLeft: Radius.circular(15.0),
                                                bottomLeft:
                                                    Radius.circular(15.0))
                                            : BorderRadius.only(
                                                topRight: Radius.circular(15.0),
                                                bottomRight:
                                                    Radius.circular(15.0)),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Card(
                                      color: Colors.black12,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: AutoSizeText(
                                            cartype[index].typeName,
                                            maxLines: 1,
                                            maxFontSize: 18,
                                            minFontSize: 10,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                ads == null
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: CarouselSlider(
                          items: ads
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
                    : SliderDotAds(_carouselCurrentPage, ads),
                productMostSale == null
                    ? Container()
                    : list_category(themeColor),
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
                        itemCount: ads.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Banner_item(item: ads[index].photo.image),
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
                              ),
                              list_product(themeColor, productMostSale),
                              SizedBox(
                                height: 10,
                              )
                            ],
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
    return productMostSale.isEmpty
        ? Container()
        : GridView.builder(
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 8),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.90,
              crossAxisCount: 3,
            ),
            itemCount: productMostSale.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: CategoryCard(
                  themeColor: themeColor,
                  product: productMostSale[index],
                ),
              );
            },
          );
  }

  Widget list_product(Provider_control themeColor, List<Product> product) {
    return product.isEmpty
        ? Container()
        : GridView.builder(
            primary: false,
            padding: EdgeInsets.only(left: 16),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.77,
              crossAxisCount: 2,
            ),
            itemCount: product.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 16),
                  child: ProductCard(
                    themeColor: themeColor,
                    product: product[index],
                  ),
                ),
              );
            },
          );
  }
}
