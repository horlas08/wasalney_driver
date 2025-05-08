import 'dart:convert';

import 'package:driver/Public/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:package_info_plus/package_info_plus.dart';

class AppController extends GetxController{

  static TabController? tabController;
  static TabController? tabControllerOrders;

  // a controller for manage loading , theme mode , localization and implement public functions of application
  // static getVersion()async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   version= packageInfo.version;
  // }

  static String mapKey= 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImYzODIxMTVkNDYyNTBhYjMxMTY4YTYwYTNmYTg1ZTFlMDllOWRkY2ZiZmIwN2YzZTk5YTE1NGQ1ZGMxZWM5YjgwNmU0OTAzN2QwYzI4MmI0In0.eyJhdWQiOiIyNTIxMSIsImp0aSI6ImYzODIxMTVkNDYyNTBhYjMxMTY4YTYwYTNmYTg1ZTFlMDllOWRkY2ZiZmIwN2YzZTk5YTE1NGQ1ZGMxZWM5YjgwNmU0OTAzN2QwYzI4MmI0IiwiaWF0IjoxNzAxNjg3OTA2LCJuYmYiOjE3MDE2ODc5MDYsImV4cCI6MTcwNDE5MzUwNiwic3ViIjoiIiwic2NvcGVzIjpbImJhc2ljIl19.gVbaqZoXHPl9OkKqud5D-NGMwWQFVFxWrpmYnhYpQe99kGSl81vme7VxqpyXT9A8UrmF7VlX_n7uNDhpyxZQyAUrBtYJZZ10GGUV16KlPU16Cju7Dpb9PA6LwkR0ZLbeH-nd7mqk58gF5BUIDE-9oFEXPVbSla1LEqsRbf_oGnwdnIhsCgJ5Tg3vAs07WEET2m-euwhhnkbrLtvDbcdRqtXrmzlx3BDxJXtOdMQVq-KGCijjLO6aSnvaZJx_tO5i3gFhx3rpGahTPS8mSQTVWx0wqdpbcirbLn645nZ0_KS9inNi5Dp0Blfs1ica6lgFs0yP2G5_SVClpKXZZRgggA';


  static RxBool isLoading=false.obs;
  static RxList<String> loadingList=<String>[].obs;

  static late Locale locale;
  static Map<dynamic, dynamic> _localizedValues = new Map();

  static Map<String,String>farsiAlphabet={
    '01': "الف",
    '02': "ب",
    '03': "پ",
    '04': "ت",
    '05': "ث",
    '06': "ج",
    '07': "چ",
    '08': "ح",
    '09': "خ",
    '10': "د",
    '11': "ذ",
    '12': "ر",
    '13': "ز",
    '14': "ژ",
    '15': "س",
    '16': "ش",
    '17': "ص",
    '18': "ض",
    '19': "ط",
    '20': "ظ",
    '21': "ع",
    '22': "غ",
    '23': "ف",
    '24': "ق",
    '25': "ک",
    '26': "گ",
    '27': "ل",
    '28': "م",
    '29': "ن",
    '30': "و",
    '31': "ه",
    '32': "ی"
  };
  static setNameOfDay(dynamic dayOfWeek){
    switch(dayOfWeek){
      case 0:
        return 'سبت';
      case 1:
        return 'احد';
      case 2:
        return 'اثنین';
      case 3:
        return 'ثلاثاء';
      case 4:
        return 'اربعاء';
      case 5:
        return 'خميس';
      case 6:
        return 'جمعة';
    }
  }
  static setNameOfMonth(dynamic month){
    switch(month){
      case 1:

        return 'ژانویه';
      case 2:
        return 'فوریه';
      case 3:
        return 'مارس';
      case 4:
        return 'آوریل';
      case 5:
        return 'می';
      case 6:
        return 'ژوئن';
      case 7:
        return 'جولای';
      case 8:
        return 'آگوست';
      case 9:
        return 'سپتامبر';
      case 10:
        return 'اکتبر';
      case 11:
        return 'نوامبر';
      case 12:
        return 'دسامبر';
    }
  }
  static startLoading(List<String> loadingTag){
    if(loadingTag!='' && loadingTag!=null)
      for( var i=0;i<loadingTag.length;i++)
        loadingList.add(loadingTag[i]);
    print('loadingList>>>${loadingList}');
  }

