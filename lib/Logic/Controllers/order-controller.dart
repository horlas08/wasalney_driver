import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Models/message-order.dart';
import 'package:driver/Models/order.dart';
import 'package:driver/Public/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Models/marker-name.dart';
import '../../Models/wallet.dart';
import '../../Public/api-urls.dart';
import '../../Public/images.dart';
import '../../View/Components/Pages/Map/finish-bottom-sheet.dart';
import '../../View/Components/Popups/bottom-modal.dart';
import '../../View/Components/Popups/snackbar.dart';
import '../../View/Pages/Main/chat-page.dart';
import '../../View/Pages/Main/orders.dart';
import '../../View/Pages/Map/accepted-page.dart';
import '../../View/Pages/Map/home-map.dart';
import '../Helpers/api-methods.dart';
import 'app-controller.dart';
import 'map-controller.dart';

class OrderController extends GetxController {
  static Rx<int> indexOrder=0.obs;
  static Rx<int> indexEconomicOrder=0.obs;
  static Rx<int> indexAcceptOrder=0.obs;
  static RxList<Order>orders=<Order>[].obs;
  static RxList<Order>economicOrders=<Order>[].obs;
  static RxList<Order> acceptedOrder=<Order>[].obs;
  static RxList<Order> futureOrders=<Order>[].obs;
  static Rx<int> indexfutureOrder=0.obs;
  static RxList<Order> lastOrders=<Order>[].obs;
  static RxList<MessageOrder> messages = <MessageOrder>[].obs;
  static RxString message=''.obs;
  // static Rx<Order> order=Order().obs;
  static var netPrice;
  // static Rx<int> step=1.obs;
   addOrder(data) async {
    print(' data id>>>${data}');
    var response = await RestApi.post(getAddOrderUrl,body: {'id':data});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          Order order=Order.fromJson(response!.data['data']);
          orders.add(order);
          print('orders>>>${orders.length}');
          if(orders.length==1){
            MapApiController.setCameraPosition(order.originLat,order.originLong);

            MapApiController.setMarker(order.originLat, order.originLong, MarkerName.origin, origin_icon);
            MapApiController.setMarker(order.destinationLat, order.destinationLong, MarkerName.des, destination_icon);
            if(order.info.length>2){
              MapApiController.setMarker(order.info[2].lat,order.info[2].long, MarkerName.secDes, MarkerName.secDes);
            }
          }


          if(order.economic==true){
            print('accept order>>${acceptedOrder.length}');
            if(acceptedOrder.length<3)
              economicOrders.add(order);
          }
        },printResponse: true);
    // Order order=Order.fromJsonSoket(data);
      update();
  }
  // static removeOrder(data){
  //   Order order=Order.fromJson(data);
  //   var index=orders.indexWhere((item) => item.id==order.id);
  //   orders.removeAt(index);
  //   if(order.economic==true){
  //     economicOrders.add(order);
  //   }
  // }
  static allOrders() async {
    AppController.startLoading(['all-order']);
    var response = await RestApi.get(ordersListUrl);
    RestApi.responseHandler(
        response: response,
        successCallback: () {
          orders.value=[];
          economicOrders.value=[];
          for(var json in response!.data['data']){
            Order order=Order.fromJson(json);
            orders.add(order);
            if(orders.length==1){
              indexOrder.value=0;
              MapApiController.setCameraPosition(order.originLat, order.originLong);

              MapApiController.setMarker(order.originLat, order.originLong, MarkerName.origin, origin_icon);
              MapApiController.setMarker(order.destinationLat, order.destinationLong, MarkerName.des, destination_icon);
              if(order.info.length>2){
                MapApiController.setMarker(order.info[2].lat,order.info[2].long, MarkerName.secDes, MarkerName.secDes);
              }
            }
            if(order.economic==true){
              print('accept order>>${acceptedOrder.length}');
              if(acceptedOrder.length<3)
                economicOrders.add(order);
            }
          }
          if(orders.length!=0 && orders.length>1 ){
            indexOrder.value=0;
            MapApiController.setCameraPosition(orders[OrderController.indexOrder.value].originLat, orders[OrderController.indexOrder.value].originLong);
            MapApiController.addMarkerOrder(orders[OrderController.indexOrder.value]);
          }
          // Navigator.pushReplacement(Get.context!,
          //     MaterialPageRoute(builder: (builder) => OTPPage()));
        },printResponse: true);
    AppController.finishLoading(['all-order']);
  }

  static acceptAgencyOrder(data) async {
    var response = await RestApi.post(getOrderUrl, body: {'id': data,});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          Order order=Order.fromJson(response!.data['data']);

          // Order order = Order.fromJsonSoket(data);
          AcceptOrderFunction(order);
        });
  }

  static myOrder() async {
    AppController.startLoading(['my-order']);
    var response =
        await RestApi.get(myOrderUrl);
    RestApi.responseHandler(
        response: response,
        successCallback: () {
          acceptedOrder.value=<Order>[];
            for(var json in response!.data['data']){
              Order order=Order.fromJson(json);
              acceptedOrder.add(order);
            }
            if(acceptedOrder.length==1){
              if(UserController.user.value.state==true){
                MapApiController.setCameraPosition(acceptedOrder[OrderController.indexAcceptOrder.value].originLat, acceptedOrder[OrderController.indexAcceptOrder.value].originLong);
                MapApiController.addMarkerOrder(acceptedOrder[OrderController.indexAcceptOrder.value]);
              }
            }
            print('accept orders>>>${acceptedOrder.length}');


        },printResponse: true);
    AppController.finishLoading(['my-order']);
  }

  static updateAcceptOrder(data) async {
    var response = await RestApi.post(getMyOrderUrl,body: {'id':data});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
      Order order = Order.fromJson(response!.data['data']);
      var index = acceptedOrder.indexWhere((item) => item.id == order.id);
      acceptedOrder[index] = order;
      MapApiController.setMarker(
          order.destinationLat, order.destinationLong, MarkerName.des,
          destination_icon);
      if (order.info.length > 2) {
        MapApiController.setMarker(
            order.info[2].lat, order.info[2].long, MarkerName.secDes,
            MarkerName.secDes);
      }
      OrderController.indexAcceptOrder.value = index;
    });
  }

  static updatePayOrder(data) async {
    Order order=Order.fromJson(data);
    var index=acceptedOrder.indexWhere((item) => item.id==order.id);
    acceptedOrder[index]=order;
    netPrice=data['net_price'];
    OrderController.indexAcceptOrder.value=index;
  }

  static deleteOrder(data) async {
    print('accept order length befor>>>${acceptedOrder.length}');
    print('order length befor>>>${orders.length}');
    var response = await RestApi.post(getOrderUrl,body: {'id':data});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
      Order order = Order.fromJson(response!.data['data']);
      // Order order=Order.fromJsonSoket(data);
      var index = orders.indexWhere((item) => item.id == order.id);
      if (index != -1) {
        if (orders.length - 1 == OrderController.indexOrder.value) {
          OrderController.indexOrder.value -= 1;
        }
        orders.removeAt(index);
        print('order length after>>>${orders.value.length}');
        MapApiController.removeAllMarker();

        if (orders.length != 0) {
          MapApiController.setCameraPosition(
              orders[OrderController.indexOrder.value].originLat,
              orders[OrderController.indexOrder.value].originLong);
          MapApiController.addMarkerOrder(
              orders[OrderController.indexOrder.value]);
        }
      }


      var index2 = economicOrders.indexWhere((item) => item.id == order.id);
      if (index2 >= 0) {
        economicOrders.value.removeAt(index2);
        print('economicOrders length>>>${economicOrders.length}');
      }

      if (acceptedOrder.contains(order)) {
        var index = acceptedOrder.indexWhere((item) => item.id == order.id);
        if (index >= 0) {
          if (acceptedOrder.length - 1 == OrderController.indexAcceptOrder.value) {
            if(OrderController.indexAcceptOrder.value>0)
            OrderController.indexAcceptOrder.value -= 1;
            else
              OrderController.indexAcceptOrder.value= 0;

          }
          acceptedOrder.removeAt(index);
          MapApiController.removeAllMarker();
          print('accept order length after>>>${acceptedOrder.length}');
          if (acceptedOrder.length == 0) {
            Navigator.pushAndRemoveUntil(Get.context!,
                MaterialPageRoute(builder: (context) => HomeMap()), (
                    route) => false);
          }
          else {
            MapApiController.setCameraPosition(
                orders[OrderController.indexOrder.value].originLat,
                orders[OrderController.indexOrder.value].originLong);
            MapApiController.addMarkerOrder(
                orders[OrderController.indexOrder.value]);
          }
        }
      }
    },printResponse: true);
  }
  static deleteOrderItem(data) async {
    var response = await RestApi.post(getMyOrderUrl,body: {'id':data});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
      Order order = Order.fromJson(response!.data['data']);
      var index = acceptedOrder.indexWhere((item) => item.id == order.id);
      if (index != -1) {
        if (acceptedOrder.length - 1 ==
            OrderController.indexAcceptOrder.value) {
          OrderController.indexAcceptOrder.value -= 1;
        }
        acceptedOrder.removeAt(index);

        MapApiController.removeAllMarker();

        if (acceptedOrder.length == 0) {
          Navigator.pushAndRemoveUntil(Get.context!,
              MaterialPageRoute(builder: (context) => HomeMap()), (
                  route) => false);
        }
        else {
          MapApiController.setCameraPosition(
              orders[OrderController.indexOrder.value].originLat,
              orders[OrderController.indexOrder.value].originLong);
          MapApiController.addMarkerOrder(
              orders[OrderController.indexOrder.value]);
        }
      }
    },printResponse: true);
  }

  static updateOrderList(data) async {
    var response = await RestApi.post(getOrderUrl,body: {'id':data});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
      Order order = Order.fromJson(response!.data['data']);
      var index = orders.indexWhere((item) => item.id == order.id);
      orders[index] = order;
      //
      // MapApiController.setMarker(order.destinationLat, order.destinationLong, MarkerName.des, destination_icon);
      // if(order.info.length>2){
      //   MapApiController.setMarker(order.info[2].lat,order.info[2].long, MarkerName.secDes, MarkerName.secDes);
      //
      // }
    });
  }

  static acceptOrder(int id) async {
    AppController.startLoading(['accept-order']);
    var response =
        await RestApi.post(acceptOrderUrl,body: {'id':id});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
            netPrice=null;
            Order order=Order.fromJson(response!.data['data']);
            AcceptOrderFunction(order);
        },printResponse: true);
    AppController.finishLoading(['accept-order']);
  }
  static AcceptOrderFunction(Order order) {
    if (order.reserve == true || order.private == true) {
      futureOrders.add(order);
      AppController.tabControllerOrders!.index = 1;
      Navigator.push(Get.context!,
          MaterialPageRoute(builder: (context) => OrdersHistory()));
    }
    else {
      acceptedOrder.add(order);
      if (indexAcceptOrder.value > 0)
        indexAcceptOrder.value += 1;
      Order o = OrderController.acceptedOrder[OrderController.indexAcceptOrder
          .value];
      MapApiController.setMarker(
          o.originLat, o.originLong, MarkerName.origin, origin_icon);
      MapApiController.setMarker(
          o.destinationLat, o.destinationLong, MarkerName.des,
          destination_icon);
      if (o.info.length > 2) {
        MapApiController.setMarker(
            o.info[2].lat, o.info[2].long, MarkerName.secDes,
            sec_destination_icon);
      }
      MapApiController.setCameraPosition(order.originLat, order.originLong,);

      Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(
          builder: (context) =>
              AcceptedPage(OrderController.acceptedOrder,
                  OrderController.indexAcceptOrder.value)), (route) => false);
    }
  }
  static changeStatus(var id,int step,var context) async {
    AppController.startLoading(['change-status']);
    if(step==2){
      var response =
      await RestApi.post(arriveOrderUrl,body: {'id':id});
      RestApi.responseHandler(
          response: response,
          successCallback: () {
            Order order=Order.fromJson(response!.data['data']);
            var index=acceptedOrder.indexWhere((item) => item.id==order.id);
            acceptedOrder[index]=order;

          },printResponse: true);
    }  if(step==3){
      var response =
      await RestApi.post(receiveOrderUrl,body: {'id':id});
      RestApi.responseHandler(
          response: response,
          successCallback: () {
            Order order=Order.fromJson(response!.data['data']);
            var index=acceptedOrder.indexWhere((item) => item.id==order.id);
            acceptedOrder[index]=order;
          },printResponse: true);
    } if(step==4){
      var response =
      await RestApi.post(doneOrderUrl,body: {'id':id});
      RestApi.responseHandler(
          response: response,
          successCallback: () async {
            Order order=Order.fromJson(response!.data['data']);
            print('nettt pricee>>${order.netPrice}');
            var index=acceptedOrder.indexWhere((item) => item.id==order.id);
            // acceptedOrder.removeAt(index);
            acceptedOrder[index]=order;
            showBottomModal(context, 610, FinishBottomSheet(order),dragable: false,close: ()async{
              var index=acceptedOrder.indexWhere((item) => item.id==order.id);
              acceptedOrder.removeAt(index);
              if(acceptedOrder.length==0){
                await allOrders();
                Navigator.pushAndRemoveUntil(Get.context!,MaterialPageRoute(builder: (context) => HomeMap()), (route) => false);
              }
            });
            // order.value=Order();
          },printResponse: true);
    }

    AppController.finishLoading(['change-status']);
  }

  static setRate(var id,int rate) async {
    AppController.startLoading(['set-rate']);
    var response = await RestApi.post(setRateUrl,body: {'id':id,'user_rate':rate});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          Order order=Order.fromJson(response!.data['data']);
          finishTripe(order);
          showSnackbar(snackTypes.success, '${AppController.of(Get.context!)!.value('Your feedback has been successfully saved.')}');

        },printResponse: true);
    AppController.finishLoading(['set-rate']);
  }

  static finishTripe(Order order)async{
    var index=acceptedOrder.indexWhere((item) => item.id==order.id);
    acceptedOrder.removeAt(index);
    if(OrderController.indexAcceptOrder.value!=0)
    OrderController.indexAcceptOrder.value-=1;
    if(acceptedOrder.length!=0){
      print('acepttttt length>>${acceptedOrder.length}');
      Navigator.pop(Get.context!);
    }
    else{
      await allOrders();
      Navigator.pushAndRemoveUntil(Get.context!,MaterialPageRoute(builder: (context) => HomeMap()), (route) => false);

    }
    MapApiController.removeMarker(MarkerName.origin);
    MapApiController.removeMarker(MarkerName.des);
    MapApiController.removeMarker(MarkerName.secDes);
    MapApiController.removeMarker(MarkerName.newDes);
  }
  static cancelOrder(String id) async {
    AppController.startLoading(['cancel']);
    var response = await RestApi.post(cancelOrderUrl,body: {'id':id,});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          Order order=Order.fromJson(response!.data['data']);

          var index=acceptedOrder.indexWhere((item) => item.id==order.id);
          acceptedOrder.removeAt(index);
          showSnackbar(snackTypes.success, '${AppController.of(Get.context!)!.value('The trip was cancelled.')}');
          print('cancel trip>>>>>>>>>');
          if(acceptedOrder.length==0){
            MapApiController.removeAllMarker();
            Navigator.pushAndRemoveUntil(Get.context!,MaterialPageRoute(builder: (context) => HomeMap()), (route) => false);
          }
          else{
            if(OrderController.indexAcceptOrder.value!=0)
            OrderController.indexAcceptOrder.value-=1;

            Order order=OrderController.acceptedOrder[OrderController.indexAcceptOrder.value];
            MapApiController.setMarker(order.originLat, order.originLong, MarkerName.origin, origin_icon);
            MapApiController.setMarker(order.destinationLat, order.destinationLong, MarkerName.des, destination_icon);
            if(order.info.length>2){
              MapApiController.setMarker(order.info[2].lat, order.info[2].long, MarkerName.secDes, sec_destination_icon);
            }
            MapApiController.setCameraPosition(order.originLat, order.originLong,);

            Navigator.pushAndRemoveUntil(Get.context!,MaterialPageRoute(builder: (context) => AcceptedPage(OrderController.acceptedOrder,OrderController.indexAcceptOrder.value)), (route) => false);

          }

        },printResponse: true);
    AppController.finishLoading(['cancel']);
  }

  static getOrder(Order order) async {
    AppController.startLoading(['get-order']);
    var response = await RestApi.post(getMyOrderUrl,body: {'id':order.id,});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          Order order=Order.fromJson(response!.data['data']);
          var index=acceptedOrder.indexWhere((item) => item.id==order.id);
          acceptedOrder[index]=order;
          OrderController.indexAcceptOrder.value=index;
        },printResponse: true);
    AppController.finishLoading(['get-order']);
  }


  static getOrderMessage(var order) async {
    AppController.startLoading(['order-message']);
    Navigator.push(Get.context!, MaterialPageRoute(builder: (context) => ChatPage(order)));
    var response = await RestApi.post(getOrderMessagesUrl, body: {'id':order.id});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          messages.value =[];
          for (var json in response!.data['data']) {
            MessageOrder message = MessageOrder.fromJson(json);
            messages.add(message);
          }
        },
        printResponse: true);
    AppController.finishLoading(['order-message']);
  }

  static futureOrder() async {
    AppController.startLoading(['future-order']);
    var response =
    await RestApi.get(futureOrderUrl);
    RestApi.responseHandler(
        response: response,
        successCallback: () {
          futureOrders.value=<Order>[];
          for(var json in response!.data['data']){
            Order order=Order.fromJson(json);
            futureOrders.add(order);
          }
          print('accept orders>>>${futureOrders.length}');
        },printResponse: true);
    AppController.finishLoading(['future-order']);
  }

  static lastOrder() async {
    AppController.startLoading(['last-order']);
    var response = await RestApi.get(lastOrdersUrl);
    RestApi.responseHandler(
        response: response,
        successCallback: () {
          lastOrders.value=<Order>[];
          for(var json in response!.data['data']){
            Order order=Order.fromJson(json);
            lastOrders.add(order);
          }
          print('lastOrders orders>>>${response.data['data'].length}');
        },printResponse: true);
    AppController.finishLoading(['last-order']);
  }

  static getMessage(var id) async {
    AppController.startLoading(['get-message']);
    // Navigator.push(Get.context!, MaterialPageRoute(builder: (context) => ChatPage()));
    var response = await RestApi.post(getOrderMessageUrl, body: {'id':id});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          MessageOrder message = MessageOrder.fromJson(response!.data['data']);
          messages.add(message);

        },
        printResponse: true);
    AppController.finishLoading(['get-message']);
  }

  static sendMessage(var id) async {
    AppController.startLoading(['send-message']);
    var response = await RestApi.post(sendMessageUrl,body: {'id':id,'message':message.value});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          MessageOrder message=MessageOrder.fromJson(response!.data['data']);
          print('message>>${message.messsage}');
          messages.add(message);
          OrderController.message.value='';
        },
        printResponse: true);
    AppController.finishLoading(['send-message']);
  }

}