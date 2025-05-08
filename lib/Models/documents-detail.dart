class DocDetail {
  int? id;
  String? title;

  DocDetail({this.id, this.title});

  DocDetail.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

