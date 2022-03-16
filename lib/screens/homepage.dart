import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/DonorOrders.dart';
import 'package:flutter_pos/screens/OrderHistory.dart';
import 'package:flutter_pos/screens/RecipentOrders.dart';
import 'package:flutter_pos/screens/account/volunteer.dart';
import 'package:flutter_pos/screens/delegateOrders.dart';
import 'package:flutter_pos/screens/delegateOrdersCompleated.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/hidden_menu.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  final navigatorKey = GlobalKey<NavigatorState>();


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String role_id;

  @override
  void initState() {
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provider_Data = Provider.of<Provider_Data>(context);
    final theme = Provider.of<Provider_control>(context);
    return Scaffold(
      key: _scaffoldKey,
     drawer: HiddenMenu(),
      body:Column(
        children: [
          AppBarCustom(scaffoldKey: _scaffoldKey,),
          Expanded(
            child: RefreshIndicator(color: theme.getColor(),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(height: ScreenUtil.getHeight(context)/4),
                      items: ["https://neaamtabuk.org/wp-content/uploads/2018/07/%D9%88%D8%A7%D8%AC%D9%87%D9%87-%D9%A2%D9%A2%D9%A2-1.jpg","https://neaamtabuk.org/wp-content/uploads/2018/07/واجهه-١١١-1.jpg","https://neaamtabuk.org/wp-content/uploads/2018/07/واجهه-٢٢٢-1.jpg"].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration:  BoxDecoration(
                                  image:  DecorationImage(
                                    image:  NetworkImage('$i'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Text('', style: TextStyle(fontSize: 16.0),)
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20,),
                    Text('يَداً بيد..نحفظ النِّعم',style: TextStyle(fontSize: 16.0,color: theme.getColor()),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('النعمة هى كل عطية اعطاها الله لنا لتساعدنا فى الحياه فكلنا نعم انعم الله علينا بها ولا يطلب فى مقابل الكم الهائل من كل تلك النعم سوى الشكر لله على بما انعم الله علينا قال تعالى: {لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ }.',style: TextStyle(fontSize: 12.0),textAlign: TextAlign.center,),
                    ),
                    SizedBox(height: 20,),

                    role_id=='1'? Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Nav.route(context, VolunteerPage());
                          },
                          child: Container(
                            width: ScreenUtil.getWidth(context)/1.3,
                            decoration: BoxDecoration(
                                border: Border.all(color:theme.getColor(), width: 1)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  '${getTransrlate(context, 'volunteer')}',
                                  style: TextStyle(
                                      color:theme.getColor(), fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: (){
                            Nav.route(context, DonorOrders());
                          },
                          child: Container(
                            width: ScreenUtil.getWidth(context)/1.3,
                            decoration: BoxDecoration(
                                border: Border.all(color:theme.getColor(), width: 1)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  '${getTransrlate(context, 'Myorders')}',
                                  style: TextStyle(
                                      color:theme.getColor(), fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ):  role_id=='2'?
                    Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Nav.route(context, Orders());
                          },
                          child: Container(
                            width: ScreenUtil.getWidth(context)/1.3,
                            decoration: BoxDecoration(
                                border: Border.all(color:theme.getColor(), width: 1)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  '${getTransrlate(context, 'Myorders')}',
                                  style: TextStyle(
                                      color:theme.getColor(), fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: (){
                            Nav.route(context, Delegate());
                          },
                          child: Container(
                            width: ScreenUtil.getWidth(context)/1.3,
                            decoration: BoxDecoration(
                                border: Border.all(color:theme.getColor(), width: 1)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  '${getTransrlate(context, 'orders')}',
                                  style: TextStyle(
                                      color:theme.getColor(), fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: (){
                            Nav.route(context, DelegateCompleated());
                          },
                          child: Container(
                            width: ScreenUtil.getWidth(context)/1.3,
                            decoration: BoxDecoration(
                                border: Border.all(color:theme.getColor(), width: 1)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  '${getTransrlate(context, 'ordersCompleated')}',
                                  style: TextStyle(
                                      color:theme.getColor(), fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ):
                    InkWell(
                      onTap: (){
                        Nav.route(context, RecipentOrders());
                      },
                      child: Container(
                        width: ScreenUtil.getWidth(context)/1.3,
                        decoration: BoxDecoration(
                            border: Border.all(color:theme.getColor(), width: 1)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              '${getTransrlate(context, 'Recvivedorders')}',
                              style: TextStyle(
                                  color:theme.getColor(), fontWeight: FontWeight.bold),
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
      ),
    );
  }

  Future<Null> _refreshLocalGallery() async{
  }

  void getUser() {
    SharedPreferences.getInstance().then((pref) => {
      setState(() {
        role_id = pref.getString('role_id');
      }),
      print(pref.getString('role_id')),
    });

  }


}
