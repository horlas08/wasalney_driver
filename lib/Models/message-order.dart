import 'date.dart';

class MessageOrder{
  int?id;
  // Driver? driver;
  String?messsage;
  Date?createdAt;
  Date?updatedAt;
  bool? driverSent;
  bool? userSent;

  MessageOrder.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    messsage = json['messsage'];
    userSent = json['user_sent'];
    driverSent = json['driver_sent'];
    // driver =json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    updatedAt =json['update_at'] != null ? new Date.fromJson(json['update_at']) : null;
    createdAt =json['create_at'] != null ? new Date.fromJson(json['create_at']) : null;
  }

  MessageOrder.fromJsonSocket(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    messsage = json['messsage'];
    if(json['user_sent']=="1"){
      userSent =true;
    }else{
      userSent =false;
    }
    driverSent = json['driver_sent'];
    // driver =json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    updatedAt =json['update_at'] != null ? new Date.fromJson(json['updated_at']) : null;
    createdAt =json['create_at'] != null ? new Date.fromJson(json['created_at']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messsage'] = this.messsage;
    return data;
  }

}