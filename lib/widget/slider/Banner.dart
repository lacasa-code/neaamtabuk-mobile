import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Banner_item extends StatelessWidget {
  const Banner_item({Key key, this.item}) : super(key: key);
  final String item;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey[200],
              blurRadius: 5.0,
              spreadRadius: 1,
              offset: Offset(0.0, 1)),
        ],
      ),
      margin: EdgeInsets.only(
        left: 12.0,
        right: 16,
        top: 16,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: CachedNetworkImage(
          imageUrl: item,
        ),
      ),
    );
  }
}
