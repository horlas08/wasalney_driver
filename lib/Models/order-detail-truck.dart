import 'package:driver/Models/date.dart';
import 'package:get/get.dart';



class OrderDetailTruck {
  var id;
  String elevatorDestination='لا یوجد';
  String elevatorOrigin='لا یوجد';
  int countFloorsDestination=0;
  RxList<Equipment> equipment=<Equipment>[].obs;
  int countFloorsOrigin=0;
  var priceWorker;
  int? countWorker;
  bool? elevator;
  bool selectOrigin=false;
  bool selectDestination=false;
  Date?date;
  String?time;

  OrderDetailTruck(
      {this.id,
        this.priceWorker,
        this.countWorker,
        this.elevator});

  OrderDetailTruck.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    elevatorDestination = json['elevator_destination']!=null?json['elevator_destination']:'لا یوجد';
    elevatorOrigin = json['elevator_origin']!=null?json['elevator_origin']:'لا یوجد';
    countFloorsDestination = json['count_floors_destination']!=null?int.parse(json['count_floors_destination'].toString()):0;
    countWorker = json['count_worker']!=null?int.parse(json['count_worker'].toString() ) :0 ;
    countFloorsOrigin =json['count_floors_origin']!=null? int.parse(json['count_floors_origin'].toString() ) :0 ;
    priceWorker = json['price_worker']!=null? json['price_worker']  :0 ;
    elevator = json['elevator']!=null?json['elevator']:false;
    date=json['date']!=null?Date.fromJson(json['date']):null;
    time=json['time']!=null?json['time']:null;
    if(json['equipment_detail']!=null&& json['equipment_detail']!=[]){
      equipment=<Equipment>[].obs;
      for(var i in json['equipment_detail'])
        equipment.add(Equipment.fromJson(i));
      print('equpment>>${equipment.length}');
    }
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['id'] = this.id;
//   // data['order_id'] = OrderController.order.value.id;
//   data['elevator_destination'] = this.elevatorDestination;
//   data['date'] = this.date;
//   data['time'] = this.time;
//   data['elevator_origin'] = this.elevatorOrigin;
//   data['count_worker'] = this.countWorker;
//   data['count_floors_destination'] = this.countFloorsDestination;
//   data['count_floors_origin'] = this.countFloorsOrigin;
//   data['price_worker'] = this.priceWorker;
//   data['elevator'] = this.elevator;
//   // if (this.equipment != null) {
//   //   data['equipment_detail'] = this.equipment.map((v) => v.toJson()).toList();
//   //   print('equipment_detail>>${equipment.length}');
//   // }
//   return data;
// }
}

class Equipment{
  var id;
  var count;
  var price;
  String?name;
  Equipment({
    this.id,
    this.count,
    this.price,
    this.name,
  });
  Equipment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    name = json['name']   ;
  }
}



