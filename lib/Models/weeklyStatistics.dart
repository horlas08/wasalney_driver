import 'dailyStatistics.dart';

class WeeklyStatistics{
  List<Statistics> week1=[];
  List<Statistics> week2=[];

  WeeklyStatistics();


  WeeklyStatistics.fromJson(Map<String, dynamic> json) {
    if (json['week1'] != null) {
      week1 = <Statistics>[];
      json['week1'].forEach((v) {
        week1.add(new Statistics.fromJson(v));
      });
      print('week length>>>${week1.length}');
    }
    if (json['week2'] != null) {
      week2 = <Statistics>[];
      json['week2'].forEach((v) {
        week2.add(new Statistics.fromJson(v));
      });
    }
  }
}