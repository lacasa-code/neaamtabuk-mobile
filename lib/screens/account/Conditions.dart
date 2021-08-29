import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';

class Conditions extends StatelessWidget {
  const Conditions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            width: ScreenUtil.getWidth(context) / 2,
            child: AutoSizeText(
              'الشروط والأحكام',
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
              Text('الشروط العامة للتسجيل',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: 15,),

              Text(
                ' \n المستخدم العادي \n• التسجيل بواسطة بريد الكتروني ورقم جوال  \n• تسجيل عنوان للشحن\nالبائع \n• تسجل بواسطة اسم الشركة او المؤسسة    \n• ارفاق السجل التجاري    \n• ارفاق الرقم الضريبي    \n• ارفاق ضريبة القيمة المضافة \n• ارفاق العنوان الوطني \n• ارفاق عناوين الشحن   \n• الموافقه علي التعاقد  المستخدم العادي  ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15,),
              Container(height: 1, color: Colors.black12,),
              SizedBox(height: 15,),
              Text('كيفيّة استخدام التطبيق',style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15,),

              Text('نمنحك ترخيصاً غير قابلٍ للتحويل أو الإلغاء لكي تستخدم الموقع تحت الشروط والأحكام المحدّدة. وتكمن غاية هذا الترخيص في التسوّق لشراء سلعٍ شخصية تُباع على الموقع. ويُحظر الاستخدام لأغراضٍ تجارية أو الاستخدام باسم أي طرفٍ ثالث، باستثناء ما تمّ السماح به من قبلنا بوضوح وشفافية سلفاً. ويؤدي أي خرق لهذه الشروط والأحكام إلى إلغاء فوري للترخيص الممنوح في هذه الفقرة من دون أي سابق إنذار.يتمّ عرض المحتوى المقدّم في هذا الموقع لأغراضٍ إعلامية لا غير. وتعود التوضيحات التي تخصُّ المنتجات والتي أُعرب عنها في هذا الموقع إلى البائعين أنفسهم فهي ليست من تأليفنا. وتعود التعليقات أو الآراء التي أُعرب عنها في هذا الموقع إلى كلّ فردٍ نشرها وبالتالي لا تعكس آراءنا.تتطلب بعض الخدمات والميّزات ذات الصلة التي قد تكون متوفرةَ على الموقع التسجيل أو الاشتراك فيها. وباختيارك التسجيل أو الاشتراك في أيّةٍ من هذه الخدمات أو المّيزات ذات الصلة، فإنّك توافق على تقديم معلومات دقيقة وحالية عن نفسك وعلى تحديثها على الفور إذا طرأت أيّة تغييرات. ويتحمّل كلّ مستخدمٍ للموقع وحده مسؤولية حفظ كلمات السرّ أو المرور أو غيرها من أساليب التعريف سليمةً وآمنة. وتقع كامل المسؤولية على عاتق صاحب الحساب بالنسبة إلى جميع النشاطات التي تحدث بموجب كلمة سرّه أو ضمن حسابه. بالإضافة إلى ذلك، يجدرُ بك تبلغينا عن أي استخدام غير مصرّح به لكلمة سرّك أو لحسابك. أخيراً، إنّ الموقع ليس مسؤولاً بتاتاً، بشكلٍ مباشرٍ أو غير مباشرٍ وبأي شكلٍ من الأشكال، عن أيّة خسارة أو أضرارٍ من أي نوع، قد تنتجُ عن فشلك في الامتثال لهذا القسم أو لها علاقةٌ به على الأقلّ.وإنّك توافق، أثناء عملية التسجيل، على تلقي رسائل إلكترونية ترويجية من قِبل الموقع. ويمكنك في وقتٍ لاحق إلغاء هذا الخيار وعدم تلقي رسائل إلكترونية ترويجية.',style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15,),
              Container(height: 1, color: Colors.black12,),
              SizedBox(height: 15,),
              Text(
                'مشاركات المستخدم',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15,),

              Text('إنّ كلّ مشاركاتك على الموقع و/أو تقديماتك لنا، بما في ذلك ولكن ليس على سبيل الحصر، الأسئلة والانتقادات والتعليقات والاقتراحات (جميع "المشاركات" إجمالاً) تصبح ملكنا الوحيد والحصري، ولا تعود بأي حالٍ من الأحوال ملكاً لك. وفضلاً عن الحقوق التي تنطبق على أي نوع من المشاركات، وبمجرّد أنّك تشاركنا بتعليقاتك أو انتقاداتك على الموقع، فإنّك تمنحنا أيضاً حقّ استخدام الإسم الذي تعرضه المرتبط مباشرةً بالنقد أو التعليق أو أية محتويات أخرى. ولا يحقّ لك استخدام عنوان مزيّف لبريدك الإلكتروني، أو الادّعاء بأنّك شخصٌ آخر، أو محاولة تضليلنا أو أي طرف ثالث فيما يتعلّق بأصالة وموثوقيّة أيّة من المشاركات. ويجوز لنا إزالة أيّة من المشاركات أو تعديلها، غير أننا لسنا ملزمين بذلك.',style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15,),
              Container(height: 1, color: Colors.black12,),
              SizedBox(height: 15,),
              Text(
                'مشاركات المستخدم',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15,),

              Text(
               "${getTransrlate(context, 'webContant')}"
                ,style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 15,),

            ],
          ),
        ),
      ),
    );
  }
}
