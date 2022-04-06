import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';

class MyTextFormField extends StatelessWidget {
  /// localization hint text ...
  final String hintText;

  final String labelText;
  final String errorText;
  final Function validator;
  final Function onSaved;
  final Function onChange;
  final TextDirection textDirection;
  final Widget suffixIcon;
  final bool isPassword;
  final bool istitle;
  final bool isEmail;
  final List<TextInputFormatter> inputFormatters;

  final int minLines;
  final int maxLines;
  final bool enabled;
  final bool isPhone;
  final Widget prefix;
  final TextInputType keyboard_type;
  final String intialLabel;
  final GestureTapCallback press;
  final FocusNode focus;
  final TextEditingController controller;
  final TextAlign textAlign;
  final bool autoFocus;

  MyTextFormField(
      {this.hintText,
      this.autoFocus = false,
      this.validator,
      this.minLines,
      this.maxLines,
      this.textAlign,
      this.errorText,
      this.enabled,
      this.onSaved,
      this.isPassword = false,
      this.isEmail = false,
      this.isPhone = false,
      this.istitle = false,
      this.labelText,
      this.suffixIcon,
      this.textDirection,
      this.prefix,
      this.keyboard_type,
      this.intialLabel,
      this.inputFormatters,
      this.onChange,
      this.focus,
      this.controller,
      this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          istitle
              ? Container()
              : Text(
                  labelText ?? '',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
          errorText == null
              ? Container()
              : Text(
                  errorText ?? '',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
          istitle
              ? Container()
              : SizedBox(
                  height: 4,
                ),
          TextFormField(
            autofocus: autoFocus,
            textAlign: textAlign ?? TextAlign.start,
            controller: controller,
            focusNode: focus,
            minLines: minLines,
            maxLines: isPassword ? 1 : maxLines,
            inputFormatters: inputFormatters ??
                [
                  new LengthLimitingTextInputFormatter(254),
                ],
            //autofocus: true,
            onTap: press,

            initialValue: intialLabel,
            decoration: InputDecoration(
              fillColor: Colors.white,
              prefixIcon: prefix,
              hintText:
                  hintText == null ? null : getTransrlate(context, hintText),
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
              disabledBorder: OutlineInputBorder(
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
            // autovalidate: true,

            textDirection: textDirection,
            onSaved: onSaved,
            enabled: enabled,
            onChanged: onChange,
            keyboardType: keyboard_type ?? TextInputType.multiline,
          ),
        ],
      ),
    );
  }
}
