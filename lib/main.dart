import 'dart:io';
import 'package:driver/Logic/Controllers/main-controller.dart';
import 'package:driver/Logic/Controllers/order-controller.dart';
import 'package:driver/Public/config.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Pages/Auth/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'Logic/Controllers/app_localization_delegate.dart';
import 'View/Pages/Main/connection-error.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async{
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyB8oUC1poCOcBYBC8sfT8XY1Gz_LgvbzDM",
      appId: "1:259470122485:web:c8cf1bef51baeb2bd694bc",
      messagingSenderId: "259470122485",
      projectId: "okay-f7073",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: appColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '${appTitle}',
      color: appColor,
      showSemanticsDebugger: false,
      theme: ThemeData(
        fontFamily: 'Estedad',
        primaryColor: appColor,
        primarySwatch:  primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      textDirection: TextDirection.rtl,
      builder: (context, child) => ResponsiveWrapper.builder(
      BouncingScrollWrapper.builder(context, child!),
      defaultScale: true,
      breakpoints: [
        const ResponsiveBreakpoint.resize(450, name: MOBILE),
        const ResponsiveBreakpoint.autoScale(800, name: TABLET),
        const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
      ],
    ),
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale.fromSubtags(languageCode: 'ar'),
        const Locale.fromSubtags(languageCode: 'fa'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocaleLanguage in supportedLocales) {
          if (supportedLocaleLanguage.languageCode == locale!.languageCode &&
              supportedLocaleLanguage.countryCode == locale.countryCode) {
            return supportedLocaleLanguage;
          }
        }
        return supportedLocales.first;
      },
      initialRoute: '/',
      routes: {
        '/':(context)=>Splash(),
        '/networkError':(context)=>ConnectionError(),
        //bank info page
      },
    );
  }
}





