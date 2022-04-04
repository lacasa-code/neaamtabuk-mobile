import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/screen_size.dart';


class OrderTextWidget extends StatelessWidget {
  const OrderTextWidget({
    Key key,
    @required this.description,
    @required this.title,
    this.width,
  }) : super(key: key);
  final String title, description;
  final num width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? ScreenUtil.getWidth(context) / 2.5,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: description,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),

      // AutoSizeText(
      //   '${getTransrlate(context, 'OrderNO').split('!')[0]}:  #${orders[index].donation_number} ',
      //   maxLines: 1,
      //   style:
      //       TextStyle(fontSize: 13),
      // ),
    );
  }
}
