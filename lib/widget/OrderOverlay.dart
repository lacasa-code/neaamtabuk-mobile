import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/neerRecipentModel.dart';
import 'package:flutter_pos/screens/delegateOrders.dart';
import 'package:flutter_pos/screens/tab_screen.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/home_provider.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/utils/tab_provider.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:provider/provider.dart';

import '../screens/delegateOrdersCompleated.dart';

class OrderOverlay extends StatefulWidget {
  final String donationId;
  final int recipentId;
  OrderOverlay({
    this.donationId,
    this.recipentId,
  });

  @override
  State<StatefulWidget> createState() => OrderOverlayState();
}

class OrderOverlayState extends State<OrderOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  List<NearRecipent> recipent;
  final formKey = GlobalKey<FormState>();
  NearRecipent trakers;
  @override
  void initState() {
    API(context).get('nearRecipent').then((value) {
      if (value != null) {
        setState(() {
          recipent = NearRecipentModel.fromJson(value).data;
          if (widget.recipentId != null) {
            trakers = recipent.firstWhere(
                (element) => element.id == widget.recipentId,
                orElse: null);
          }
        });
      }
    });
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ProviderControl>(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: ScreenUtil.getWidth(context),
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0))),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Text(
                            "${getTransrlate(context, 'nearRecipent')}",
                          )),
                    ),
                    recipent == null
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 10.0, bottom: 10),
                            child: DropdownSearch<NearRecipent>(
                              mode: Mode.DIALOG,
                              dropdownSearchDecoration: InputDecoration(
                                contentPadding: theme.local == 'ar'
                                    ? EdgeInsets.fromLTRB(0, 0, 12, 12)
                                    : EdgeInsets.fromLTRB(12, 12, 0, 0),
                                border: OutlineInputBorder(),
                                disabledBorder: OutlineInputBorder(),
                                errorStyle: TextStyle(color: Colors.red),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              selectedItem: trakers,
                              dropdownBuilder: (context, item) {
                                return item == null
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(" ${item?.username} "),
                                      );
                              },
                              validator: (NearRecipent item) {
                                if (item == null) {
                                  return "${getTransrlate(context, 'requiredempty')}";
                                } else
                                  return null;
                              },
                              items: recipent,
                              popupItemBuilder: _customPopupItemBuilderExample,
                              //  onFind: (String filter) => getData(filter),
                              onChanged: (NearRecipent u) {
                                setState(() {
                                  trakers = u;
                                });
                              },
                              itemAsString: (NearRecipent u) =>
                                  " ${u.username} ",
                            )),
                    trakers == null
                        ? Container()
                        : Column(
                            children: [
                              Container(
                                height: 40,
                                //width: ScreenUtil.getWidth(context),
                                margin: EdgeInsets.only(top: 12, bottom: 0),
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(1.0),
                                  ),
                                  color: theme.getColor(),
                                  onPressed: () async {
                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();
                                      API(context).post(
                                          'orderRecipent/${widget.donationId}',
                                          {
                                            'recipient_id': trakers.id,
                                            'status_id': 2,
                                          }).then((value) {
                                        print(value);
                                        if (value['status'] == true) {
                                          showDialog(
                                              context: context,
                                              builder: (_) => ResultOverlay(
                                                    '${value['message']}',
                                                    success: true,
                                                  )).whenComplete(() {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Nav.routeReplacement(
                                              context,
                                              MultiProvider(
                                                providers: [
                                                  ChangeNotifierProvider(
                                                    create: (_) =>
                                                        TabProvider(),
                                                  ),
                                                  ChangeNotifierProvider(
                                                    create: (_) =>
                                                        HomeProvider()
                                                          ..changeTabIndex(2),
                                                  ),
                                                ],
                                                child: TabScreen(
                                                  homeTabIndex: 2,
                                                ),
                                              ),
                                            );
                                          });
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (_) => ResultOverlay(
                                                  '${value['message']}'));
                                        }
                                      });
                                    }
                                  },
                                  child: Text(
                                    getTransrlate(context, 'placeorder'),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              //         Container(
                              //   height: 40,
                              //   //width: ScreenUtil.getWidth(context),
                              //   margin: EdgeInsets.only(
                              //           top: 12, bottom: 0),
                              //   child: FlatButton(
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //           new BorderRadius.circular(
                              //               1.0),
                              //         ),
                              //         color: theme.getColor(),
                              //         onPressed: () async {
                              //           if (formKey.currentState
                              //               .validate()) {
                              //             formKey.currentState.save();
                              //             API(context).post('closeAt/${widget.donation_id}', {
                              //             }).then((value) {
                              //               print(value);
                              //               if (value['status'] == true) {
                              //                 Navigator.pop(context);
                              //                 Nav.routeReplacement(
                              //                     context, Delegate());
                              //
                              //                 showDialog(
                              //                     context: context,
                              //                     builder: (_) =>
                              //                         ResultOverlay(
                              //                             '${value['message']}'));
                              //               } else {
                              //                 showDialog(
                              //                     context: context,
                              //                     builder: (_) =>
                              //                         ResultOverlay(
                              //                             '${value['message']}'));
                              //               }
                              //             });
                              //           }
                              //         },
                              //         child: Text(
                              //          "?????? ??????????",
                              //           style: TextStyle(
                              //             fontSize: 16,
                              //             color: Colors.white,
                              //             fontWeight: FontWeight.w400,
                              //           ),
                              //         ),
                              //   ),
                              // ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customPopupItemBuilderExample(
      BuildContext context, NearRecipent item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.username ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                "${getTransrlate(context, "phone")} : 0${item?.mobile?.toString() ?? ''}"),
            Text(
                "${getTransrlate(context, "family_members")} : ${item?.family_members?.toString() ?? ''}"),
          ],
        ),
        leading: CircleAvatar(
          child: Text(
              "${double.tryParse(item?.distance ?? '0').roundToDouble()}K"),
        ),
      ),
    );
  }
}
