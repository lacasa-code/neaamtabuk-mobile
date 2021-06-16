import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/cart_model.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:provider/provider.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({
    Key key,
    @required this.themeColor,
    this.carts,
  }) : super(key: key);

  final Provider_control themeColor;
  final OrderDetails carts;

  @override
  _ProductCartState createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ServiceData = Provider.of<Provider_Data>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: Colors.white,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: ScreenUtil.getWidth(context) / 3.5,
                child: CachedNetworkImage(
                  imageUrl: widget.carts.productImage.isNotEmpty
                      ? widget.carts.productImage[0].image
                      : '',
                  errorWidget: (context, url, error) =>
                      Icon(Icons.image, color: Colors.black12,),
                ),
              ),
              IconButton(
                  onPressed: () {
                    API(context).post('delete/from/cart', {
                      "order_id": widget.carts.orderId,
                      "product_id": widget.carts.productId
                    }).then((value) {
                      if (value != null) {
                        if (value['status_code'] == 200) {
                          showDialog(
                              context: context,
                              builder: (_) => ResultOverlay(value['message']));
                          ServiceData.getCart(context);
                        } else {
                          showDialog(
                              context: context,
                              builder: (_) => ResultOverlay(value['message']));
                        }
                      }
                    });
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                  )),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          //width: ScreenUtil.getWidth(context) / 1.7,
          padding: EdgeInsets.only(left: 10, top: 2, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AutoSizeText(
                widget.carts.productName,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                minFontSize: 11,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: ScreenUtil.getWidth(context) / 2.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: AutoSizeText(
                            "الكمية",
                            maxLines: 1,
                            minFontSize: 20,
                            maxFontSize: 25,
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              height: 50,
                              width: 43,
                              child: Center(
                                  child: IconButton(
                                    icon: Icon(Icons.add, color: Colors.grey),
                                    onPressed: () {
                                      API(context).post('add/to/cart', {
                                        "product_id": widget.carts.productId,
                                        "quantity": widget.carts.quantity+1,
                                        "order_id": widget.carts.orderId
                                      }).then((value) {
                                        if (value != null) {
                                          if (value['status_code'] == 200) {
                                            showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    ResultOverlay(value['message']));

                                            ServiceData.getCart(context);
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    ResultOverlay(value['message']));
                                          }
                                        }
                                      });
                                    },
                                  )),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              height: 50,
                              width: 50,
                              child: Center(
                                  child: Text("${widget.carts.quantity}")),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              width: 43,
                              height: 50,
                              child: Center(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (widget.carts.quantity != 1) {
                                          widget.carts.quantity--;
                                        }
                                      });
                                    },
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: ScreenUtil.getWidth(context) / 2.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: AutoSizeText(
                            "السعر",
                            maxLines: 1,
                            minFontSize: 20,
                            maxFontSize: 25,
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 10,),

                        Container(
                          child: AutoSizeText(
                            " ${widget.carts.price} ${getTransrlate(
                                context, 'Currency')}",
                            maxLines: 1,
                            minFontSize: 20,
                            maxFontSize: 25,
                            style: TextStyle(
                                color: widget.themeColor.getColor(),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Container(
                  height: 1,
                  color: Colors.black12,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
