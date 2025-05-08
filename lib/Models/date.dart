class Date {
  String? main;
  String? preview;

  String? time;
  var year;
  var month;
  var day;
  var dayOfWeek;
  var hour;
  var minute;
  var date;
  String? nameOfDay;
  String? nameOfMonth;

  Date(
      {this.main,
        this.preview,

        this.time,
        this.year,
        this.month,
        this.day,
        this.dayOfWeek,
        this.nameOfDay,
        this.nameOfMonth,
        this.hour,
        this.minute});

  Date.fromJson(Map<String, dynamic> json) {
    main = json['main'];
    preview = json['preview'];
    date = json['date'];
    time = json['time'];
    dayOfWeek = json['dayOfWeek'];
    print('month is>>${json['month']}');
    print('month is>>${json['dayOfWeek']}');

    month =json['month']!=null? int.parse(json['month'].toString()):null;
    print('month is>>${month}');
    day = json['day'];
    year = json['year'];
    setNameOfDay();
    setNameOfMonth(month);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['main'] = this.main;
    data['preview'] = this.preview;

    data['time'] = this.time;
    data['year'] = this.year;
    data['month'] = this.month;
    data['day'] = this.day;
    data['dayOfWeek'] = this.dayOfWeek;
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    return data;
  }

  setNameOfDay(){
    switch(dayOfWeek){
      case 0:
        return nameOfDay='احد';
      case 1:
        return nameOfDay='اثنین';
      case 2:
        return nameOfDay='ثلاثاء';
      case 3:
        return nameOfDay='اربعاء';
      case 4:
        return nameOfDay='خميس';
      case 5:
        return nameOfDay='جمعة';
      case 6:
        return nameOfDay='سبت';
    }
  }
  setNameOfMonth(dynamic month){
    switch(month){
      case 1:

        return nameOfMonth='ژانویه';
      case 2:
        return nameOfMonth='فوریه';
      case 3:
        return nameOfMonth='مارس';
      case 4:
        return nameOfMonth='آوریل';
      case 5:
        return nameOfMonth='می';
      case 6:
        return nameOfMonth='ژوئن';
      case 7:
        return nameOfMonth='جولای';
      case 8:
        return nameOfMonth='آگوست';
      case 9:
        return nameOfMonth='سپتامبر';
      case 10:
        return nameOfMonth='اکتبر';
      case 11:
        return nameOfMonth='نوامبر';
      case 12:
        return nameOfMonth='دسامبر';
    }
  }
}