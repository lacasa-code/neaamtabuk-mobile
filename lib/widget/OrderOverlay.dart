import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/neerRecipentModel.dart';
import 'package:flutter_pos/screens/delegateOrders.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:provider/provider.dart';

class OrderOverlay extends StatefulWidget {
  String donation_id;

  OrderOverlay({this.donation_id});

  @override
  State<StatefulWidget> createState() => OrderOverlayState();
}

class OrderOverlayState extends State<OrderOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  List<NeerRecipent> recipent;
  final formKey = GlobalKey<FormState>();
  NeerRecipent trakers;
  @override
  void initState() {
    API(context).get('nearRecipent').then((value) {
      if (value != null) {
        setState(() {
          recipent = NeerRecipentModel.fromJson(value).data;
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
    final theme = Provider.of<Provider_control>(context);
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
                            left: 25.0,
                            right: 25.0,
                            top: 10.0,
                            bottom: 10),
                        child: DropdownSearch<NeerRecipent>(
                          mode: Mode.MENU,

                          dropdownBuilder: (context, item) {
                            return item == null
                                ? Container()
                                : Padding(
                              padding:
                              const EdgeInsets.all(
                                  8.0),
                              child: Text(
                                  " ${item?.username} "),
                            );
                          },
                          validator: (NeerRecipent item) {
                            if (item == null) {
                              return "${getTransrlate(context, 'requiredempty')}";
                            } else
                              return null;
                          },
                          items: recipent,
                          popupItemBuilder:
                          _customPopupItemBuilderExample,
                          //  onFind: (String filter) => getData(filter),
                          onChanged: (NeerRecipent u) {
                            setState(() {
                              trakers = u;
                            });
                          },
                          itemAsString: (NeerRecipent u) =>
                          " ${u.username} ",
                        )),
                    trakers == null
                        ? Container()
                        : Column(
                          children: [
                            Container(
                      height: 40,
                      //width: ScreenUtil.getWidth(context),
                      margin: EdgeInsets.only(
                              top: 12, bottom: 0),
                      child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(
                                  1.0),
                            ),
                            color: theme.getColor(),
                            onPressed: () async {
                              if (formKey.currentState
                                  .validate()) {
                                formKey.currentState.save();
                                API(context).post('orderRecipent/${widget.donation_id}', {
                                  'recipient_id': trakers.id,
                                  'status_id': 2,
                                }).then((value) {
                                  print(value);
                                  if (value['status'] == true) {
                                    Navigator.pop(context);
                                    Nav.routeReplacement(
                                        context, Delegate());

                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                            ResultOverlay(
                                                '${value['message']}'));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                            ResultOverlay(
                                                '${value['message']}'));
                                  }
                                });
                              }
                            },
                            child: Text(
                              getTransrlate(
                                  context, 'placeorder'),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      ),
                    ),
                            Container(
                      height: 40,
                      //width: ScreenUtil.getWidth(context),
                      margin: EdgeInsets.only(
                              top: 12, bottom: 0),
                      child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(
                                  1.0),
                            ),
                            color: theme.getColor(),
                            onPressed: () async {
                              if (formKey.currentState
                                  .validate()) {
                                formKey.currentState.save();
                                API(context).post('closeAt/${widget.donation_id}', {
                                }).then((value) {
                                  print(value);
                                  if (value['status'] == true) {
                                    Navigator.pop(context);
                                    Nav.routeReplacement(
                                        context, Delegate());

                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                            ResultOverlay(
                                                '${value['message']}'));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                            ResultOverlay(
                                                '${value['message']}'));
                                  }
                                });
                              }
                            },
                            child: Text(
                             "قفل الطلب",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      ),
                    ),
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
      BuildContext context, NeerRecipent item, bool isSelected) {
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
        subtitle: Text(item?.address?.toString() ?? ''),
        leading: CircleAvatar(
          child: Text("${item?.distance?.toString() ?? ''}K"),
        ),
      ),
    );
  }
}
