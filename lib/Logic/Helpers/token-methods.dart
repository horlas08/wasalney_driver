
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/services.dart';

class Token{
  static Future<String?> getToken() async{
    final prefs = await SharedPreferences.getInstance();
    String token=prefs.getString('full-token')??'';
    if(!token.isEmpty){
      return "Bearer " + token;
    }else{
      return null;
    }
  }

  static setToken(String token) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('full-token', token);
  }


  static Future<bool> removeToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('full-token');
  }
  static Future<bool> removeNotifToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('user-notif');
  }


  static Future<String?> getNotifToken() async{
    final prefs = await SharedPreferences.getInstance();
    String notifToken=prefs.getString('user-notif')??'';
    if(!notifToken.isEmpty){
      return notifToken;
    }else{
      return null;
    }
  }

  static setNotifToken(String notifToken) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user-notif', notifToken);
  }

  static Future<String?> getProvinceNotif() async{
    final prefs = await SharedPreferences.getInstance();
    String notifToken=prefs.getString('province-notif')??'';
    if(!notifToken.isEmpty){
      return notifToken;
    }else{
      return null;
    }
  }

  static setProvinceNotif(String notifToken) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('province-notif', notifToken);
  }

  static Future<String?> getServicesToken() async{
    final prefs = await SharedPreferences.getInstance();
    String? servicesToken=prefs.getString('services-notif');
    if(servicesToken!=null){
      return servicesToken;
    }else{
      return null;
    }
  }
  // static setServicesToken(List<Services> services) async{
  //   List<String> servicesToken=[];
  //   for(var service in services){
  //     servicesToken.add(service.token!);
  //   }
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('services-notif', servicesToken);
  // }
  static setServicesToken(String service) async{

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('services-notif', service);
  }
  static removeServicesToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('services-notif');
  }

}