import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/Account.dart';
import 'package:flutter_pos/screens/CarType/productCarType.dart';
import 'package:flutter_pos/screens/cart.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_pos/model/ads.dart';
import 'package:flutter_pos/model/car_type.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/category.dart';
import 'package:flutter_pos/screens/MyCars/myCars.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/widget/category/category_card.dart';
import 'package:flutter_pos/widget/hidden_menu.dart';
import 'package:flutter_pos/widget/product/product_card.dart';
import 'package:flutter_pos/widget/product/product_list_titlebar.dart';
import 'package:flutter_pos/widget/slider/Banner.dart';
import 'package:flutter_pos/widget/slider/slider_dotAds.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> product;
  List<Product> productMostSale;
  List<Category> categories;
  List<CarType> cartype;
  List<Ads> ads;

  PersistentTabController _controller;
  final navigatorKey = GlobalKey<NavigatorState>();

  List<Widget> _buildScreens() {
    return [HomePage(), CategoryScreen(), Account(), CartScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("الرئيسية"),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.apps),
        title: ("الفئات"),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("حسابى"),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.cart),
        title: ("العربة"),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    API(context).post('site/new/products',{}).then((value) {
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
    API(context).get('site/part/categories').then((value) {
      if (value != null) {
        setState(() {
          categories = Category_model.fromJson(value).data;
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

    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _carouselCurrentPage = 0;
  String pathImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
     // drawer: HiddenMenu(),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
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

    return SingleChildScrollView(
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

          cartype == null
              ? Container()
              : Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: GridView.builder(
                    primary: false,
                    padding: EdgeInsets.only(top: 20),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.3,
                      crossAxisCount: 2,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartype.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            Nav.route(context, ProductCarType(id: cartype[index].id,name: cartype[index].typeName));
                          },
                          child: Container(
                            height: ScreenUtil.getHeight(context) / 10,
                            width: ScreenUtil.getWidth(context) / 2.5,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 3.0,color: Colors.black12
                              ),
                              image: DecorationImage(image: CachedNetworkImageProvider("${cartype[index].image}"),fit: BoxFit.cover) ,
                              borderRadius: index.isEven?BorderRadius.only(
                                  topRight: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0)
                              ):BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  bottomLeft: Radius.circular(15.0)
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Card(
                                color: Colors.black12,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: AutoSizeText(cartype[index].typeName,
                                       maxLines: 1,maxFontSize: 18,
                                      minFontSize: 10,
                                      style: TextStyle(color: Colors.white,

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
              ? Container(): CarouselSlider(
            items: ads
                .map((item) => Banner_item(
                      item: item.photo.image,
                    ))
                .toList(),
            options: CarouselOptions(
                height: ScreenUtil.getHeight(context)/5,
                aspectRatio: 16/9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
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
          SizedBox(height: 20,),
          ads == null
              ? Container():   SliderDotAds(_carouselCurrentPage,ads),
          categories == null ? Container() : list_category(themeColor),

          product == null ? Container() :product.isEmpty? Container() : Column(
            children: [
              ProductListTitleBar(
                themeColor: themeColor,
                title: 'وصل حديثاٌ',
                description: 'المزيد',
              ),
              list_product(themeColor, product),
            ],
          ),

          ads == null
              ? Container(): ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: ads.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Banner_item(
                  item:ads[index].photo.image
                ),
              );
            },
          ),

          productMostSale == null
              ? Container()
               :productMostSale.isEmpty? Container() :Column(
                children: [
                  ProductListTitleBar(
                    themeColor: themeColor,
                    title: 'الأكثر مبيعا',
                    description: 'المزيد',
                  ),
                  list_product(themeColor, productMostSale),
                ],
              ),
        ],
      ),
    );
  }

  Widget list_category(
    Provider_control themeColor,
  ) {
    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 4.0),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.90,
        crossAxisCount: 3,
      ),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: CategoryCard(
            themeColor: themeColor,
            product: categories[index],
          ),
        );
      },
    );
  }

  Widget list_product(Provider_control themeColor, List<Product> product) {
    return product.isEmpty?Container():GridView.builder(
      primary: false,
      padding: EdgeInsets.all(1),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.77,
        crossAxisCount: 2,
      ),
      itemCount: product.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ProductCard(
            themeColor: themeColor,
            product: product[index],
          ),
        );
      },
    );
  }

}
