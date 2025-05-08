import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Models/dailyStatistics.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:flutter/cupertino.dart';

import '../../../../Models/weeklyStatistics.dart';

class DetailReportBox extends StatelessWidget {
  Statistics?model;
  String?date;
  Color?color;

   DetailReportBox(this.model,{this.date,this.color});

  @override
  Widget build(BuildContext context) {
    Widget component(String key,String value){
      return Column(
        children: [
          Text(key,style: AppController.fontStyle(fontTypes.buttonSM, additionalColor2Shade600)),
          Text(value,style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade800)),
        ],
      );
    }
    return model!.accepted!=0?Container(
      width: maxItemWidth,
      // height: 245,
      margin: EdgeInsets.only(top: 10,bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
        boxShadow: [BoxShadow(offset: Offset(6,1),color: blackColor.withOpacity(0.25),spreadRadius: -8,blurRadius: 25)]
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                height: 30,
                decoration: BoxDecoration(
                  color:this.color??additionalColor2Shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text(date=='${AppController.of(context)!.value('today')}'|| date=='${AppController.of(context)!.value('current month')}'?'$date':'${model!.date!.year}/${model!.date!.month}/${model!.date!.day}',style: AppController.fontStyle(fontTypes.captionSM,this.color!=null? whiteColor:additionalColor2Shade700))),
              ),
              Spacer(),
              Img(arrow_left2_icon,width: 25,height: 25,color: additionalColor2Shade800,)
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(' ${model!.accepted}  ${AppController.of(context)!.value('travel')}  ',style: AppController.fontStyle(fontTypes.header5, additionalColor2Shade800),),
              Spacer(),
              Text('${AppController.priceFormat(model!.price)}',style: AppController.fontStyle(model!.price!=0?fontTypes.bodyXL:fontTypes.header6,model!.price!=0? successColor:additionalColor2Shade400),),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text('${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(model!.price!=0?fontTypes.header3:fontTypes.captionSM2, model!.price!=0? successColor:additionalColor2Shade400)),
                ],
              ),
            ],
          ),
          SizedBox(height: 25),
          MyDivider(),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              component('${AppController.of(context)!.value('distance traveled')}', '${model!.distance} ${AppController.of(context)!.value('km')}'),
              Container(width: 1,height: 60,color: additionalColor2Shade200,),
              component('${AppController.of(context)!.value('travel accepted')}', '%${model!.percent}'),
              Container(width: 1,height: 60,color: additionalColor2Shade200,),
              component('${AppController.of(context)!.value('canceled trip')}', '${model!.canceled}'),
            ],
          ),
        ],
      ),
    ):Container(
      width: maxItemWidth,
      height: 175,
      margin: EdgeInsets.only(top: 10,bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
          boxShadow: [BoxShadow(offset: Offset(6,1),color: blackColor.withOpacity(0.25),spreadRadius: -8,blurRadius: 25)]
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                height: 30,
                // width: 65,
                decoration: BoxDecoration(
                  color: this.color??additionalColor2Shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text(date=='${AppController.of(context)!.value('today')}'?'$date':'${model!.date!.year}/${model!.date!.month}/${model!.date!.day}',style: AppController.fontStyle(fontTypes.overlineSM,this.color!=null? whiteColor:additionalColor2Shade700))),
              ),
              SizedBox(width: 10),
              Text('0 ${AppController.of(context)!.value('travel')}',style: AppController.fontStyle(fontTypes.header5, additionalColor2Shade400),),
              Spacer(),
              Text('${AppController.priceFormat(model!.price)}',style: AppController.fontStyle(model!.price!=0?fontTypes.bodyXL:fontTypes.header6,model!.price!=0? successColor:additionalColor2Shade400),),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 10),
                  Text(' ${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(model!.price!=0?fontTypes.header6:fontTypes.bodySM, model!.price!=0? successColor:additionalColor2Shade400)),
                ],
              ),
            ],
          ),
          SizedBox(height: 25),
          MyDivider(),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              component('${AppController.of(context)!.value('distance traveled')}', '${model!.distance} ${AppController.of(context)!.value('km')}'),
              Container(width: 1,height: 60,color: additionalColor2Shade200,),
              component('${AppController.of(context)!.value('travel accepted')}', '%0'),
              Container(width: 1,height: 60,color: additionalColor2Shade200,),
              component('${AppController.of(context)!.value('canceled trip')}', '${model!.canceled}'),
            ],
          ),
        ],
      ),
    );
  }
}
