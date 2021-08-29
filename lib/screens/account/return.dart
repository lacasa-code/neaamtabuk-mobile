import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';

class Return extends StatelessWidget {
  const Return({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            width: ScreenUtil.getWidth(context) / 2,
            child: AutoSizeText(
              '${getTransrlate(context, 'return')}',
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
                '${getTransrlate(context, 'return')}',
                style: TextStyle(
                  fontSize: 20,
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
              Text('في حاله اختلاف مواصفات المنتج عن المعروض يتم الاسترجاع بدون أي تحمل على المشتري ويتم تحميل البائع رسوم الشحن • في حاله عدم وجود أي اختلاف بين مواصفات المنتج المستلم والمعروض يتحمل المشتري قيمة الشحن مع مراعاه هل المنتج قابل للإرجاع ومراعاة قوانين حمايه المستهلك',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'يمكنك الاتصال بنا',
                style: TextStyle(
                  fontSize: 16,
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
                ' يُمكنك طلب استرجاع أو استبدال المنتجات في حال استلامك منتج فيه خلل او عيب مصنعي او كسر, او غير مطابق للمنتج الذي قمت بشرائه  منتجاتنا، أو وجود عيب في المنتج نتيجة عمليات الشحن أو التغليف، أو عند استلامك لمنتج غير مطابق لطلبكم بكل بساطة وسهولة قدر الإمكان، خلال 5 أيام من تاريخ عملية الشراء. نحن نوفر لكم سياسة لاسترجاع واستبدال المنتجات وفقًا للضوابط الآتية',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'شروط الاسترجاع والاستبدال',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'نحن في متجر قفير للتسوق أونلاين نسعد دائماً لتقديم أرقى مستويات الخدمة ويلزم للاستفادة من سياسة الاسترجاع والاستبدال لدينا توافر الشروط الآتية:-	يقبل البائعين لدينا في متجر قفير طلبات الإسترجاع أو الإستبدال في حال استلامك منتج فيه خلل او عيب مصنعي او كسر, او غير مطابق للمنتج الذي قمت بشرائه  منتجاتنا، أو وجود عيب في المنتج نتيجة عمليات الشحن أو التغليف، أو عند استلامك لمنتج غير مطابق لطلبكم-	يجب أن يكون المنتج في حالته الأصلية غير مستعمل أو غير مفتوح أو منزوع منه الملصقات بالنسبة للمنتجات الإلكترونية أو غير ملبوس للتيشرتات والأحذية.-	يجب أن يكون المنتج مغلفاً في العبوة الأصلية وفي نفس الحالة التي استلمتها.-	يجب إرفاق فاتورة الشراء الأصلية عند بدء إجراءات استبدال أو استرجاع المنتجات.-	يحق للعميل استرجاع قيمة المنتج أو استبداله بمنتج آخر حسب اختياره.-	يرجى العلم بإن هذه السياسة والشروط غير مطبقة على المعارض-	عند طلب استرجاع منتج فإنه يخضع لعملية فحص من قبل إدارة  متجر قفير للتأكد من حالته، وتتم الموافقة على استرجاع المبلغ بعد التأكد من أن حالة المنتج متطابقة مع سياسة الاسترجاع.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'مراجعة طلب الاستبدال أو الاسترجاع:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'في حال كان الإرجاع أو الاستبدال لسبب وجود عيب في المنتج ففي هذه الحالة يقوم المتجر بمراجعة الطلب وفحص المنتج، فإذا تبين للمتجر مخالفة المشتري لشروط وأحكام هذه السياسة وأن العيب قد لحق بالمنتج نتيجة خطأ المشتري فإنه يحق لنا رفض طلب الإرجاع أو الاستبدال أو تحميل المشتري قيمة الضرر الذي لحق بالمنتج.	في حال كان الإرجاع أو الاستبدال بسبب عيب في المنتج أو عدم مطابقته لمواصفات وتفاصيل البيع، يقوم البائع بفحص المنتج، فإذا ثبت أن العيب يرجع إلى المنتج أو عدم المطابقة، يتحمل البائع تكاليف الشحن والإرجاع والاستبدال.	يقبل البائعين لدينا في متجر قفير طلبات الإسترجاع أو الإستبدال في حال استلامك منتج فيه خلل او عيب مصنعي او كسر, او غير مطابق للمنتج الذي قمت بشرائه  منتجاتنا، أو وجود عيب في المنتج نتيجة عمليات الشحن أو التغليف، أو عند استلامك لمنتج غير مطابق لطلبكم-	يجب أن يكون المنتج في حالته الأصلية غير مستعمل أو غير مفتوح أو منزوع منه الملصقات بالنسبة للمنتجات الإلكترونية أو غير ملبوس للتيشرتات والأحذية.-	يجب أن يكون المنتج مغلفاً في العبوة الأصلية وفي نفس الحالة التي استلمتها.-	يجب إرفاق فاتورة الشراء الأصلية عند بدء إجراءات استبدال أو استرجاع المنتجات.-	يحق للعميل استرجاع قيمة المنتج أو استبداله بمنتج آخر حسب اختياره.-	يرجى العلم بإن هذه السياسة والشروط غير مطبقة على المعارض-	عند طلب استرجاع منتج فإنه يخضع لعملية فحص من قبل إدارة  متجر قفير للتأكد من حالته، وتتم الموافقة على استرجاع المبلغ بعد التأكد من أن حالة المنتج متطابقة مع سياسة الاسترجاع.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'مواعيد العمل والاتصال',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'يمكننا مساعدتك والتواصل معك في خلال أوقات الدوام الرسمية من الاحد إلى الخميس من الساعة .9 صباحاً حتى الساعة 9 مساءاً بتوقيت مملكة العربية السعودية.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'سياسة الاسترجاع',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${getTransrlate(context, 'webreturn')}',
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
