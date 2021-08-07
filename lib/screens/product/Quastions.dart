import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/question_model.dart';
import 'package:flutter_pos/screens/product/writeQuastions.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/screen_size.dart';

class Qeastionsdialog extends StatefulWidget {
  List<Question> _question;
  int id;

  Qeastionsdialog(this._question, this.id);

  @override
  _QeastionsdialogState createState() => _QeastionsdialogState();
}

class _QeastionsdialogState extends State<Qeastionsdialog> {
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
                      'جميع الأسئلة',
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  widget._question.isEmpty
                      ? Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                SvgPicture.asset(
                                  "assets/icons/reload.svg",
                                  width: ScreenUtil.getWidth(context) / 3,
                                  color: Colors.black12,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(getTransrlate(context, 'EmptyQuastion')),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget._question.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/User Icon.svg',
                                        color: Colors.grey,
                                        height: 35,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:
                                                ScreenUtil.getWidth(context) /
                                                    1.4,
                                            child: Text(
                                              '${widget._question[index].bodyQuestion}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${widget._question[index].createdAt} بواسطة ${widget._question[index].userName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                widget._question[index].answer == null
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.message_outlined,
                                              color: Colors.grey,
                                              size: 35,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: ScreenUtil.getWidth(
                                                            context) /
                                                        1.6,
                                                    child: Text(
                                                      '${widget._question[index].answer ?? ''}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '${widget._question[index].updatedAt} بواسطة ${widget._question[index].vendor.vendorName}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                Container(
                                  height: 1,
                                  color: Colors.black12,
                                )
                              ],
                            );
                          },
                        ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                                  context: context,
                                  builder: (_) =>
                                      WriteQuastionsdialog(widget.id))
                              .then((value) {
                            API(context)
                                .get('prod/all/questions/${widget.id}')
                                .then((value) {
                              setState(() {
                                widget._question =
                                    Question_model.fromJson(value).data;
                              });
                            });
                          });
                        },
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 2.5,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit_outlined,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: ScreenUtil.getWidth(context) / 4,
                                child: AutoSizeText(
                                  'كتابة سؤال',
                                  overflow: TextOverflow.ellipsis,
                                  maxFontSize: 14,
                                  maxLines: 1,
                                  minFontSize: 10,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ],
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
