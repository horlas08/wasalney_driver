
class Services {
  var id;
  String? descriptionWaiting;
  String? titleWaiting;
  var imageWaiting;
  String? hurryPrice;
  var backPrice;
  var price;
  var decreasePercent;
  var basePrice;
  String? title;
  TypeService?type;
  Services?service;
  var image;
  var economicImage;
  String? token;
  var show;

  String? createdAt;
  String? updatedAt;

  Services(
      {this.id,
        this.descriptionWaiting,
        this.titleWaiting,
        this.imageWaiting,
        this.hurryPrice,
        this.backPrice,
        this.price,
        this.basePrice,
        this.title,
        this.type,
        this.image,
        this.decreasePercent,
        this.createdAt,
        this.token,
        this.economicImage,
        this.updatedAt});

  Services.fromJson(Map<String, dynamic> json) {
    id = int.parse((json['id']).toString());
    descriptionWaiting = json['description_waiting'];
    titleWaiting = json['title_waiting'];
    imageWaiting = json['image_waiting'];
    economicImage = json['economic_icon'];
    hurryPrice = json['hurry_price'];
    decreasePercent = json['decrease_percent'] !=null?int.parse((json['decrease_percent'] ).toString()):null;
    backPrice = json['back_price']  ;
    type = json['type'] != null
        ? new TypeService.fromJson(json['type'])
        : null;
    service = json['service'] != null
        ? new Services.fromJson(json['service'])
        : null;
    show=json['show'];

    price =
    json['price']  != null ?json['price']  : null;
    basePrice = json['base_price']  ;
    title = json['title'];
    image = json['image']  ;
    token = json['token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description_waiting'] = this.descriptionWaiting;
    data['title_waiting'] = this.titleWaiting;
    if (this.imageWaiting != null) {
      data['image_waiting'] = this.imageWaiting ;
    }
    data['hurry_price'] = this.hurryPrice;

    if (this.backPrice != null) {
      data['back_price'] = this.backPrice ;
    }
    if (this.price != null) {
      data['price'] = this.price ;
    }
    if (this.basePrice != null) {
      data['base_price'] = this.basePrice ;
    }
    data['title'] = this.title;
    if (this.image != null) {
      data['image'] = this.image ;
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TypeService{
  var id;
  String?title;
  TypeService.fromJson(Map<String, dynamic> json) {
    this.title=json['title'];
    this.id=int.parse(json['id'].toString());
  }

}