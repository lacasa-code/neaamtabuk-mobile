import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/wishlist_model.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/widget/product/Wish_List_item.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  const WishList({Key key}) : super(key: key);

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List<WishListItem> wishList;
  int checkboxValue;

  @override
  void initState() {
    getwWISHlIST();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text('قائمة المنتجات المفضلة'),
          ],
        ),
      ),
      body: Container(
        child: wishList == null
            ? Container()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: wishList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wish_List(
                         wishList,
                           themeColor,
                          wishList[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }

  void getwWISHlIST() {
    API(context).get('user/get/wishlist').then((value) {
      if (value != null) {
        setState(() {
          wishList = Wishlist_model.fromJson(value).data;
        });
      }
    });
  }
}
