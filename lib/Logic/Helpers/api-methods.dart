import 'package:dio/dio.dart';
import 'package:driver/Logic/Helpers/token-methods.dart';
import 'package:driver/Public/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as Get;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../View/Components/Popups/snackbar.dart';

enum requestTypes{
  get,post,put,delete
}
class RestApi {

  static bool isConnected=true;


  static Future<Response?> request(url,{Map<String,dynamic>? data=null, useToken = true,}) async {

    if(await Connectivity().checkConnectivity()==ConnectivityResult.none){
      isConnected=false;
      return null;
    }
    isConnected=true;

    try {
      Dio dio = new Dio();

      var mytoken = null;
      if (useToken) {
        mytoken = await Token.getToken();
        if (mytoken != null) dio.options.headers["authorization"] = mytoken;
      }
      dio.options.headers["Access-Control-Allow-Origin"]=true;
      dio.options.contentType="multipart/form-data";
      print('**apiUrl**>>>>${url}');
      print('**token**>>>>${mytoken}');
      print('**data**>>>>${data}');
      var formData = null;
      if(data!=null){
        formData=FormData.fromMap(data);
      }
      var response;

      switch(formData){
        case requestTypes.get:
          response = await dio.get(url,queryParameters: data,);
          break;
        case requestTypes.post:
          response = await dio.post(url,data: formData,);
          break;
        case requestTypes.put:
          response = await dio.put(url,data: formData,);
          break;
        case requestTypes.delete:
          response = await dio.delete(url,data: formData,);
          break;
      }

      print('>>>Success<<<<');
      return response;
    } catch (e) {
      if (e is DioError && e.response != null) {
        return e.response;
      }else if(e is DioError && e.type==DioErrorType.connectionTimeout) {
        print('>>>>>>>>>>>>>>connectTimeout<<<<<<<<<<<<<<<<');
        isConnected=false;
        return null;
      } else {
        print('apiError>>>${e.toString()}');
        return null;
      }
    }
  }




  static responseHandler({Response? response,Function? successCallback,Function? errorCallback,printResponse=false,popupMessage=true})async{
    if(response==null){
      if(isConnected)
        showSnackbar(snackTypes.error, 'Server Error');
      else
        // if(ModalRoute.of(Get.Get.context!)!.settings.name!='/networkError')
        Navigator.of(Get.Get.context!).pushNamedAndRemoveUntil('/networkError', (route) => false);
    }

    else if(response.statusCode==200 ){
      if(printResponse)
        print('>>>response>>>${response.data}<<<<end response <<<<');
      if(successCallback!=null)
        await successCallback();
    }
    else{
      print('error status code>>>>${response.statusCode} >> ${response}');
      if(popupMessage && response.data!=null && response.data['message']!=null)
        showSnackbar(snackTypes.error,'${response.data['message']??''}');
      if(errorCallback!=null)
        await errorCallback();
    }


  }


  static Future<Response?> get(url, {query, useToken = true}) async {

    if(await Connectivity().checkConnectivity()==ConnectivityResult.none){
      isConnected=false;
      return null;
    }
    isConnected=true;
    try {

      Dio dio = new Dio();
      var mytoken;
      if (useToken) {
        mytoken = await Token.getToken();
        if (mytoken != null) dio.options.headers["authorization"] = mytoken;
      }
      print('***apiUrl***>>>>${url}');
      print('***token***>>>>${mytoken}');
      var response =
      await dio.get(url, queryParameters: query,);
      print('>>>Success<<<<');
      return response;
    }catch (e) {
      if (e is DioError && e.response != null) {
        return e.response;
      }
      else if(e is DioError && e.type==DioErrorType.connectionTimeout) {
        print('>>>>>>>>>>>>>>connectTimeout<<<<<<<<<<<<<<<<');
        isConnected=false;
        return null;
      }
      else {
        print('apiError>>>${e.toString()}');
        return null;
      }
    }
  }

