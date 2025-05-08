import 'package:driver/Logic/Controllers/order-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Models/documents.dart';
import 'package:driver/View/Pages/Main/message-admin.dart';
import 'package:driver/View/Pages/Map/accepted-page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../Models/marker-name.dart';
import '../../Models/order.dart';
import '../../Models/services.dart';
import '../../Public/api-urls.dart';
import '../../Public/images.dart';
import '../../View/Pages/Auth/register.dart';
import '../../View/Pages/Map/home-map.dart';
import '../Helpers/api-methods.dart';
import '../Helpers/token-methods.dart';
import 'app-controller.dart';
import 'map-controller.dart';

class MainController extends GetxController {
  static List<Services> services =<Services>[];
  static List<Services> subServices=<Services>[];
  static List<Services> servicesShow=<Services>[];

  static String?support;
  static String?terms;
  static Document document=Document();
  RxInt disOrigin=0.obs;
  RxInt disDes=0.obs;
  static RxString homePage='map'.obs;
  static RxBool isChecked = false.obs;


  @override
  void onInit() async {
    super.onInit();
    tracker(2);
  }

  static getInitData()async{
    var token=await Token.getToken();
    print(token);

    if(token==null ){
      Navigator.pushAndRemoveUntil(Get.context!,MaterialPageRoute(builder: (context) => RegisterPage()), (route) => false);
    }
    else{
      await UserController.getUser();
      await MainController.getDocuments();
      if( UserController.user.value.statusDriver?.id!=null){
        await OrderController.allOrders();
        await OrderController.myOrder();
        await getServices();
        await getInfoSupport();
        // UserController.getMyLocation();
        checkPage();
      }
      else{
        Navigator.pushAndRemoveUntil(Get.context!,MaterialPageRoute(builder: (context) => RegisterPage()), (route) => false);
      }
    }
  }
  static checkPage(){
    // if(UserController.user.value.statusDriver?.id==null){
    //   Navigator.push(Get.context!, MaterialPageRoute(builder: (builder) => RegisterPage()));
    // }
    if(UserController.user.value.statusDriver?.id!=null && UserController.user.value.statusDriver?.id!=2){
      Navigator.pushAndRemoveUntil(Get.context!,MaterialPageRoute(builder: (context) => MessageAdmin()), (route) => false);

    }
    else if(UserController.user.value.statusDriver?.id!=null && UserController.user.value.statusDriver?.id==2 && OrderController.acceptedOrder.length==0){
      Navigator.pushAndRemoveUntil(Get.context!,MaterialPageRoute(builder: (context) => HomeMap()), (route) => false);

    }
    else if(UserController.user.value.statusDriver?.id!=null && UserController.user.value.statusDriver?.id==2 && OrderController.acceptedOrder.length!=0){
      Order order=OrderController.acceptedOrder[OrderController.indexAcceptOrder.value];
      MapApiController.setMarker(order.originLat, order.originLong, MarkerName.origin, origin_icon);
      MapApiController.setMarker(order.destinationLat, order.destinationLong, MarkerName.des, destination_icon);
      if(order.info.length>2){
        MapApiController.setMarker(order.info[2].lat, order.info[2].long, MarkerName.secDes, sec_destination_icon);
      }
      MapApiController.setCameraPosition(order.originLat, order.originLong,);

      Navigator.pushAndRemoveUntil(Get.context!,MaterialPageRoute(builder: (context) => AcceptedPage(OrderController.acceptedOrder,OrderController.indexAcceptOrder.value)), (route) => false);

    }
  }
  static changePage(){

     if( OrderController.acceptedOrder.length==0){
    Navigator.pushAndRemoveUntil(Get.context!,MaterialPageRoute(builder: (context) => HomeMap()), (route) => false);

    }
    else {
       Order order=OrderController.acceptedOrder[OrderController.indexAcceptOrder.value];
       MapApiController.setMarker(order.originLat, order.originLong, MarkerName.origin, origin_icon);
       MapApiController.setMarker(order.destinationLat, order.destinationLong, MarkerName.des, destination_icon);
       if(order.info.length>2){
         MapApiController.setMarker(order.info[2].lat, order.info[2].long, MarkerName.secDes, sec_destination_icon);
       }
       MapApiController.setCameraPosition(order.originLat, order.originLong,);

       Navigator.pushAndRemoveUntil(Get.context!,MaterialPageRoute(builder: (context) => AcceptedPage(OrderController.acceptedOrder,OrderController.indexAcceptOrder.value)), (route) => false);

    }
  }
  static getServices() async {
    AppController.startLoading(['get-service']);

    var response=await RestApi.get(servicesUrl);
    RestApi.responseHandler(response:response,successCallback:  (){
      services=[];
      servicesShow=[];
      subServices=[];
      for(var json in response!.data['data']){
        Services model=Services.fromJson(json);
        services.add(model);
        if(model.show==true)
          servicesShow.add(model);
        if(model.service!=null)
          subServices.add(model);
        print('service length>>>>${MainController.services.length}');
      }
    },printResponse: true);
    AppController.finishLoading(['get-service']);

  }
  static getTerms() async {
    AppController.startLoading(['get-terms']);

    var response=await RestApi.get(termsUrl);
    RestApi.responseHandler(response:response,successCallback:  (){

      terms=response!.data['data'];
    },printResponse: true);
    AppController.finishLoading(['get-terms']);

  }
  static getInfoSupport() async {

    var response=await RestApi.get(infoSupportUrl);
    RestApi.responseHandler(response:response,successCallback:  (){
      support=response!.data['data']['phone'];
    },printResponse: true);
  }
  static getDocuments({bool changePage=false}) async {
    AppController.startLoading(['info-documents']);

    var response=await RestApi.get(getDocumentsUrl);
    RestApi.responseHandler(response:response,successCallback:  (){
      // document=Document();
      document=Document.fromJson(response!.data['data']);
    });
    AppController.finishLoading(['info-documents']);
    AppController.finishLoading(['verify']);

  }

