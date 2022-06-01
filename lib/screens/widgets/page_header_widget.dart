import 'package:flutter/material.dart';
import 'package:flutter_pos/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/shared_prefs_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as util;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageHeaderWidget extends StatefulWidget {
  const PageHeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  State<PageHeaderWidget> createState() => _PageHeaderWidgetState();
}

class _PageHeaderWidgetState extends State<PageHeaderWidget> {
  ProviderControl theme;
  SharedPreferences sharedPreferences;
  var isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      theme = Provider.of<ProviderControl>(
        context,
      );
      sharedPreferences =
          Provider.of<SharedPrefsProvider>(context, listen: false).prefs;
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var roleId = sharedPreferences.getString('role_id');
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(45),
        left: 25,
        right: 25,
        bottom: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTransrlate(
                    context,
                    TimeOfDay.now().format(context).toLowerCase().contains('pm')
                        ? 'good_night'
                        : 'good_morning'),
                style: TextStyle(
                  fontSize: util.ScreenUtil().setSp(20),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              PopupMenuButton(
                itemBuilder: (_) => [
                  CheckedPopupMenuItem(
                    value: 'ar',
                    checked: theme.local == 'ar',
                    child: Text(
                      'العربية',
                    ),
                  ),
                  CheckedPopupMenuItem(
                    value: 'en',
                    checked: theme.local == 'en',
                    child: Text(
                      'English',
                    ),
                  ),
                ],
                child: Icon(
                  Icons.language,
                  color: theme.getColor(),
                ),
                onSelected: (v) {
                  if (theme.local == v) {
                    return;
                  }
                  theme.setLocal(v);
                  MyApp.setlocal(context, Locale(theme.getlocal(), ''));
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setString('local', theme.local);
                  });
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 50,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${sharedPreferences.getString('user_name')} ',
                    style: TextStyle(
                      fontSize: util.ScreenUtil().setSp(17),
                      color: theme.getColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        "${roleId == '1' ? "${getTransrlate(context, 'Donor')}" : roleId == '2' ? "${getTransrlate(context, 'representative')}" : "${getTransrlate(context, 'Beneficiary')}"}",
                    style: TextStyle(
                      fontSize: util.ScreenUtil().setSp(12),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
