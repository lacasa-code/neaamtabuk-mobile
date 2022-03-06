import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {

    super.initState();
  }

String phone='0559751131',email='info@neaamtabuk.org';
  
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      appBar: AppBar(title: Text(getTransrlate(context, 'contact'))),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset('assets/images/logo.png',width: ScreenUtil.getWidth(context)/2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                      ),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('$phone'),
                                      Text(
                                        getTransrlate(context, 'phone'),
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    _launchURL('sms:'+phone);
                                  },
                                  child: SizedBox(
                                    child: Icon(
                                      Icons.message,
                                      color: themeColor.getColor(),
                                    ),
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    InkWell(
                                      child: SizedBox(
                                        child: Icon(
                                          Icons.call,
                                          color: themeColor.getColor(),
                                        ),
                                        height: 60,
                                      ),
                                      onTap: (){
                                        _launchURL('tel:'+phone);
                                      },
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),

                              ],
                            ),
                            // Row(
                            //   children: <Widget>[
                            //     Expanded(
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: <Widget>[
                            //           Text(phone),
                            //           Text(
                            //             getTransrlate(context, 'phone'),
                            //             style: TextStyle(
                            //               fontSize: 11,
                            //               color: Colors.grey,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       child: InkWell(
                            //         onTap: (){
                            //           _launchURL('sms:'+phone);
                            //
                            //         },
                            //         child: Icon(
                            //           Icons.message,
                            //           color: themeColor.getColor(),
                            //         ),
                            //       ),
                            //       height: 60,
                            //       width: 60,
                            //     ),
                            //     Column(
                            //       children: <Widget>[
                            //         InkWell(
                            //           onTap: (){
                            //             _launchURL('tel:'+phone);
                            //           },
                            //           child: SizedBox(
                            //             child: Icon(
                            //               Icons.call,
                            //               color: themeColor.getColor(),
                            //             ),
                            //             height: 60,
                            //           ),
                            //         )
                            //       ],
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //     ),
                            //
                            //   ],
                            // ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: IntrinsicHeight(
                child: Expanded(
                  flex: 4,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              Text(email),
                              Text(
                                getTransrlate(context, 'Email'),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),

                            ],
                          )),
                          InkWell(
                            onTap: (){
                              _launchURL('mailto:'+email);
                            },
                            child: SizedBox(
                              child: Icon(
                                Icons.email,
                                 color: themeColor.getColor(),
                              ),
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              Text(phone),
                              Text(
                                "whats app",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),

                            ],
                          )),
                          InkWell(
                            onTap: (){
                              _launchURL("https://api.whatsapp.com/send?phone=559751131&text=%D9%85%D8%B1%D8%AD%D8%A8%20%D8%A8%D9%83%D9%85");
                            },
                            child: SizedBox(
                              child: Icon(
                                Icons.phone_android,
                                 color: themeColor.getColor(),
                              ),
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: themeColor.getColor(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              getTransrlate(context, 'contact'),
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.person),
                                title: new TextField(
                                  decoration: new InputDecoration(
                                    hintText: getTransrlate(context, 'name'),

                                  ),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.phone),
                                title: new TextField(
                                  decoration: new InputDecoration(
                                    hintText: getTransrlate(context, 'phone'),

                                  ),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.email),
                                title: new TextField(
                                  decoration: new InputDecoration(
                                    hintText: getTransrlate(context, 'Email'),

                                  ),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.edit),
                                title: new TextField(
                                  decoration: new InputDecoration(
                                    hintText: getTransrlate(context, 'Content'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: 42,
                          width: ScreenUtil.getWidth(context)/2,
                          margin: EdgeInsets.only(top: 20, bottom: 12),
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                              ),
                              color: themeColor.getColor(),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                //  setState(() => _isLoading = true);
                                }
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
                          ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTransrlate(context, 'ThankYou'),
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),

          ],
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
                style: TextStyle(
                   fontWeight: FontWeight.w400),
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
