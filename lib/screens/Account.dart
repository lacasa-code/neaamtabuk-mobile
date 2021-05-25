import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/main.dart';
import 'package:flutter_pos/screens/Address_Page.dart';
import 'package:flutter_pos/screens/login.dart';
import 'package:flutter_pos/screens/register_page.dart';
import 'package:flutter_pos/user_information.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_pos/widget/item_hidden_menu.dart';
import 'package:flutter_pos/wishlist_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MyCars/myCars.dart';

class Account extends StatefulWidget {
  const Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
String name;
String token;
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        name = prefs.getString('user_name');
        token = prefs.getString('token');
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
           Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 SizedBox(
                   height: 5,
                 ),
                 Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: AutoSizeText(
                     name == null
                         ? getTransrlate(context, 'gust')
                         : "${getTransrlate(context, 'gust')} : ${name}",
                     style: TextStyle(
                         fontSize: 20,
                         color: Colors.black,
                         fontWeight: FontWeight.bold),
                   ),
                 ),
                 token!=null?Container():Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     InkWell(
                       onTap: () {
                         Nav.route(context, LoginPage());
                       },
                       child: Container(
                         width: ScreenUtil.getWidth(context)/2.5,
                       //  margin: const EdgeInsets.all(10.0),
                         padding: const EdgeInsets.all(10.0),
                         decoration: BoxDecoration(
                             border: Border.all(
                                 color:  Colors.orange
                                    )),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             SvgPicture.asset('assets/icons/User Icon.svg',color: Colors.orange,),
                            SizedBox(width: 5,),
                             Container(
                               width: ScreenUtil.getWidth(context)/4,
                               child: AutoSizeText(
                                 getTransrlate(context, 'login'),
                                 maxFontSize: 16,
                                 minFontSize: 10,
                                 style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                     InkWell(
                       onTap: () {
                         Nav.route(context, RegisterPage());
                       },
                       child: Container(
                         width: ScreenUtil.getWidth(context)/2.5,
                         padding: const EdgeInsets.all(10.0),
                         decoration: BoxDecoration(
                             border: Border.all(
                                 color:  Colors.orange
                                    )),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [

                             SvgPicture.asset('assets/icons/reload.svg',color: Colors.orange,width: 25,),
                            SizedBox(width: 5,),
                             Container(
                               width: ScreenUtil.getWidth(context)/4,

                               child: AutoSizeText(

                                 getTransrlate(context, 'AreadyAccount'),
                                 overflow: TextOverflow.ellipsis,
                                 maxFontSize: 14,
                                 maxLines: 1,
                                 minFontSize: 10,
                                 style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ],
                 ),
                 SizedBox(
                   height: ScreenUtil.getHeight(context)/30,
                 ),
                 Container(
                   padding: const EdgeInsets.only(right: 16, left: 16),
                   child: NotificationListener<OverscrollIndicatorNotification>(
                     onNotification: (scroll) {
                       scroll.disallowGlow();
                       return false;
                     },
                     child: Column(
                       children: <Widget>[
                         ItemHiddenMenu(
                           onTap: (){
                             Nav.route(context, UserInfo());

                           },
                           icon: Icon(
                             Icons.perm_identity_sharp,
                             size: 25,
                             color: Colors.orange,
                           ),
                           name: getTransrlate(context, 'ProfileSettings'),
                           baseStyle: TextStyle(
                               color: Colors.black,
                               fontSize: 19.0,
                               fontWeight: FontWeight.w800),
                           colorLineSelected: Colors.orange,
                         ),

                         ItemHiddenMenu(
                           onTap: (){
                             Nav.route(context, Shipping_Address());

                           },
                           icon: Icon(
                             Icons.location_on_outlined,
                             size: 25,
                             color: Colors.orange,
                           ),
                           name: getTransrlate(context, 'MyAddress'),
                           baseStyle: TextStyle(
                               color: Colors.black,
                               fontSize: 19.0,
                               fontWeight: FontWeight.w800),
                           colorLineSelected: Colors.orange,
                         ),
                         InkWell(
                           onTap: () {
                           },
                           child: ItemHiddenMenu(
                             icon: Icon(
                               Icons.local_shipping_outlined,
                               size: 25,
                               color: Colors.orange,
                             ),
                             name: getTransrlate(context, 'Myorders'),
                             baseStyle: TextStyle(
                                 color: Colors.black,
                                 fontSize: 19.0,
                                 fontWeight: FontWeight.w800),
                             colorLineSelected: Colors.orange,
                           ),
                         ),
                         ItemHiddenMenu(
                            onTap: (){
                              Nav.route(context, WishList());
                            },
                           icon: Icon(
                             Icons.favorite_border,
                             size: 25,
                             color: Colors.orange,
                           ),
                           name: getTransrlate(context, 'MyFav'),
                           baseStyle: TextStyle(
                               color: Colors.black,
                               fontSize: 19.0,
                               fontWeight: FontWeight.w800),
                           colorLineSelected: Colors.orange,
                         ),
                         InkWell(
                           onTap: () {
                           },
                           child: ItemHiddenMenu(
                             icon: Icon(
                               Icons.settings,
                               size: 25,
                               color: Colors.orange,
                             ),
                             name: getTransrlate(context, 'Settings'),
                             baseStyle: TextStyle(
                                 color: Colors.black,
                                 fontSize: 19.0,
                                 fontWeight: FontWeight.w800),
                             colorLineSelected: Colors.orange,
                           ),
                         ),
                         InkWell(
                           onTap: () async {
                             await themeColor.local == 'ar'
                                 ? themeColor.setLocal('en')
                                 : themeColor.setLocal('ar');
                             MyApp.setlocal(context,
                                 Locale(themeColor.getlocal(), ''));
                             SharedPreferences.getInstance()
                                 .then((prefs) {
                               prefs.setString(
                                   'local', themeColor.local);
                             });
                           },
                           child: ItemHiddenMenu(
                             icon: Icon(
                               Icons.language,
                               size: 25,
                               color: Colors.orange,
                             ),
                             name: Provider.of<Provider_control>(context)
                                 .local ==
                                 'ar'
                                 ? 'English'
                                 : 'عربى',
                             baseStyle: TextStyle(
                                 color: Colors.black,
                                 fontSize: 19.0,
                                 fontWeight: FontWeight.w800),
                             colorLineSelected: Colors.orange,
                           ),
                         ),
                         InkWell(
                           onTap: () {
                           },
                           child: ItemHiddenMenu(
                             icon: Icon(
                               Icons.info_outline,
                               size: 25,
                               color: Colors.orange,
                             ),
                             name: getTransrlate(context, 'FAQ'),
                             baseStyle: TextStyle(
                                 color: Colors.black,
                                 fontSize: 19.0,
                                 fontWeight: FontWeight.w800),
                             colorLineSelected: Colors.orange,
                           ),
                         ),
                         InkWell(
                           onTap: () {
                           },
                           child: ItemHiddenMenu(
                             icon: Icon(
                               Icons.contact_page_outlined,
                               size: 25,
                               color: Colors.orange,
                             ),
                             name: getTransrlate(context, 'About'),
                             baseStyle: TextStyle(
                                 color: Colors.black,
                                 fontSize: 19.0,
                                 fontWeight: FontWeight.w800),
                             colorLineSelected: Colors.orange,
                           ),
                         ),

                         token==null?Container(): InkWell(
                           onTap: () async {
                             themeColor.setLogin(false);
                             final SharedPreferences prefs =
                             await SharedPreferences.getInstance();
                             prefs.clear();
                             setState(() {
                               token=null;
                               name=null;
                             });
                             // Navigator.pushAndRemoveUntil(
                             //     context, MaterialPageRoute(builder: (_) => LoginPage()), (r) => false);
                             },
                           child: ItemHiddenMenu(
                             icon: Icon(
                               Icons.exit_to_app,
                               size: 19,
                               color: Colors.orange,
                             ),
                             name:  getTransrlate(context, 'Logout'),
                             baseStyle: TextStyle(
                                 color: Colors.black,
                                 fontSize: 19.0,
                                 fontWeight: FontWeight.w800),
                             colorLineSelected: Colors.orange,
                           ),
                         ),

                       ],
                     ),
                   ),
                 ),

               ]),
            SizedBox(height: 10,),
            Container(height: 1,color:Colors.grey),
            SizedBox(height: 20,),

            Center(
              child: Container(
                width: ScreenUtil.getWidth(context)/3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset("assets/icons/instagram.svg",color: Colors.blueGrey,width: 20,),
                      SvgPicture.asset("assets/icons/facebook.svg",color: Colors.blueGrey,width: 20,),
                      SvgPicture.asset("assets/icons/twitter.svg",color: Colors.blueGrey,width: 20,),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    TextButton(onPressed: (){}, child: Text('من نحن',style: TextStyle(color: Colors.black),)),
                    TextButton(onPressed: (){}, child: Text('تواصل معنا',style: TextStyle(color: Colors.black),)),
                    TextButton(onPressed: (){}, child: Text('الأسئلة الشائعة',style: TextStyle(color: Colors.black),)),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Container(
                        width: ScreenUtil.getWidth(context)/3.1,

                        child: TextButton(onPressed: (){}, child: AutoSizeText('لماذا تبيع على تركار',maxLines: 1,minFontSize: 10,maxFontSize: 16,style: TextStyle(color: Colors.black),))),
                    Container(                        width: ScreenUtil.getWidth(context)/3.1,
                        child: TextButton(onPressed: (){}, child: AutoSizeText('التسجيل كبائع',maxLines: 1,minFontSize: 10,maxFontSize: 16,style: TextStyle(color: Colors.black),))),
                    Container(                        width: ScreenUtil.getWidth(context)/3.1,
                        child: TextButton(onPressed: (){}, child: AutoSizeText('كيف تبيع على تركار',maxLines: 1,minFontSize: 10,maxFontSize: 16,style: TextStyle(color: Colors.black),))),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  getTransrlate(context, 'version') + ' 1.0.0',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'جميع الحقوق محفوظة ©2021 تركار',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
      ),);
  }


}