  static finishLoading(List<String> loadingTag){
    for( var i=0;i<loadingTag.length;i++)
      loadingList.remove(loadingTag[i]);
    print('loadingList>>>${loadingList}');
  }

  static hasLoading(List<String> loadingTag){
    for (var i = 0; i < loadingTag.length; i++){
      if(loadingList.contains(loadingTag[i]))
        return true;
    }
    return false;
  }
  // static RxList<String> loadingList=<String>[].obs;
  // // static late String version;
  //
  // static startLoading(List<String> loadingTag){
  //   if(loadingTag!='' && loadingTag!=null)
  //     for( var i=0;i<loadingTag.length;i++)
  //       loadingList.add(loadingTag[i]);
  //   print('loadingList>>>${loadingList}');
  // }
  //
  // static finishLoading(List<String> loadingTag){
  //   for( var i=0;i<loadingTag.length;i++)
  //     loadingList.remove(loadingTag[i]);
  //   print('loadingList>>>${loadingList}');
  // }
  //
  // static hasLoading(List<String> loadingTag){
  //   if(loadingTag.isEmpty){
  //     return false;
  //   }
  //   else{
  //     for (var i = 0; i < loadingTag.length; i++){
  //       if(loadingList.contains(loadingTag[i]))
  //         return true;
  //     }
  //     return false;
  //   }
  //
  // }

  static fontStyle(fontTypes fontType,Color? itemColor){
    switch(fontType){

      case fontTypes.display1:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w700,fontSize: 64,);
      case fontTypes.display2:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w700,fontSize: 56,);

      case fontTypes.header1:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w700,fontSize: 44,);
      case fontTypes.header2:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w700,fontSize: 40,);
      case fontTypes.header3:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w700,fontSize: 32,);
      case fontTypes.header4:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w500,fontSize: 24,);
      case fontTypes.header5:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w700,fontSize: 20,);
      case fontTypes.header6:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w700,fontSize: 16,);
      case fontTypes.header7:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w600,fontSize: 20,);

      case fontTypes.bodyXL:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w400,fontSize: 20,);
      case fontTypes.bodyLG:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w400,fontSize: 18,);
      case fontTypes.bodyMD:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w400,fontSize: 16,);
      case fontTypes.bodySM:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w400,fontSize: 14,);

      case fontTypes.captionMD:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w400,fontSize: 12,);
      case fontTypes.captionLG:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w500,fontSize: 14,);
      case fontTypes.captionSM:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w400,fontSize: 10,);
      case fontTypes.captionSM2:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w700,fontSize: 8,);

      case fontTypes.buttonLG:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w500,fontSize: 16,);
      case fontTypes.buttonSM:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w500,fontSize: 14,);

      case fontTypes.overlineLG:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w400,fontSize: 16,);
      case fontTypes.overlineSM:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w700,fontSize: 12,);

      default:
        return TextStyle(color: itemColor,fontWeight: FontWeight.w700,fontSize: 14);
    }

  }
  static priceFormat(var value){
    NumberFormat myFormat = NumberFormat.decimalPattern();
    return myFormat.format(int.parse(value.toString()));
  }

  static priceMilionFormat(var value){
    double price=double.parse((value.toString()))/ 1000000;
    print(price);
    return price;
  }

  AppController(Locale locale) {
    locale = locale;
    _localizedValues = new Map();
  }

  static AppController? of(BuildContext context) {
    return Localizations.of<AppController>(context, AppController);
  }

  String value(String key) {
    return _localizedValues[key] ?? '** $key not found';
  }

  static Future<AppController> load(Locale locale) async {
    AppController translations = new AppController(locale);
    String jsonContent =
    await rootBundle.loadString("assets/locales/${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }
  get currentLanguage => locale.languageCode;
}