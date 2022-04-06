import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/DonorOrders.dart';
import 'package:flutter_pos/screens/OrderHistory.dart';
import 'package:flutter_pos/screens/RecipentOrders.dart';
import 'package:flutter_pos/screens/delegateOrders.dart';
import 'package:flutter_pos/screens/delegateOrdersCompleated.dart';
import 'package:flutter_pos/screens/views/donor_view.dart';
import 'package:flutter_pos/screens/widgets/page_header_widget.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/home_provider.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as util;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  final navigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String roleId;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<ProviderData>(context);
    final theme = Provider.of<ProviderControl>(context);
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, snap, __) {
          return Column(
            children: [
              PageHeaderWidget(),
              if (roleId == '1') ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TabItem(
                      iconPath: 'assets/icons/orders.png',
                      title: 'MyordersDonner',
                      isSelected: snap.tabIndex == 0,
                      onPressed: () => snap.changeTabIndex(0),
                    ),
                    TabItem(
                      iconPath: 'assets/icons/donor.png',
                      title: 'volunteer',
                      isSelected: snap.tabIndex == 1,
                      onPressed: () => snap.changeTabIndex(1),
                    ),
                  ],
                ),
                Expanded(
                  child: snap.tabIndex == 0 ? DonorOrders() : VolunteerView(),
                ),
              ],
              if (roleId == '2') ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TabItem(
                      iconPath: 'assets/icons/user.png',
                      title: 'donors',
                      isSelected: snap.tabIndex == 0,
                      onPressed: () => snap.changeTabIndex(0),
                    ),
                    TabItem(
                      iconPath: 'assets/icons/orders.png',
                      title: 'MyordersDonner',
                      isSelected: snap.tabIndex == 1,
                      onPressed: () => snap.changeTabIndex(1),
                    ),
                    TabItem(
                      iconPath: 'assets/icons/donor.png',
                      title: 'completed',
                      isSelected: snap.tabIndex == 2,
                      onPressed: () => snap.changeTabIndex(2),
                    ),
                  ],
                ),

                Expanded(
                  child: snap.tabIndex == 0
                      ? Orders()
                      : snap.tabIndex == 1
                          ? Delegate()
                          : DelegateCompleated(),
                ),

                // Column(
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         Nav.route(context, Orders());
                //       },
                //       child: Container(
                //         width: ScreenUtil.getWidth(context) / 1.3,
                //         decoration: BoxDecoration(
                //             border: Border.all(color: theme.getColor(), width: 1)),
                //         child: Center(
                //           child: Padding(
                //             padding: const EdgeInsets.all(16.0),
                //             child: Text(
                //               '${getTransrlate(context, 'Myorders')}',
                //               style: TextStyle(
                //                   color: theme.getColor(),
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(height: 10),
                //     InkWell(
                //       onTap: () {
                //         Nav.route(context, Delegate());
                //       },
                //       child: Container(
                //         width: ScreenUtil.getWidth(context) / 1.3,
                //         decoration: BoxDecoration(
                //             border: Border.all(color: theme.getColor(), width: 1)),
                //         child: Center(
                //           child: Padding(
                //             padding: const EdgeInsets.all(16.0),
                //             child: Text(
                //               '${getTransrlate(context, 'orders')}',
                //               style: TextStyle(
                //                   color: theme.getColor(),
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(height: 10),
                //     InkWell(
                //       onTap: () {
                //         Nav.route(context, DelegateCompleated());
                //       },
                //       child: Container(
                //         width: ScreenUtil.getWidth(context) / 1.3,
                //         decoration: BoxDecoration(
                //             border: Border.all(color: theme.getColor(), width: 1)),
                //         child: Center(
                //           child: Padding(
                //             padding: const EdgeInsets.all(16.0),
                //             child: Text(
                //               '${getTransrlate(context, 'ordersCompleated')}',
                //               style: TextStyle(
                //                   color: theme.getColor(),
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                // ],
                // )
              ],
              if (roleId == '3') ...[
                Container(
                  width: ScreenUtil.getWidth(context) / 1.3,
                  decoration: BoxDecoration(
                    color: theme.getColor(),
                    border: Border.all(color: theme.getColor(), width: 1),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage(
                              'assets/icons/orders.png',
                            ),
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${getTransrlate(context, 'Recvivedorders')}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: RecipentOrders(),
                ),
              ],
            ],
          );
        },
      ),
    );
    Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      // drawer: HiddenMenu(),
      // body: ,
      /*
      body: Column(
        children: [
          AppBarCustom(
            scaffoldKey: _scaffoldKey,
          ),
          Expanded(
            child: RefreshIndicator(
              color: theme.getColor(),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          height: ScreenUtil.getHeight(context) / 4),
                      items: [
                        "https://neaamtabuk.org/wp-content/uploads/2018/07/%D9%88%D8%A7%D8%AC%D9%87%D9%87-%D9%A2%D9%A2%D9%A2-1.jpg",
                        "https://neaamtabuk.org/wp-content/uploads/2018/07/واجهه-١١١-1.jpg",
                        "https://neaamtabuk.org/wp-content/uploads/2018/07/واجهه-٢٢٢-1.jpg",
                      ].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('$i'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Text(
                                  '',
                                  style: TextStyle(fontSize: 16.0),
                                ));
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'يَداً بيد..نحفظ النِّعم',
                      style: TextStyle(fontSize: 16.0, color: theme.getColor()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'النعمة هى كل عطية اعطاها الله لنا لتساعدنا فى الحياه فكلنا نعم انعم الله علينا بها ولا يطلب فى مقابل الكم الهائل من كل تلك النعم سوى الشكر لله على بما انعم الله علينا قال تعالى: {لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ }.',
                        style: TextStyle(fontSize: 12.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    roleId == '1'
                        ? Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Nav.route(context, VolunteerPage());
                                },
                                child: Container(
                                  width: ScreenUtil.getWidth(context) / 1.3,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: theme.getColor(), width: 1)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        '${getTransrlate(context, 'volunteer')}',
                                        style: TextStyle(
                                            color: theme.getColor(),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  Nav.route(context, DonorOrders());
                                },
                                child: Container(
                                  width: ScreenUtil.getWidth(context) / 1.3,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: theme.getColor(), width: 1)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        '${getTransrlate(context, 'MyordersDonner')}',
                                        style: TextStyle(
                                            color: theme.getColor(),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : roleId == '2'
                            ? Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Nav.route(context, Orders());
                                    },
                                    child: Container(
                                      width: ScreenUtil.getWidth(context) / 1.3,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: theme.getColor(),
                                              width: 1)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '${getTransrlate(context, 'Myorders')}',
                                            style: TextStyle(
                                                color: theme.getColor(),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      Nav.route(context, Delegate());
                                    },
                                    child: Container(
                                      width: ScreenUtil.getWidth(context) / 1.3,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: theme.getColor(),
                                              width: 1)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '${getTransrlate(context, 'orders')}',
                                            style: TextStyle(
                                                color: theme.getColor(),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      Nav.route(context, DelegateCompleated());
                                    },
                                    child: Container(
                                      width: ScreenUtil.getWidth(context) / 1.3,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: theme.getColor(),
                                              width: 1)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '${getTransrlate(context, 'ordersCompleated')}',
                                            style: TextStyle(
                                                color: theme.getColor(),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : InkWell(
                                onTap: () {
                                  Nav.route(context, RecipentOrders());
                                },
                                child: Container(
                                  width: ScreenUtil.getWidth(context) / 1.3,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: theme.getColor(), width: 1)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        '${getTransrlate(context, 'Recvivedorders')}',
                                        style: TextStyle(
                                            color: theme.getColor(),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
              onRefresh: _refreshLocalGallery,
            ),
          ),
        ],
      ),*/
    );
  }

  Future<Null> _refreshLocalGallery() async {}

  void getUser() {
    SharedPreferences.getInstance().then((pref) => {
          setState(() {
            roleId = pref.getString('role_id');
          }),
          print(pref.getString('role_id')),
        });
  }
}

class TabItem extends StatelessWidget {
  const TabItem({
    Key key,
    @required this.iconPath,
    @required this.title,
    @required this.isSelected,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final String iconPath;
  final bool isSelected;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    ProviderControl theme = Provider.of<ProviderControl>(context);
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? theme.getColor() : Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 1.0,
            color: theme.getColor(),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        child: Row(
          children: [
            ImageIcon(
              AssetImage(
                iconPath ?? 'assets/icons/orders.png',
              ),
              color: !isSelected ? theme.getColor() : Colors.white,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              getTransrlate(context, title),
              style: TextStyle(
                color: !isSelected ? theme.getColor() : Colors.white,
                fontSize: util.ScreenUtil().setSp(17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
