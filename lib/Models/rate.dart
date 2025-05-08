class Rate {
  int? qty;
  var rate;
  String? level;
  String? message;
  List<dynamic>? details;

  Rate({this.qty,this.message,this.level, this.rate, this.details});

  Rate.fromJson(Map<String, dynamic> json) {
    qty = json['qty']!=null?json['qty']:0;
    rate =json['rate']!=null?double.parse( json['rate'].toString()):0;
    setRateLevel();
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qty'] = this.qty;
    data['rate'] = this.rate;
    data['details'] = this.details;
    return data;
  }
  setRateLevel(){
    if(rate<=2){
      level='طبیعی';
      message='';
    }
    else if(rate>2 && rate<4){
      level='جید';
      message='';

    }
    else if(rate>=4){
      level='ممتاز';
      message='خطوة واحدة نحو التميز بالنجوم الخمسة! ';
    }
  }
}