import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Function validator;
  final Function onSaved;
  final TextDirection textDirection;
  final Widget suffixIcon;
  final bool isPassword;
  final bool istitle;
  final bool isEmail;
  final bool enabled;
  final bool isPhone;
  final Widget prefix;
  final TextInputType keyboard_type;
  final String intialLabel;
  final GestureTapCallback press;

  MyTextFormField(
      {this.hintText,
      this.validator,
      this.enabled,
      this.onSaved,
      this.isPassword = false,
      this.isEmail = false,
      this.isPhone = false,
        this.istitle=false,
      this.labelText,
      this.suffixIcon,
      this.textDirection,
      this.prefix,
      this.keyboard_type,
      this.intialLabel,
      this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          istitle?Container(): Text(labelText??'',style: TextStyle(color: Colors.black,fontSize: 16),),
          istitle?Container():SizedBox(height: 4,),
          TextFormField(
            onTap: press,
            initialValue: intialLabel == null ? '' : intialLabel,
            decoration: InputDecoration(
              fillColor: Colors.white,
              prefixIcon: prefix,
            //  hintText: hintText,
              contentPadding: EdgeInsets.all(10.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1.0),
                borderSide: BorderSide(
                  color: Colors.black12,
                  width: 1.0,
                ),
              ),
              filled: true,
              suffixIcon: this.suffixIcon,
            ),
            obscureText: isPassword ? true : false,
            validator: validator,
            textDirection: textDirection,
            onSaved: onSaved,
            enabled: enabled,
            keyboardType: keyboard_type,
          ),
        ],
      ),
    );
  }
}
