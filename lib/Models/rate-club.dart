
import 'documents-detail.dart';

class  RateClub{
  int? id;
  int? cost;
  int? count;
  int?price;
  DocDetail? type;

  RateClub(
      {this.id,
        this.cost,
        this.count,
        this.type});

  RateClub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cost = json['cost'];
    count = json['count'];
    type = json['type'] != null ? new DocDetail.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['count'] = this.count;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}

