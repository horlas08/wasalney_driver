import 'date.dart';

class Message{
  var id;
  String?message;
  Date? date;

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    message = json['message'];
  }

}