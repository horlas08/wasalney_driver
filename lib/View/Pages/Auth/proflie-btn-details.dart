import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/loading.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:driver/View/Components/Pages/Main/score-item.dart';
import 'package:driver/View/Components/Pages/Main/shape.dart';
import 'package:driver/View/Pages/Main/report-page.dart';
import 'package:flutter/material.dart';

class ProfileBtnDetails extends StatelessWidget {
  const ProfileBtnDetails({Key? key}) : super(key: key);
  Widget component(String key,String value){
    return Column(
      children: [
        Text(key,style: AppController.fontStyle(fontTypes.buttonSM, additionalColor2Shade600)),
        Text(value,style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade800)),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body:
        Loading(loadingName: ['statistics'],getLoadedComponent: ()=>
          UserController.statistics.value==null?
          Shape(230,

              [
                SizedBox(height: 80),
                ScoreItem()
              ],
              [
                SizedBox(height: 30),
                Img(no_data_icon,width: 280,height: 185),
                SizedBox(height: 20),
                Text('${AppController.of(context)!.value('You have not traveled yet!')}',style: AppController.fontStyle(fontTypes.header6, blackColor),),
                SizedBox(height: 10),
                Text('${AppController.of(context)!.value('(Here you can see the schedule of your trips)')}',style: AppController.fontStyle(fontTypes.captionMD, blackColor),),
              ],
          header: [
            Row(
              children: [
                Container(
                    width: 35,
                    height: 35,
                    child: Img(cancle_icon,width: 13,height: 13,color: whiteColor,onClick: ()=>Navigator.pop(context),))
              ],
            )
            ],):
          Shape(200,
              [
                SizedBox(height: 20),
                ScoreItem()
              ],
              [

                  Container(
                    height: 400,
                    width: maxItemWidth,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(offset: Offset(6,1),color: blackColor.withOpacity(0.25),spreadRadius: -8,blurRadius: 25)]
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 30,
                              width: 65,
                              decoration: BoxDecoration(
                                  color: accentColorShade400,
                                  borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text('${AppController.of(context)!.value('today')}',style: AppController.fontStyle(fontTypes.header6, whiteColor))),
                            ),
                            Spacer(),
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                border: Border.all(width: 3,color: dominantColorShade100),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${AppController.of(context)!.value('number of trips')}',style: AppController.fontStyle(fontTypes.overlineSM, dominantColorShade300)),
                                  Text('${UserController.statistics.value.accepted}',style: AppController.fontStyle(fontTypes.header3, dominantColorShade500)),
                                ],
                              ),
                            ),
                            Spacer(),
                            SizedBox(width: 65,)
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            component('${AppController.of(context)!.value('distance traveled')}', '${UserController.statistics.value.distance} ${AppController.of(context)!.value('km')}'),
                            Container(width: 1,height: 60,color: additionalColor2Shade200,),
                            component('${AppController.of(context)!.value('travel accepted')}', '%${UserController.statistics.value.percent}'),
                            Container(width: 1,height: 60,color: additionalColor2Shade200,),
                            component('${AppController.of(context)!.value('canceled trip')}', '${UserController.statistics.value.canceled}'),
                          ],
                        ),
                        SizedBox(height: 15),
                        MyDivider(color: additionalColor2Shade200,),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text('${AppController.of(context)!.value('net receipts')} :',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade600),),
                            Spacer(),
                            Text('${AppController.priceFormat(UserController.statistics.value.price)}',style: AppController.fontStyle(fontTypes.header5, additionalColor2Shade800),),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(height: 10),
                                Text('${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade600)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        MyDivider(color: additionalColor2Shade200,),
                        SizedBox(height: 20),
                        Btn(btnTypes.primary,text: '${AppController.of(context)!.value('view previous reports')}',onClick: (){
                          UserController.weeklyReport();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportPage()));
                        },)
                      ],
                    ),
                  ),

                SizedBox(height: 200,)
              ],header: [
                Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      child: Img(cancle_icon,width: 13,height: 13,color: whiteColor,onClick: (){
                        Navigator.pop(context);
                      },),
                    )
                  ],
                )
            ],
          ),
            )),
    );
        }
}
