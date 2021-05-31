import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';

class Tickits extends StatefulWidget {
  const Tickits({Key key}) : super(key: key);

  @override
  _TickitsState createState() => _TickitsState();
}

class _TickitsState extends State<Tickits> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
          Container(
              width: ScreenUtil.getWidth(context) / 2,
              child: AutoSizeText(
                'الطلبات والمشتريات',
                minFontSize: 10,
                maxFontSize: 16,
                maxLines: 1,
              )),
        ],
      ),
    ),
     body: Form(
       key: _formKey,
       child: SingleChildScrollView(
         child: Padding(
           padding:  EdgeInsets.all(ScreenUtil.getWidth(context)/10),
           child: Column(
             children: [
               MyTextFormField(
                 intialLabel: '',
                 Keyboard_Type: TextInputType.emailAddress,
                 labelText: 'نوع الشكوى',
                 hintText: 'نوع الشكوى',
                 isPhone: true,
                 validator: (String value) {
                   if (value.isEmpty) {
                     return 'نوع الشكوى';
                   }
                   _formKey.currentState.save();
                   return null;
                 },
                 onSaved: (String value) {
                 },
               ),
               MyTextFormField(
                 intialLabel: '',
                 Keyboard_Type: TextInputType.emailAddress,
                 labelText: 'عنوان الشكوى',
                 hintText: 'عنوان الشكوى',
                 isPhone: true,
                 validator: (String value) {
                   if (value.isEmpty) {
                     return 'عنوان الشكوى';
                   }
                   _formKey.currentState.save();
                   return null;
                 },
                 onSaved: (String value) {
                 },
               ),
               MyTextFormField(
                 intialLabel: '',
                 Keyboard_Type: TextInputType.emailAddress,
                 labelText: 'الرسالة',
                 hintText: 'الرسالة',
                 isPhone: true,
                 validator: (String value) {
                   if (value.isEmpty) {
                     return 'الرسالة';
                   }
                   _formKey.currentState.save();
                   return null;
                 },
                 onSaved: (String value) {
                 },
               ),
               SizedBox(height: 25 ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Center(
                     child: GestureDetector(
                       child: Container(
                         width: ScreenUtil.getWidth(context) / 3,
                         padding: const EdgeInsets.all(5.0),
                         decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
                         child: Center(
                           child: AutoSizeText(
                             getTransrlate(context, 'save'),
                             overflow: TextOverflow.ellipsis,
                             maxFontSize: 14,
                             maxLines: 1,
                             minFontSize: 10,
                             style:
                             TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                           ),
                         ),
                       ),
                       onTap: () {

                       },
                     ),
                   ),
                   Center(
                     child: GestureDetector(
                       child: Container(
                         width: ScreenUtil.getWidth(context) / 3,
                         padding: const EdgeInsets.all(5.0),
                         decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                         child: Center(
                           child: AutoSizeText(
                             getTransrlate(context, 'close'),
                             overflow: TextOverflow.ellipsis,
                             maxFontSize: 14,
                             maxLines: 1,
                             minFontSize: 10,
                             style:
                             TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                           ),
                         ),
                       ),
                       onTap: () {

                       },
                     ),
                   ),
                 ],
               ),
               SizedBox(height: 25 ),
             ],
           ),
         ),
       ),
     ),);
  }
}
