import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';

import '../../service/api.dart';
import '../../utils/screen_size.dart';

class WriteQuastionsdialog extends StatefulWidget {
  int id;

  WriteQuastionsdialog(this.id);

  @override
  _WriteQuastionsdialogState createState() => _WriteQuastionsdialogState();
}

class _WriteQuastionsdialogState extends State<WriteQuastionsdialog> {
  TextEditingController CommentController=TextEditingController();
bool loading =false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 4),
              height: 72,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Color(0xffCCCCCC),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                  top: 8,
                  left: 24,
                  right: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${getTransrlate(context, 'writequestions')}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff7B7B7B)),
                    ),
                    IconButton(
                        icon: Icon(Icons.close,
                            size: 35, color: Color(0xff7B7B7B)),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    " ${getTransrlate(context, 'Tellquestions')} : ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15,),

                  Container(
                    margin: EdgeInsets.all(8),
                    height: 300,
                    child: TextField(
                      controller: CommentController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        focusColor: Colors.orange,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      loading?CircularProgressIndicator(  valueColor:
                      AlwaysStoppedAnimation<Color>( Colors.orange),):  InkWell(
                        onTap: () {
                          setState(() => loading = true);

                          API(context)
                              .post('user/add/prod/question',
                              {"body_question":CommentController.text,"product_id":widget.id})
                              .then((value) {
                            setState(() => loading = false);

                            if (value != null) {
                              if (value['status_code'] == 201) {
                                Navigator.pop(context);

                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ResultOverlay(value['message']));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ResultOverlay('${value['message'] ??
                                            ''}\n${value['errors']??""}'));
                              }
                            }
                          });
                        },
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 2.5,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey
                              )),
                          child: Center(
                            child: AutoSizeText(
                              '${getTransrlate(context, 'send')}',
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 14,
                              maxLines: 1,
                              minFontSize: 10,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 2.5,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey
                              )),
                          child: Center(
                            child: AutoSizeText(
                              '${getTransrlate(context, 'cancel')}',
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 14,
                              maxLines: 1,
                              minFontSize: 10,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

}
