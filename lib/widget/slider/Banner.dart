import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/screen_size.dart';

class Banner_item extends StatelessWidget {
  const Banner_item({Key key, this.item}) : super(key: key);
  final String item;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getWidth(context)/1,

      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: CachedNetworkImage(
          imageUrl: item,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
