import 'StatusDetail.dart';
import 'date.dart';

class Status {
  var id;
  Date? date;
  StatusDetail? status;

  Status({this.id, this.date, this.status});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    status =
    json['status'] != null ? new StatusDetail.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}



