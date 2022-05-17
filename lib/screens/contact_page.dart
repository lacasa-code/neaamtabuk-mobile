import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/main.dart';
import 'package:flutter_pos/utils/Provider/contact_us_provider.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/utils/tab_provider.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as util;

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    super.initState();
  }

  String phone = '0559751131', email = 'info@neaamtabuk.org';
  ContactUsProvider _contactUsProvider;
  var isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      _contactUsProvider =
          Provider.of<ContactUsProvider>(context, listen: false)..init(context);

      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ProviderControl>(context);

    return WillPopScope(
      onWillPop: () async {
        Provider.of<TabProvider>(context, listen: false).toHome();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            getTransrlate(context, 'contact'),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: util.ScreenUtil().setSp(17)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton(
                itemBuilder: (_) => [
                  CheckedPopupMenuItem(
                    value: 'ar',
                    checked: themeColor.local == 'ar',
                    child: Text(
                      'العربية',
                    ),
                  ),
                  CheckedPopupMenuItem(
                    value: 'en',
                    checked: themeColor.local == 'en',
                    child: Text(
                      'English',
                    ),
                  ),
                ],
                child: Icon(
                  Icons.language,
                  color: themeColor.getColor(),
                ),
                onSelected: (v) {
                  if (themeColor.local == v) {
                    return;
                  }
                  themeColor.setLocal(v);
                  MyApp.setlocal(context, Locale(themeColor.getlocal(), ''));
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setString('local', themeColor.local);
                  });
                },
              ),
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Consumer<ContactUsProvider>(
          builder: (context,snap,__) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ContactUsWidget(
                    iconPath: 'assets/icons/phone.png',
                    data: phone,
                    title: getTransrlate(context, 'phone'),
                    onPressed: () {
                      _launchURL('tel:' + phone);
                    },
                  ),
                  ContactUsWidget(
                    iconPath: 'assets/icons/email.png',
                    data: email,
                    title: getTransrlate(context, 'Email'),
                    onPressed: () {
                      _launchURL('mailto:' + email);
                    },
                  ),
                  ContactUsWidget(
                    iconPath: 'assets/icons/WhatsApp.png',
                    data: phone,
                    title: 'WhatsApp',
                    onPressed: () {
                      _launchURL(
                          "https://api.whatsapp.com/send?phone=559751131&text=%D9%85%D8%B1%D8%AD%D8%A8%20%D8%A8%D9%83%D9%85");
                    },
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(24.0),
                  //   child: IntrinsicHeight(
                  //     child: Row(
                  //       children: <Widget>[
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: <Widget>[
                  //             Text('$phone'),
                  //             Text(
                  //               getTransrlate(context, 'phone'),
                  //               style: TextStyle(
                  //                 fontSize: 11,
                  //                 color: Colors.grey,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Expanded(
                  //             child: Container(
                  //           height: 10,
                  //         )),
                  //         InkWell(
                  //           onTap: () {
                  //             _launchURL('sms:' + phone);
                  //           },
                  //           child: SizedBox(
                  //             child: Icon(
                  //               Icons.message,
                  //               color: themeColor.getColor(),
                  //             ),
                  //             height: 60,
                  //             width: 60,
                  //           ),
                  //         ),
                  //         InkWell(
                  //           child: SizedBox(
                  //             child: Icon(
                  //               Icons.call,
                  //               color: themeColor.getColor(),
                  //             ),
                  //             height: 60,
                  //           ),
                  //           onTap: () {
                  //             _launchURL('tel:' + phone);
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(24.0),
                  //   child: IntrinsicHeight(
                  //     child: Column(
                  //       children: <Widget>[
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: <Widget>[
                  //             Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: <Widget>[
                  //                 Text(email),
                  //                 Text(
                  //                   getTransrlate(context, 'Email'),
                  //                   style: TextStyle(
                  //                     fontSize: 11,
                  //                     color: Colors.grey,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 _launchURL('mailto:' + email);
                  //               },
                  //               child: SizedBox(
                  //                 child: Icon(
                  //                   Icons.email,
                  //                   color: themeColor.getColor(),
                  //                 ),
                  //                 height: 60,
                  //                 width: 60,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: <Widget>[
                  //             Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: <Widget>[
                  //                 Text(phone),
                  //                 Text(
                  //                   "whats app",
                  //                   style: TextStyle(
                  //                     fontSize: 11,
                  //                     color: Colors.grey,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 _launchURL(
                  //                     "https://api.whatsapp.com/send?phone=559751131&text=%D9%85%D8%B1%D8%AD%D8%A8%20%D8%A8%D9%83%D9%85");
                  //               },
                  //               child: SizedBox(
                  //                 child: Icon(
                  //                   Icons.phone_android,
                  //                   color: themeColor.getColor(),
                  //                 ),
                  //                 height: 60,
                  //                 width: 60,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Form(
                      key: _contactUsProvider.formKey,
                      child: Column(
                        children: <Widget>[
                          MyTextFormField(
                            istitle: true,
                            hintText: 'name',
                            validator: (v) =>
                                _contactUsProvider.nameValidate(v, context),
                            controller: _contactUsProvider.nameController,
                            prefix: ImageIcon(
                              AssetImage('assets/icons/user.png'),
                            ),
                          ),
                          MyTextFormField(
                            istitle: true,
                            controller: _contactUsProvider.mobileController,
                            hintText: 'phone',
                            validator: (v) =>
                                _contactUsProvider.mobileValidate(v, context),
                            keyboardType: TextInputType.phone,
                            prefix: ImageIcon(
                              AssetImage('assets/icons/phone.png'),
                            ),
                          ),
                          MyTextFormField(
                            istitle: true,
                            controller: _contactUsProvider.emailController,
                            hintText: 'Email',
                            validator: (v) =>
                                _contactUsProvider.emailValidate(v, context),
                            keyboardType: TextInputType.emailAddress,
                            prefix: ImageIcon(
                              AssetImage('assets/icons/email.png'),
                            ),
                          ),
                          MyTextFormField(
                            istitle: true,
                            controller: _contactUsProvider.contentController,
                            hintText: 'Content',
                            validator: (v) =>
                                _contactUsProvider.contentValidate(v, context),
                            prefix: ImageIcon(
                              AssetImage('assets/icons/edit.png'),
                            ),
                          ),
                          Consumer<ContactUsProvider>(builder: (context, snap, __) {
                            return snap.isLoading
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff2CA649),
                                          Color(0xff2CA649),
                                          Color(0xff4BB146),
                                          Color(0xff4BB146),
                                          Color(0xff66BA44),
                                          Color(0xff77C042),
                                        ],
                                      ),
                                    ),
                                    child: FlatButton(
                                      minWidth: ScreenUtil.getWidth(context) / 2.5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 30,
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          )),
                                        ),
                                      ),
                                      onPressed: () async {},
                                    ),
                                  )
                                : Container(
                                    height: 42,
                                    width: ScreenUtil.getWidth(context),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff2CA649),
                                          Color(0xff2CA649),
                                          Color(0xff4BB146),
                                          Color(0xff4BB146),
                                          Color(0xff66BA44),
                                          Color(0xff77C042),
                                        ],
                                      ),
                                    ),
                                    margin: EdgeInsets.only(
                                      top: 20,
                                      bottom: 12,
                                    ),
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                      ),
                                      onPressed: () async {
                                        _contactUsProvider.contactUs(context);
                                        // if (_formKey.currentState.validate()) {
                                        //   _formKey.currentState.save();
                                        //   FocusScope.of(context)
                                        //       .requestFocus(new FocusNode());
                                        //   //  setState(() => _isLoading = true);
                                        // }
                                      },
                                      child: Text(
                                        getTransrlate(context, 'Submit'),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  );
                          }),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(24),
                  //   child: Align(
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       getTransrlate(context, 'ThankYou'),
                  //       style: TextStyle(
                  //         fontSize: 17,
                  //         color: Colors.grey,
                  //         fontWeight: FontWeight.w300,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Container contactItem(
      String title, String description, String secondDescription) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, left: 8, right: 8, top: 8),
      height: 84,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 9.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ]),
      child: Container(
        padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(color: Color(0xFF707070)),
            ),
            RichText(
              text: TextSpan(
                text: description,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            RichText(
              text: TextSpan(
                text: secondDescription,
              ),
            )
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ContactUsWidget extends StatelessWidget {
  const ContactUsWidget({
    Key key,
    @required this.iconPath,
    @required this.title,
    @required this.data,
    @required this.onPressed,
  }) : super(key: key);

  final String iconPath;
  final String title;
  final String data;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ProviderControl>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              InkWell(
                onTap: onPressed,
                child: ImageIcon(
                  AssetImage(
                    iconPath,
                  ),
                  color: themeColor.getColor(),
                ),
              ),
              SizedBox(
                width: util.ScreenUtil().setWidth(10),
              ),
              Text(
                title,
                style: TextStyle(
                  color: themeColor.getColor(),
                  fontWeight: FontWeight.bold,
                  fontSize: util.ScreenUtil().setSp(16),
                ),
              ),
              SizedBox(
                width: util.ScreenUtil().setWidth(10),
              ),
              Text(
                data ?? '',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: util.ScreenUtil().setSp(16),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: util.ScreenUtil().setHeight(10),
        ),
      ],
    );
  }
}