  // static getInfoSupport({bool changePage=false}) async {
  //   var response=await RestApi.get(getDocumentsUrl);
  //   RestApi.responseHandler(response:response,successCallback:  (){
  //     // document=Document();
  //     document=Document.fromJson(response!.data['data']);
  //   });
  //
  // }
  RxDouble latUser = 32.645759.obs;
  RxDouble longUser = 51.667654.obs;


  tracker(int distanceFilter) {
    print("start tracker");
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: distanceFilter,
      // timeLimit: const Duration(seconds: 10),
    );
    print("start live function");
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) async {
      print("start listen to change postition ${position}");
      if (position == null) {
        latUser.value = 33.312805;
        longUser.value = 44.361488;
      } else {
        latUser.value = position.latitude;
        longUser.value = position.longitude;
        // if(OrderController.order.value.originLat!=null){
        //   int disDes=calculateDistance(latUser.value,longUser.value,double.parse(OrderController.order.value.destinationLat.toString()),double.parse(OrderController.order.value.destinationLong.toString()),);
        //   int disOrigin=calculateDistance(latUser.value,longUser.value,double.parse(OrderController.order.value.originLat.toString()),double.parse(OrderController.order.value.originLong.toString()),);
        //       if(disDes<=5){
        //         showSnackbar(snackTypes.success, 'شما به مقصد رسیدید.');
        //       }
        //       if(disOrigin<=5){
        //         showSnackbar(snackTypes.success, 'شما به مبدا رسیدید.');
        //       }
        // }
      }
      setLatLong(latUser.value,longUser.value);

      update();
    });
  }

  setLatLong(double lat,double long)async {
    var response = await RestApi.post(setLocationUrl,body: {'lat':lat,'long':long});
    RestApi.responseHandler(
        response: response,
        successCallback: () {
          UserController.user.value.lat=response!.data['data']['lat'];
          UserController.user.value.long=response.data['data']['long'];

        },printResponse: true);
  }

  int calculateDistance(double lat1,double lon1,double lat2,double lon2){
    double dis=Geolocator.distanceBetween(lat1,lon1,lat2,lon2);
    int meter=double.parse(dis.toStringAsFixed(2)).round();
    print('meter>>>$meter');
    return meter ;
  }
}