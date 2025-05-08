class PayType {
  int? id;
  String? title;
  String? createdAt;
  String? updatedAt;

  PayType(
      {this.id,
        this.title,
        this.createdAt,
        this.updatedAt});

  PayType.fromJson(Map<String, dynamic> json) {
    id =int.parse( json['id'].toString());
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}