import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/screen_size.dart';

class ItemHiddenMenu extends StatelessWidget {
  /// name of the menu item
  final String name;
  final String lable;

  final Widget icon;

  /// callback to recibe action click in item
  final Function onTap;

  final Color colorLineSelected;

  /// Base style of the text-item.
  final TextStyle baseStyle;

  /// style to apply to text when item is selected
  final TextStyle selectedStyle;

  final bool selected;

  ItemHiddenMenu({
    Key key,
    this.name,
    this.icon,this.lable,
    this.selected = false,
    this.onTap,
    this.colorLineSelected = Colors.blue,
    this.baseStyle,
    this.selectedStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 15.0, top: 15.0, left: 24),
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: <Widget>[
                Container(width: 32, child: icon),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    name,
                    style: (this.baseStyle ??
                            TextStyle(color: Colors.grey, fontSize: 14.0))
                        .merge(this.selected
                            ? this.selectedStyle ??
                                TextStyle(color: Colors.black, fontSize: 14)
                            : TextStyle(color: Colors.black, fontSize: 14)),
                  ),
                ),lable==null?Container():Row(
                  children: [
                    Icon(Icons.check,color: Colors.lightGreen,),
                    Container(
                      width: ScreenUtil.getWidth(context)/3,
                      child: Text(
                        "$lable",maxLines: 1,
                        style: (this.baseStyle ??
                                TextStyle(color: Colors.grey, fontSize: 14.0))
                            .merge(this.selected
                                ? this.selectedStyle ??
                                    TextStyle(color: Colors.black, fontSize: 14)
                                : TextStyle(color: Colors.black, fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                onTap == null
                    ? Container()
                    : Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 15,
                      )
              ],
            ),
          ),
        ),
        onTap == null
            ? Container()
            : Container(
                height: 1,
                color: Colors.black12,
              )
      ],
    );
  }
}
