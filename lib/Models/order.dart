import 'package:driver/Logic/Controllers/order-controller.dart';
import 'package:driver/Models/documents-detail.dart';
import 'package:driver/Models/services.dart';
import 'package:get/get.dart';
import 'StatusDetail.dart';
import 'date.dart';
import 'order-detail-truck.dart';
import 'pay.dart';
import 'route-info.dart';
import 'status.dart';
import 'user.dart';

class Order {
  var id;
  String? cancelStatus;
  User? driver;
  var rate;
  String? code;
  PayType? payType;
  Date? date;
  Date? updatedAt;
  Date? dateReserve;
  String?timeReserve;
  String? destinationAddress;
  String? destinationLong;
  String? destinationLat;
  String? originAddress;
  String? originLong;
  String? originLat;
  String? stopTime;
  String? stopTime2;
  bool comeback=true;
  String? userId;
  String? name;
  String? mobile;
  int step=1;
  var price;
  var netPrice;
  var economic;

  var private;
  var traffic;
  var reserve;
  var helper;
  var cooler;
  // String?gender;

  String? titleState;
  DocDetail? state;
  OptionPrivate? optionPrivate;
  List<RouteInfo> info=[];
  List<Status> status=<Status>[];
  List<String> orderStatuse=[];
  MotorOrderDetail motorOrderDetail=MotorOrderDetail();
  MotorOrderDetail? motorDetail;
  OrderDetailTruck orderDetailTruck=OrderDetailTruck();
  OrderDetailTruck? truckDetail;

  var deliveryId;
  StatusDetail? type;
  String paySide='مقصد';

  Order(
      {this.id,
        this.cancelStatus,
        this.driver,
        this.rate,
        this.code,
        this.date,
        this.payType,
        this.economic,
        this.destinationAddress,
        this.destinationLong,
        this.destinationLat,
        this.originAddress,
        this.originLong,
        this.originLat,
        this.stopTime,
        this.userId,
        this.name,
        this.mobile,
        this.price,
        this.titleState,
        this.deliveryId,
      });

  Order.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    cancelStatus = json['cancel_status'];
    rate = json['rate'] != null ? json['rate'] : null;
    code = json['code'];
    // gender = json['gender']!=null?json['gender']:null;
    updatedAt = json['updated_at'] != null
        ? new Date.fromJson(json['updated_at'])
        : null;
    dateReserve = json['date_reserve'] != null
        ? new Date.fromJson(json['date_reserve'])
        : null;

    timeReserve = json['time_reserve'] != null
        ? (json['time_reserve'])
        : null;
    payType = json['pay_type'] != null
        ? new PayType.fromJson(json['pay_type'])
        : null;
    state = json['state'] != null
        ? new DocDetail.fromJson(json['state'])
        : null;

    // motorOrderDetail = (json['orderDetail'] != null ? new MotorOrderDetail.fromJson(json['orderDetail']) : null)!;
    destinationAddress = json['destination_address'];
    destinationLong = json['destination_long'];
    destinationLat = json['destination_lat'];
    originAddress = json['origin_address'];
    originLong = json['origin_long'];
    originLat = json['origin_lat'];
    stopTime = json['stop_time'];
    stopTime2 = json['stop_time2'];
    // if(json['comeback']==true){
    comeback =json['comeback'] ;
    print('comeback is>>${comeback}');
    // print('comeback is true');
    // }
    // else{
    //   comeback ='ندارد' ;
    //   print('comeback is false');
    //
    // }
    userId = json['user_id'];
    mobile = json['mobile'];
    name = json['name'];
    economic = json['economic'];

    private = json['private'];
    traffic = json['traffic'];
    reserve = json['reserve'];
    helper = json['helper']!=null?json['helper']:false;
    cooler = json['cooler']!=null?json['cooler']:false;

    price = json['price'] != null ? json['price'] : null;
    netPrice = json['net_price']!= null ? json['net_price'] : null;
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;

    if(json['path_info']!=null){
      info=[];
      for(var i in json['path_info'])
        info.add(RouteInfo.fromJson(i));
    }
    if(json['status']!=null){
      orderStatuse=[];
      status=[];
      for(var state in json['status']){
        Status s=Status.fromJson(state);
        status.add(s);
        for(var s in status) {
          orderStatuse.add(s.status!.title!);
        }
      }
      setStatus();
    }
    deliveryId = json['delivery_id'] != null
        ? int.parse(json['delivery_id']['type']['id'].toString())
        : null;
    print('delivery id>>${deliveryId}');
    paySide = json['pay_side'];
    truckDetail = json['truckDetails'] != null
        ? new OrderDetailTruck.fromJson(json['truckDetails'])
        : null;
    motorDetail = json['motorDetails'] != null
        ? new MotorOrderDetail.fromJson(json['motorDetails'])
        : null;

