import 'order.dart';

class SocketNotification {
  String? token;
  String? type;
  Order ?order;
  String? isShowAlert;
  String? isAudioAlert;
  String? message;
  String? status;

  SocketNotification(
      {this.token, this.type, this.order, this.isShowAlert, this.message});

  SocketNotification.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
    order = json['rate'] != null ? new Order.fromJson(json['data']) : null;
    isShowAlert = '0';
    isAudioAlert = json['is_audio_alert'];
    message = json['message'];
    status = 'success';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['type'] = this.type;
    data['is_show_alert'] = this.isShowAlert;
    data['message'] = this.message;
    return data;
  }
}
