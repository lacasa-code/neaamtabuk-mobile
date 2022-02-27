import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';

class LostPassword extends StatefulWidget {
  const LostPassword({Key key}) : super(key: key);

  @override
  _LostPasswordState createState() => _LostPasswordState();
}

class _LostPasswordState extends State<LostPassword> {
  final _formKey = GlobalKey<FormState>();

  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset(
        "assets/images/logo.png",
        width: ScreenUtil.getWidth(context) / 4,
      )),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil.getWidth(context) / 10),
            child: Column(
              children: [
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'mail'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'mail');
                    }else if (!RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                        .hasMatch(value)) {
                      return getTransrlate(context, 'invalidemail');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    email = value;
                  },
                ),
                SizedBox(height: 25),
                Center(
                  child: GestureDetector(
                    child: Container(
                      width: ScreenUtil.getWidth(context) / 3,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green)),
                      child: Center(
                        child: AutoSizeText(
                          getTransrlate(context, 'changePassword'),
                          overflow: TextOverflow.ellipsis,
                          maxFontSize: 14,
                          maxLines: 1,
                          minFontSize: 10,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        API(context).post('user/forget/password',
                            {"email": email}).then((value) {
                          if (value != null) {
                            if (value.containsKey('error')) {
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      ResultOverlay(value['error']));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      ResultOverlay(value['data']));
                            }
                          }
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