    optionPrivate = json['privateDetails'] != null
        ? new OptionPrivate.fromJson(json['privateDetails'])
        : null;

  }

  Order.fromJsonSoket(Map<String, dynamic> json) {
    id = int.parse((json['id']).toString());
    print('id order>>${id}');
    cancelStatus = json['cancel_status'];
    rate = json['rate'] != null ? json['rate'] : null;
    code = json['code'];
    payType = json['pay_type'] != null
        ? new PayType.fromJson(json['pay_type'])
        : null;
    // motorOrderDetail = (json['orderDetail'] != null ? new MotorOrderDetail.fromJson(json['orderDetail']) : null)!;
    destinationAddress = json['destination_address'];
    destinationLong = json['destination_long'];
    netPrice = json['net_price']!= null ? json['net_price'] : null;
    destinationLat = json['destination_lat'];
    originAddress = json['origin_address'];
    originLong = json['origin_long'];
    originLat = json['origin_lat'];
    stopTime = json['stop_time'];
    stopTime2 = json['stop_time2'];
    if(json['comeback']=='1'){
      comeback =true;
      print('comeback is true');
    }
    else{
      comeback =false ;
      print('comeback is false');

    }
    userId = json['user_id'];
    name = json['name'];
    // gender = json['gender']!=null?json['gender']:null;
    if(json['economic']=='1'){
      economic = true;
    }
    else{
      economic = false;
    }

    if(json['private']=='1'){
      private = true;
    }
    else{
      private = false;
    }

    if(json['traffic']=='1'){
      traffic = true;
    }
    else{
      traffic = false;
    }

    if(json['reserve']=='1'){
      reserve = true;
    }
    else{
      reserve = false;
    }

    if(json['cooler']=='1'){
      cooler = true;
    }
    else{
      cooler = false;
    }

    if(json['helper']=='1'){
      helper = true;
    }
    else{
      helper = false;
    }

    mobile = json['mobile'];
    price = json['price'] != null ? json['price'] : null;
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    updatedAt = json['updated_at'] != null ? new Date.fromJson(json['updated_at']) : null;
    dateReserve = json['date_reserve'] != null
        ? new Date.fromJson(json['date_reserve'])
        : null;
    if(json['path_info']!=null){
      info=[];
      for(var i in json['path_info'])
        info.add(RouteInfo.fromJson(i));
    }

    if(json['status']!=null){
      orderStatuse=[];
      status=[];
      for(var state in json['status']){
        Status s=Status.fromJson(state);
        status.add(s);
        for(var s in status) {
          orderStatuse.add(s.status!.title!);
        }
      }
      setStatus();
    }
    state = json['state'] != null
        ? new DocDetail.fromJson(json['state'])
        : null;
    deliveryId = json['delivery_id'] != null
        ? int.parse(json['delivery_id']['type']['id'].toString())
        : null;
    print('delivery id>>${deliveryId}');
    paySide = json['pay_side'];
    truckDetail = json['truckDetails'] != null
        ? new OrderDetailTruck.fromJson(json['truckDetails'])
        : null;
    motorDetail = json['motorDetails'] != null
        ? new MotorOrderDetail.fromJson(json['motorDetails'])
        : null;
    optionPrivate = json['privateDetails'] != null
        ? new OptionPrivate.fromJson(json['privateDetails'])
        : null;
    print('privateDetails is>>${json['privateDetails']}');
  }
  setStatus() {
    print('set status>>>');
    if(status.last.status!.id==1){
      step=1;
      print('step is>>>${step}');
    }
    else if(status.last.status!.id==2){
      step=2;
      print('step is>>>${step}');

    }else if(status.last.status!.id==3){
      step=3;
      print('step is>>>${step}');

    }else if(status.last.status!.id==4){
      step=4;
      print('step is>>>${step}');

    }else if(status.last.status!.id==5){
      step=5;
      print('step is>>>${step}');

    }else if(status.last.status!.id==6){
      step=6;
      print('step is>>>${step}');

    }
  }
}
class MotorOrderDetail {
  int? id;

  String? priceProduct;
  String? typeProduct;

  MotorOrderDetail(
      {this.id,

        this.priceProduct,
        this.typeProduct});

  MotorOrderDetail.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());

    priceProduct = json['price_parcel']!=null?json['price_parcel']:null;
    typeProduct = json['type_parcel']!=null?json['type_parcel']['title']:null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price_parcel'] = this.priceProduct;
    data['type_parcel'] = this.typeProduct;

    return data;
  }
}
class OptionPrivate{
  String? timePrivate;
  String? duration;
  Date? datePrivate;
  OptionPrivate.fromJson(Map<String, dynamic> json){
    this.timePrivate=json['time_start'];
    this.datePrivate=json['date_start']!=null? new Date.fromJson(json['date_start'])
        : null;
    print('date private>>${json['date_start']}');
    this.duration=json['duration'];
  }
}




