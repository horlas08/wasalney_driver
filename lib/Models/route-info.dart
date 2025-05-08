

class RouteInfo {
  var id;
  String? houseNumber;
  String? phone;
  String? description;
  String? address;
  String? long;
  String? lat;
  String? name;
  String? houseNumberDes;
  String? phoneDes;
  String? descriptionDes;
  String? addressDes;
  String? longDes;
  String? latDes;
  String? unitDes;
  String? unit;
  // List<RouteInfo> info=[];
  String? type;

  RouteInfo(
      {this.id,
        this.houseNumber,
        this.phone,
        this.description,
        this.address,
        this.long,
        this.lat,
        this.name,
        this.unit,
        this.type,
        this.houseNumberDes,
        this.phoneDes,
        this.descriptionDes,
        this.addressDes,
        this.longDes,
        this.latDes,
        this.unitDes,
      });

  RouteInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    houseNumber = json['house_number'];
    phone = json['phone'];
    // info = json['info'];
    address = json['address'];
    long = json['long'];
    lat = json['lat'];
    name = json['name'];
    unit = json['unit'];
    type = json['type'];

  }

}