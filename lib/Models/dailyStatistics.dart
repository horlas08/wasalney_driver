import 'package:driver/Models/date.dart';
import 'package:driver/Models/rate.dart';

class Statistics {
  int? id;
  var price;
  var accepted;
  var percent;
  var canceled;
  var distance;
  Date? date;



  Statistics(
      {this.price,this.id, this.accepted, this.percent, this.canceled, this.date});

  Statistics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    accepted = json['accepted'];
    percent = json['percent'];
    canceled = json['canceled'];
    distance = json['distance'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
  }
}