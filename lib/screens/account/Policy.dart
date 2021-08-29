import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';

class Policy extends StatelessWidget {
  const Policy({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            width: ScreenUtil.getWidth(context) / 2,
            child: AutoSizeText(
              '${getTransrlate(context, 'Support')}',
              minFontSize: 10,
              maxFontSize: 16,
              maxLines: 1,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'سياسة الخصوصية',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'بيان سياسة الخصوصية هذا يوضح كيف يستخدم و يحمي متجر قفير  أي معلومات يتم جمعها عند استخدام هذا الموقع. ويلتزم متجر قفير بضمان حماية خصوصيتك ومعلوماتك. حيث سوف يطلب منك تقديم بعض المعلومات التي يمكن التعرف من خلالها على هويتك عند استخدام هذا الموقع، ولن يتم استخدام هذه المعلومات إلا وفقاً لبيان سياسة الخصوصية. علماَ أنه قد تتغير سياسة الخصوصية لمتجر قفير من وقت لآخر عن طريق تحديث هذه الصفحة فيجب عليك مراجعة هذه الصفحة من وقت لآخر للتأكد من مناسبة هذه التغييرات ما يتم جمعه من معلومات',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'قد نقوم بجمع المعلومات التالية :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'الإسممعلومات الإتصال بما في ذلك عنوان البريد الإلكترونيمعلومات ديموغرافية مثل الرمز البريدي ، البضائع المفضلة واهتماماتكمعلومات أخرى ذات صلة لاستطلاعات العملاء و/ أو العروضكيفية استخدام المعلومات المجموعةنحن بحاجة إلى هذه المعلومات لفهم احتياجاتك ولتقديم خدمة أفضل، و على وجه الخصوص للأسباب التالية :',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'حماية المعلومات',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'نحن ملتزمون بضمان حماية معلوماتك الخاصة من الوصول او الكشف عنها من أي جهة غير مصرح لها بذلك ، وضعنا جميع الإجراءات اللازمة ميدانياً وإلكترونياً لحماية وتأمين المعلومات التي يتم جمعها على موقعنا',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'كيف نستخدم ملفات الكوكيز',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'ملفات الكوكيز هي ملفات صغيرة يطلب منك السماح بوضعها على القرص الصلب لجهاز الكمبيوتر الخاص بك. بمجرد الموافقة ، يتم إضافتها مما يساعد  على تحليل حركة المرور على الشبكة و يتيح لك معرفة متى قمت بزيارة موقع معين . ملفات الكوكيز تسمح لتطبيقات الويب للرد عليك كفرد، وعليه يتم تخصيص التطبيق حسب احتياجاتك، معتمداً على خياراتك السابقة والبضائع التي نالت على إعجابك أو لم تنال على رضاك.نحن نستخدم ملفات الكوكيز لتسجيل حركة المرور وتحديد الصفحات التي تم زيارتها، مما يساعدنا على تحليل البيانات حول حركة المرور على الويب وتحسين موقعنا حسب إحتياجات العملاء . نحن فقط نستخدم هذه المعلومات لأغراض التحليل الإحصائي ومن ثم يتم إزالة البيانات من النظام.ملفات الكوكيز تساعدنا على تقديم خدمة أفضل ، من خلال تمكيننا من رصد الصفحات التي تجدها مفيدة ، والتي لم تكن كذلك . ملفات الكوكيز بأي حال لا  تتيح لنا الوصول إلى جهاز الكمبيوتر الخاص بك أو أي معلومات عنك ، وغيرها من البيانات التي لم تختر مشاركتها معنا . يمكنك اختيار قبول أو رفض ملفات الكوكيز .معظم المتصفحات الإلكترونية تقبل ملفات الكوكيز ولكن بإمكانك تعديل إعدادات المتصفح لرفض ملفات الكوكيز اذا كنت تفضل ذلك مما قد يمنعك من الاستفادة الكاملة من الموقع',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'روابط لمواقع أخرى',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'قد يحتوي موقعنا على روابط لمواقع أخرى . نريد لفت إنتباهك بأننا غير مسؤولين عن حماية خصوصية معلوماتك التي قد تقدمها أثناء زيارتك لتلك المواقع ، وهذه المواقع لا تخضع لبيان الخصوصية هذا.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'مشاركة معلوماتك مع أطراف أخرى',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'نحن لا نتاجر ببيع أو توزيع أو تأجير معلوماتك الشخصية لأطراف ثالثة ما لم نحصل على موافقتك أو يقضي به القانون للقيام بذلك. نحن نستخدم معلوماتك الشخصية لإرسال معلومات عن العروض والمستجدات في متجرنا',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
