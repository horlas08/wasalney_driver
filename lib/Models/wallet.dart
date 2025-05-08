import 'date.dart';
import 'documents-detail.dart';

class Wallet {
  var id;
  Date? date;
  var price;
  DocDetail? type;
  String? description;
  String? title;
  String? code;

  Wallet(
      {this.id,
        this.date,
        this.price,
        this.type,
        this.description,
        this.title});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    code = json['code'] != null ?json['code'] : null;
    price =
    json['price'] != null ? json['price'] : null;
    type = json['type'] != null ? new DocDetail.fromJson(json['type']) : null;
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    data['description'] = this.description;
    data['title'] = this.title;
    return data;
  }
}