// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
// class SubscriberSeries {
//   final String year;
//   final double subscribers;
//   final Color barColor;
//   SubscriberSeries(
//       {
//         required this.year,
//         required this.subscribers,
//         required this.barColor
//       }
//       );
// }
//
// final List<SubscriberSeries> weeklyData = [
//   //   SubscriberSeries(
//   //   year: "${AppController.of(Get.context!)!.value('today')}",
//   //   subscribers:AppController.priceMilionFormat(UserController.weeklyStatistics.value.week1[0].price) ,
//   //   barColor: charts.ColorUtil.fromDartColor(warningLightColor),
//   // ),
//   //   SubscriberSeries(
//   //   year: "${AppController.of(Get.context!)!.value('yesterday')}",
//   //   subscribers: AppController.priceMilionFormat(UserController.weeklyStatistics.value.week1[1].price),
//   //   barColor: charts.ColorUtil.fromDartColor(dominantColorShade500),
//   // ),
//   for(var item in UserController.weeklyStatistics.value.week1)
//     SubscriberSeries(
//       year: "${item.date!.nameOfDay}",
//       subscribers: AppController.priceMilionFormat(item.price),
//       barColor: dominantColorShade500,
//     ),
// ];
//
// final List<SubscriberSeries> monthlyData = [
//   //   SubscriberSeries(
//   //   year: "${AppController.of(Get.context!)!.value('current month')}",
//   //   subscribers:AppController.priceMilionFormat(UserController.monthly[0].price) ,
//   //   barColor: charts.ColorUtil.fromDartColor(warningLightColor),
//   // ),
//   //  SubscriberSeries(
//   //   year: "${AppController.of(Get.context!)!.value('last month')}",
//   //   subscribers: AppController.priceMilionFormat(UserController.monthly[1].price),
//   //   barColor: charts.ColorUtil.fromDartColor(dominantColorShade500),
//   // ),
//   for(var item in UserController.monthly)
//     SubscriberSeries(
//       year: "${item.date!.nameOfMonth}",
//       subscribers: AppController.priceMilionFormat(item.price),
//       barColor: dominantColorShade500,
//     ),
// ];

class CharItem extends StatelessWidget {
  bool isWeekly;
  CharItem(this.isWeekly) : super();

  @override

  Widget build(BuildContext context) {
    // List<CartesianSeries<SubscriberSeries, String>> series = [
    //   ColumnSeries<SubscriberSeries, String>(
    //       dataSource:isWeekly==true? weeklyData:monthlyData,
    //       xValueMapper:  (SubscriberSeries series, _) => series.year,
    //       yValueMapper:  (SubscriberSeries series, _) => series.subscribers,
    //       name: 'Gold',
    //       color: accentColor)
    // ];
    return Container(
      margin: EdgeInsets.only(bottom: 10,top: 10),
      height: 450,
      width: maxItemWidth,
      child: Column(
        children: [
          Container(
            width: maxItemWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(width: 44,child: Text('${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(fontTypes.overlineSM, additionalColor2Shade600),))
              ],
            ),
          ),
          SizedBox(height: 40,),
          Expanded(
              child:isWeekly==true?  BarChart(
                  BarChartData(

                    // maxY: 300.0,
                    barTouchData: BarTouchData(
                      enabled: true,
                    ),

                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            var date = value.toInt() < UserController.weeklyStatistics.value.week1.length
                                ? UserController.weeklyStatistics.value.week1[value.toInt()].date!.nameOfDay
                                : "";
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              space: 16,
                              child:  Text(
                                '${date}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                          reservedSize: 38,
                        ),
                      ),
                      leftTitles:   AxisTitles(
                        sideTitles: SideTitles(

                          getTitlesWidget: (value, meta) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              space: 5,
                              // angle:7 ,
                              child: Text(
                                '${AppController.priceFormat((value*1000000).toInt())}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            );
                          },
                          reservedSize: 40,
                          interval: 10,
                          showTitles: true,
                        ),
                      ),
                      topTitles:  AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      rightTitles:  AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      border: Border(left:  BorderSide(color: blackColor,width: 0.2),bottom:  BorderSide(color: blackColor,width: 0.2)),
                      show: true,
                    ),

                    barGroups:[
                      for(var item in UserController.weeklyStatistics.value.week1)
                      BarChartGroupData(
                        x:   UserController.weeklyStatistics.value.week1.indexWhere((element) => element==item),
                        barRods: [
                          BarChartRodData(
                            toY: AppController.priceMilionFormat(item.price),
                            color:accentColor,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(5)),
                            width: 22,
                            borderSide: BorderSide(color: accentColor, width: 2.0),
                          ),
                        ],
                      )
                    ],
                    gridData:  FlGridData(show: false),
                  )
              ) : BarChart(
                  BarChartData(
                    // maxY: 300.0,
                    barTouchData: BarTouchData(
                      enabled: true,
                    ),

                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            var date = value.toInt() < UserController.monthly.length
                                ? (UserController.monthly[value.toInt()].date!.nameOfMonth)
                                : "";
                            return SideTitleWidget(

                              axisSide: meta.axisSide,
                              space: 16,
                              child:  Text(
                                '${date}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                          reservedSize: 38,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          getTitlesWidget: (value, meta) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              space: 5,
                              // angle:7 ,
                              child: Text(
                                '${AppController.priceFormat((value*1000000).toInt())}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            );
                          },
                          reservedSize: 40,
                          interval: 10,
                          showTitles: true,
                        ),
                      ),
                      topTitles:  AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      border: Border(left:  BorderSide(color: blackColor,width: 0.2),bottom:  BorderSide(color: blackColor,width: 0.2)),
                      show: true,
                    ),

                    barGroups:[
                      for(var item in UserController.monthly)
                      BarChartGroupData(
                        x: UserController.monthly.indexWhere((element) => element==item),
                        barRods: [
                          BarChartRodData(
                            toY: AppController.priceMilionFormat(item.price),
                            color:accentColor,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(5)),
                            width: 22,
                            borderSide: BorderSide(color: accentColor, width: 2.0),
                          ),
                        ],
                      )
                    ],
                    gridData:  FlGridData(show: false),
                  )
              )
          ),
        ],
      ),
    );
  }
  BarChartGroupData makeGroupData(
      int x,
      double y,
      ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color:accentColor,
          borderRadius: BorderRadius.zero,
          width: 22,
          borderSide: BorderSide(color: accentColor, width: 2.0),
        ),
      ],
    );
  }
}
// class _ChartData {
//   _ChartData(this.x, this.y);
//
//   final String x;
//   final double y;
// }

