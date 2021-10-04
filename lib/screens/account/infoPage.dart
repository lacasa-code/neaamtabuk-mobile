import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/screen_size.dart';

class Info extends StatelessWidget {
  const Info({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            width: ScreenUtil.getWidth(context) / 2,
            child: AutoSizeText(
              'عنوان رئيسي',
              minFontSize: 10,
              maxFontSize: 16,
              maxLines: 1,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'عناوين فرعية: ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: 15,),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: Colors.orange,size: 14,),
                    SizedBox(width: 5,),
                    Text(
                      'هذا النص هو مثال',
                      style: TextStyle(fontSize: 16,color: Colors.orange, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 5,),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: Colors.orange,size: 14,),
                    SizedBox(width: 5,),
                    Text(
                      'هذا النص هو مثال',
                      style: TextStyle(fontSize: 16,color: Colors.orange, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: Colors.orange,size: 14,),
                    SizedBox(width: 5,),
                    Text(
                      'هذا النص هو مثال',
                      style: TextStyle(fontSize: 16,color: Colors.orange, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: Colors.orange,size: 14,),
                    SizedBox(width: 5,),
                    Text(
                      'هذا النص هو مثال',
                      style: TextStyle(fontSize: 16,color: Colors.orange, fontWeight: FontWeight.w500),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 15,),

              Text(
                'عنوان رئيسي: ',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15,),
              Container(height: 1, color: Colors.black12,),
              SizedBox(height: 15,),
              Text(
                'عناوين فرعية: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15,),

              Text(
                'هذا النص هو مثال لنص يمكن ان يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك ان تولد مثل هذا النص او العديد من النصوص الاخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق. إذا كنت تحتاج إلى عدد اكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي اخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الاحيان ان يطلع على صورة حقيقية لتصميم الموقع. ومن هنا وجب على المصمم ان يضع نصوصا مؤقتة على التصميم ليظهر للعميل الشكل كاملاً، ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15,),
              Container(height: 1, color: Colors.black12,),
              SizedBox(height: 15,),
              Text(
                'عناوين فرعية: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15,),

              Text(
                'هذا النص هو مثال لنص يمكن ان يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك ان تولد مثل هذا النص او العديد من النصوص الاخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق. إذا كنت تحتاج إلى عدد اكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي اخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الاحيان ان يطلع على صورة حقيقية لتصميم الموقع. ومن هنا وجب على المصمم ان يضع نصوصا مؤقتة على التصميم ليظهر للعميل الشكل كاملاً،دور مولد النص العربى ان يوفر على المصمم عناء البحث عن نص بديل لا علاقة له بالموضوع الذى يتحدث عنه التصميم فيظهر بشكل لا يليق. هذا النص يمكن ان يتم تركيبه على اي تصميم دون مشكلة فلن يبدو وكانه نص منسوخ، غير منظم، غير منسق، او حتى غير مفهوم. لانه مازال نصاً بديلاً ومؤقتاً. هذا النص هو مثال لنص يمكن ان يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك ان تولد مثل هذا النص او العديد من النصوص الاخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق. إذا كنت تحتاج إلى عدد اكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي اخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الاحيان ان يطلع على صورة حقيقية لتصميم الموقع. ومن هنا وجب على المصمم ان يضع نصوصا مؤقتة على التصميم ليظهر للعميل الشكل كاملاً،دور مولد النص العربى ان يوفر على المصمم عناء البحث عن نص بديل لا علاقة له بالموضوع الذى يتحدث عنه التصميم فيظهر بشكل لا يليق. ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
