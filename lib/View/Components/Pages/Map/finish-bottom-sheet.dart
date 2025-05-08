import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/order-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Models/order.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/loading.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:driver/View/Pages/Map/home-map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinishBottomSheet extends StatelessWidget {
  Order order;
  FinishBottomSheet(this.order) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20,left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${AppController.of(context)!.value('Do not be tired')}',style: AppController.fontStyle(fontTypes.header6, blackColor),),
              InkWell(
                onTap: (){
                  OrderController.finishTripe(order);
                  },
                child: Container(
                  width: 30,
                    height: 30,
                    child: Img(cancle_icon,width: 13,height: 13,color: blackColor,)),
              )

            ],
          ),
          SizedBox(height: 15),
          Text('${AppController.of(context)!.value('amount')} ${AppController.priceFormat(order.netPrice)}${AppController.of(context)!.value('rials will be added to your credit.')}',style: AppController.fontStyle(fontTypes.buttonLG, blackColor),),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${AppController.of(context)!.value('net receipts of this trip')}',style: AppController.fontStyle(fontTypes.bodyLG, blackColor),),
              Text('${AppController.priceFormat(order.netPrice)} ${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(fontTypes.bodyLG, successColor),),
            ],
          ),
          MyDivider(color: additionalColor2Shade200,margin: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${AppController.of(context)!.value('yesterday net receipts')}',style: AppController.fontStyle(fontTypes.bodyLG, blackColor),),
              UserController.yesterdayReport.price!=null?
              Text('${AppController.priceFormat(UserController.yesterdayReport.price)} ${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(fontTypes.bodyLG, successColor),):
              Text('0 ${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(fontTypes.bodyLG, successColor),),
            ],
          ),
          MyDivider(color: additionalColor2Shade200,margin: 30,),
          Text('${AppController.of(context)!.value('Were you satisfied with your travel companion?')}',style: AppController.fontStyle(fontTypes.header5, blackColor),),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  OrderController.setRate(order.id,1);
                },
                child: Loading( width: 185, height: 145,loadingName: ['set-rate'],getLoadedComponent: ()=>  Container(
                    width: 185,
                    height: 145,
                    decoration: BoxDecoration(
                      color: dominantColorShade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Img(like_icon),
                        SizedBox(height: 20),
                        Text('${AppController.of(context)!.value('satisfied')}',style: AppController.fontStyle(fontTypes.bodyXL, blackColor),)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: (){
                  OrderController.setRate(order.id,0);
                },
                child: Loading( width: 185, height: 145,loadingName: ['set-rate'], getLoadedComponent: ()=> Container(
                    width: 185,
                    height: 145,
                    decoration: BoxDecoration(
                      color: dominantColorShade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Img(dislike_icon),
                        SizedBox(height: 20),
                        Text('${AppController.of(context)!.value('tedious')}',style: AppController.fontStyle(fontTypes.bodyXL, blackColor),)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
