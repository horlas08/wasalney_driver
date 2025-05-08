import '../Logic/Controllers/app-controller.dart';
import 'date.dart';
import 'documents-detail.dart';

class CarDetail {
  var id;
  DocDetail? fuelType;
  String? carModel;
  String? yearMade;
  String? color;
  String? plak;
  // List<String> plakMotor=[];
  // String? plakMotor1;
  // String? plakMotor2;
  // String? plak1;
  // String? plak2;
  // String? plak3;
  // String? plak4;

  CarDetail(
      {this.id,
        this.fuelType,
        this.carModel,
        this.yearMade,
        this.color}
      );

  CarDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fuelType = json['fuel_type'] != null
        ? new DocDetail.fromJson(json['fuel_type'])
        : null;
    carModel = json['model'];
    yearMade = json['year_made']!=null?json['year_made']:'';
    // carTag = json['car_tag']!=null?setCarTag(json['car_tag']):'';
    print('car_tag');
    print(json['car_tag']);
    if(json['car_tag']!=null){

      plak=json['car_tag'];

    }
    color = json['color']!=null?json['color']:'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fuelType != null) {
      data['fuel_type'] = this.fuelType!.id;
    }
    if (this.carModel != null) {
      data['model'] = this.carModel;
    }
    data['year_made'] = this.yearMade;
    data['car_tag'] = this.plak;
    data['color'] = this.color;
    return data;
  }

}