  static Future<Response?> post(url, {body=null, useToken = true}) async {

    if(await Connectivity().checkConnectivity()==ConnectivityResult.none){
      isConnected=false;
      return null;
    }
    isConnected=true;

    try {

      Dio dio = new Dio();

      var mytoken = null;
      if (useToken) {
        mytoken = await Token.getToken();
        if (mytoken != null) dio.options.headers["authorization"] = mytoken;
      }
      dio.options.headers["Access-Control-Allow-Origin"]=true;
      dio.options.contentType="multipart/form-data";
      print('**apiUrl**>>>>${url}');
      print('**token**>>>>${mytoken}');
      print('**body**>>>>${body}');
      var formData = null;
      if(body!=null)
        formData=FormData.fromMap(body);
      var response = await dio.post(url, data: formData,);
      print('>>>Success<<<<');
      return response;
    } catch (e) {
      if (e is DioError && e.response != null) {
        return e.response;
      }else if(e is DioError && e.type==DioErrorType.connectionTimeout) {
        print('>>>>>>>>>>>>>>connectTimeout<<<<<<<<<<<<<<<<');
        isConnected=false;
        return null;
      } else {
        print('apiError>>>${e.toString()}');
        return null;
      }
    }
  }



  static Future<Response?> put(url, {body=null, useToken = true}) async {

    if(await Connectivity().checkConnectivity()==ConnectivityResult.none){
      isConnected=false;
      return null;
    }
    isConnected=true;


    try {

      Dio dio = new Dio();
      var mytoken;
      if (useToken) {
        mytoken = await Token.getToken();
        if (mytoken != null) dio.options.headers["authorization"] = mytoken;
      }
      dio.options.contentType="multipart/form-data";
      print('**apiUrl**>>>>${url}');
      print('**token**>>>>${mytoken}');
      print('**body**>>>>${body}');
      var formData = null;
      if(body!=null)
        formData=FormData.fromMap(body);
      var response = await dio.put(url, data: formData,);
      print('>>>Success<<<<');
      return response;
    } catch (e) {
      if (e is DioError && e.response != null) {
        return e.response;
      }else if(e is DioError && e.type==DioErrorType.connectionTimeout) {
        print('>>>>>>>>>>>>>>connectTimeout<<<<<<<<<<<<<<<<');
        isConnected=false;
        return null;
      } else {
        print('apiError>>>${e.toString()}');
        return null;
      }
    }
  }


  static Future<Response?> delete(url, {body=null, useToken = true}) async {

    if(await Connectivity().checkConnectivity()==ConnectivityResult.none){
      isConnected=false;
      return null;
    }
    isConnected=true;

    try {

      var mytoken;
      Dio dio = new Dio();

      if (useToken) {
        mytoken = await Token.getToken();
        if (mytoken != null) dio.options.headers["authorization"] = mytoken;
      }

      print('***token***>>>>${mytoken}');
      print('***apiUrl***>>>>${url}');
      var formData = null;
      if(body!=null)
        formData=FormData.fromMap(body);
      var response = await dio.delete(url, data: formData);
      print('>>>Success<<<<');
      return response;
    } catch (e) {
      if (e is DioError && e.response != null) {
        return e.response;
      }else if(e is DioError && e.type==DioErrorType.connectionTimeout) {
        print('>>>>>>>>>>>>>>connectTimeout<<<<<<<<<<<<<<<<');
        isConnected=false;
        return null;
      } else {
        print('apiError>>>${e.toString()}');
        return null;
      }
    }
  }


  static Future<bool> download(url, savePath,{useToken = true, options = null}) async {

    if(await Connectivity().checkConnectivity()==ConnectivityResult.none){
      isConnected=false;
      return false;
    }
    isConnected=true;

    try {
      Dio dio = Dio();
      var mytoken;
      if (useToken) {
        mytoken = await Token.getToken();
        if (mytoken != null) dio.options.headers["authorization"] = mytoken;
      }

      print('***token***>>>>${mytoken}');
      await dio.download(url, savePath, options: options, onReceiveProgress: (rec, total) {
        print('>>>>res>>>>${rec}');
        print('>>>>res>>>>${total}');
      });
      print('>>>>complete>>>');
      return true;
    } catch (e) {
      if(e is DioError && e.response != null){
        print(e.response);
      }
      else{
        print(e.toString());
      }
    }
    return false;
  }
}