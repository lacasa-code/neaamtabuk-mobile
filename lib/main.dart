import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/screens/splash_screen.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/AppLocalizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  print("base_url: ${GlobalConfiguration().getString('base_url')}");
  SharedPreferences.getInstance().then((prefs) {
    String local = 'ar';
    if (prefs.getString('local') != null) {
      local = prefs.getString('local');
    }
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider<Provider_control>(
        create: (_) => Provider_control(local),
      ),
      ChangeNotifierProvider<Provider_Data>(
        create: (_) => Provider_Data(),
      ),
    ], child: Phoenix(child: DevicePreview(
      enabled: false,
      builder: (context) => MyApp(), // Wrap your app
    ),)));
  });


  // await SentryFlutter.init(
  //
  //       (options) {
  //     options.dsn = 'https://536b9d1a8e014f0dbca91d2f7f5c487a@o551399.ingest.sentry.io/5825146';
  //   },
  //   appRunner: () => runApp(MultiProvider(providers: [
  //     ChangeNotifierProvider<Provider_control>(
  //       create: (_) => Provider_control(),
  //     ),
  //     ChangeNotifierProvider<Provider_Data>(
  //       create: (_) => Provider_Data(),
  //     ),
  //   ], child: Phoenix(child: MyApp()))),
  //
  // );
}

class MyApp extends StatefulWidget {
  static void setlocal(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setlocal(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  void setlocal(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    _locale = Locale(Provider.of<Provider_control>(context, listen: false).local, "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      localeResolutionCallback: (devicelocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == devicelocale.languageCode &&
              locale.countryCode == devicelocale.countryCode) {
            return devicelocale;
          }
        }
        return supportedLocales.first;
      },
      supportedLocales: [
        Locale("ar", ""),
        Locale("en", ""),
      ],
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
        primaryColor: themeColor.getColor(),
        fontFamily: 'Cairo',
        textTheme: TextTheme(
          caption: TextStyle(
              height: 1.5
          ),
          body1: TextStyle(
              height: 1.5
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: themeColor.getColor(),
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
