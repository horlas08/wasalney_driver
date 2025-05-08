import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/column-scroll.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/loading.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:driver/View/Components/Pages/Main/chart-item.dart';
import 'package:driver/View/Components/Pages/Main/detail-report-box.dart';
import 'package:driver/View/Components/Pages/Main/shape.dart';
import 'package:driver/View/Components/Pages/Selectors/day-month-selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Components/Header/tab-item.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // print('sadf ${UserController.weeklyStatistics.value.week1}');
    return SafeArea(
      child: Scaffold(
        body:
        Container(
          height: size.height,
          // padding: EdgeInsets.only(bottom: 50),
          child: Shape(175, [
            SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Img(
                          arrow_right_icon,
                          width: 25,
                          height: 25,
                          color: whiteColor,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${AppController.of(context)!.value('performance report')}',
                            style: AppController.fontStyle(
                                fontTypes.header4, whiteColor),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${AppController.of(context)!.value('latest update')}',
                              style: AppController.fontStyle(
                                  fontTypes.bodySM, additionalColor2Shade300)),
                          Loading(loadingName: ['weekly-statistics'],width: 95,color:dominantColorShade700 ,
                            height: 25,getLoadedComponent: ()=>
                                Container(
                                  width: 95,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: dominantColorShade500,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                        '${UserController.weeklyStatistics.value.week1.first.date!.month}/${UserController.weeklyStatistics.value.week1.first.date!.day}',
                                        style: AppController.fontStyle(
                                            fontTypes.bodySM, additionalColor2Shade300),
                                      )),
                                ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

              ],
            )
          ],
              [
                Tabs(pages: [
                  Loading(loadingName: ['weekly-statistics'],height: 200,getLoadedComponent: ()=>
                      ColumnScroll(
                        checkEmptyList:()=> UserController.weeklyStatistics.value.week1.length==0,
                        emptyList: Container(),
                        getLoadedWidgets: ()=> Column(
                            children: [
                              SizedBox(height: 20),
                              Container(
                                width: maxItemWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${AppController.of(context)!.value('net receipt chart')}',
                                        style: AppController.fontStyle(
                                            fontTypes.header4, additionalColor2Shade800)),
                                    // Text('${UserController.weeklyStatistics.value.week1!.first.date!.year}/${UserController.weeklyStatistics.value.week1!.first.date!.month}/${UserController.weeklyStatistics.value.week1!.first.date!.day} - ${UserController.weeklyStatistics.value.week1!.last.date!.year}/${UserController.weeklyStatistics.value.week1!.last.date!.month}/${UserController.weeklyStatistics.value.week1!.last.date!.day}',
                                    //     style: AppController.fontStyle(
                                    //         fontTypes.buttonLG, additionalColor2Shade600)),
                                    Text('${UserController.weeklyStatistics.value.week1.first.date!.preview} - ${UserController.weeklyStatistics.value.week1.last.date!.preview} ',
                                        style: AppController.fontStyle(
                                            fontTypes.buttonLG, additionalColor2Shade600)),
                                  ],
                                ),
                              ),
                              CharItem(true),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${AppController.of(context)!.value('net receipts')}',
                                      style: AppController.fontStyle(
                                          fontTypes.captionLG, additionalColor2Shade600)),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 30,
                                    width: 85,
                                    decoration: BoxDecoration(
                                      color: dominantColorShade100,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: Text('${UserController.weeklyStatistics.value.week1.first.date!.preview}',
                                          style: AppController.fontStyle(
                                              fontTypes.captionLG, additionalColor2Shade700),textAlign: TextAlign.center,)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Container(
                                height: 55,
                                width: 195,
                                decoration: BoxDecoration(
                                  color: dominantColorShade800,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${AppController.priceFormat(UserController.weeklyStatistics.value.week1[0].price)}',
                                      style: AppController.fontStyle(fontTypes.header4, whiteColor),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('${AppController.of(context)!.value('rial')}',
                                            style: AppController.fontStyle(
                                                fontTypes.buttonLG, whiteColor)),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              MyDivider(
                                width: maxItemWidth,
                                color: additionalColor2Shade200,
                              ),
                              Container(
                                  width: maxItemWidth,
                                  child: Row(
                                    children: [
                                      Text(
                                        '${AppController.of(context)!.value('daily report')}',
                                        style: AppController.fontStyle(fontTypes.header4, blackColor),
                                      )
                                    ],
                                  )),
                              SizedBox(height: 15),
                              Container(
                                  width: maxItemWidth,
                                  child: Row(
                                    children: [
                                      Text(
                                        '${AppController.of(context)!.value('current week')}',
                                        style: AppController.fontStyle(fontTypes.header5, blackColor),
                                      )
                                    ],
                                  )),
                              // DetailReportBox(UserController.weeklyStatistics.value.week1[0],date: '${AppController.of(context)!.value('today')}',color: accentColorShade400,),
                              // DetailReportBox(UserController.weeklyStatistics.value.week1[1],date: '${AppController.of(context)!.value('yesterday')}',),
                              for(var item in UserController.weeklyStatistics.value.week1)
                              // Text('${item.date!.year}/${item.date!.month}/${item.date!.day}'),
                                DetailReportBox(item,date: item.date!.preview),
                              Container(
                                  width: maxItemWidth,
                                  child: Row(
                                    children: [
                                      Text(
                                        '${AppController.of(context)!.value('last week')}',
                                        style: AppController.fontStyle(fontTypes.header5, blackColor),
                                      )
                                    ],
                                  )),
                              for(var item in UserController.weeklyStatistics.value.week2)
                                DetailReportBox(item,date: item.date!.preview),
                              SizedBox(height: 300)
                            ]),
                      ),
                  ),

                  Loading(loadingName: ['monthly-statistics'],height: 200,getLoadedComponent: ()=>
                      ColumnScroll(
                        checkEmptyList:()=> UserController.monthly.value.isEmpty,
                        getLoadedWidgets: ()=>
                            Column(
                                children: [
                                  SizedBox(height: 20),
                                  Container(
                                    width: maxItemWidth,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${AppController.of(context)!.value('net receipt chart')}',
                                            style: AppController.fontStyle(
                                                fontTypes.header4, additionalColor2Shade800)),
                                        Text('${UserController.monthly.value.first.date!.preview} - ${UserController.monthly.value.last.date!.preview} ',

                                            style: AppController.fontStyle(
                                                fontTypes.buttonLG, additionalColor2Shade600)),
                                      ],
                                    ),
                                  ),
                                  CharItem(false),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('${AppController.of(context)!.value('net receipts')}',
                                          style: AppController.fontStyle(
                                              fontTypes.captionLG, additionalColor2Shade600)),
                                      SizedBox(width: 10),
                                      Container(
                                        height: 30,
                                        width: 85,
                                        decoration: BoxDecoration(
                                          color: dominantColorShade100,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: Text('${UserController.monthly.value.first.date!.preview}',
                                              style: AppController.fontStyle(
                                                fontTypes.captionLG, additionalColor2Shade700,),textAlign: TextAlign.center,)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    height: 55,
                                    width: 195,
                                    decoration: BoxDecoration(
                                      color: dominantColorShade800,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${AppController.priceFormat(UserController.monthly[0].price)}',
                                          style: AppController.fontStyle(fontTypes.header4, whiteColor),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(' ${AppController.of(context)!.value('rial')}',
                                                style: AppController.fontStyle(
                                                    fontTypes.buttonLG, whiteColor)),
                                            SizedBox(height: 5),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  MyDivider(
                                    width: maxItemWidth,
                                    color: additionalColor2Shade200,
                                  ),
                                  Container(
                                      width: maxItemWidth,
                                      child: Row(
                                        children: [
                                          Text(
                                            '${AppController.of(context)!.value('monthly report')}',
                                            style: AppController.fontStyle(fontTypes.header4, blackColor),
                                          )
                                        ],
                                      )),
                                  SizedBox(height: 15),
                                  Container(
                                      width: maxItemWidth,
                                      child: Row(
                                        children: [
                                          Text(
                                            '${AppController.of(context)!.value('current week')}',
                                            style: AppController.fontStyle(fontTypes.header5, blackColor),
                                          )
                                        ],
                                      )),
                                  // DetailReportBox(UserController.monthly[0],date: '${AppController.of(context)!.value('current month')}',color: accentColorShade400,),
                                  // DetailReportBox(UserController.monthly[1],date: '${AppController.of(context)!.value('last month')}'),
                                  for(var item in UserController.monthly)
                                    DetailReportBox(item,date: item.date!.preview),
                                    SizedBox(height: 300)
                                ]),
                      ),
                  ),
                ]
                ),
              ]),
        ),
      ),
    );
  }
}
