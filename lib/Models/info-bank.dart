import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Models/documents-detail.dart';

class BankInfo {
  int? id;
  // DocDetail? bank;
  String? name;
  String? shaba;
  String? cartNumber;
  List<String> number=[];
  String?number1;
  String?number2;
  String?number3;
  String?number4;

  BankInfo({this.id, this.name, this.shaba, this.cartNumber});

  BankInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // bank = json['bank'] != null ? new DocDetail.fromJson(json['bank']) : null;
    name = json['name'];
    shaba = json['shaba']!=null?json['shaba']:'';
    cartNumber = json['cart_number'];
    if(json['cart_number']!=null){
      number=[];
      number=json['cart_number'].split("-");
      print('number>>${number.length}');
      number1=number[0];
      number2=number[1];
      number3=number[2];
      number4=number[3];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.bank != null) {
    //   data['bank'] = this.bank!.id;
    // }
    data['name'] = this.name;
    data['shaba'] = this.shaba;
    data['cart_number'] = number4!+'-'+number3!+'-'+number2!+'-'+number1!;
    return data;
  }
}

