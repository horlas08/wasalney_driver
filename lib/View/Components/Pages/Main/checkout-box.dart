import 'dart:math';

import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:flutter/cupertino.dart';

class CheckoutBox extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    bool empty=double.parse(UserController.user.value.removable.toString())>0?false:true;
    return Container(
      width: maxItemWidth,
      height: empty?100:180,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('${AppController.of(context)!.value('net income')}',style: AppController.fontStyle(fontTypes.bodyMD, additionalColor2Shade700),),
                  Row(
                    children: [
                      Text(double.parse(UserController.user.value.removable.toString())>0?'${AppController.priceFormat(UserController.user.value.removable)}':'0',style: AppController.fontStyle(fontTypes.header5, blackColor),),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: 10),
                          Text('${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(fontTypes.bodyMD, additionalColor2Shade700)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 2,
                height: 55,
                color: additionalColor2Shade700,
              ),
              Column(
                children: [
                  Text('${AppController.of(context)!.value('creditor')}',style: AppController.fontStyle(fontTypes.bodyMD, additionalColor2Shade700),),
                  Row(
                    children: [
                      Directionality(
                        textDirection:TextDirection.ltr ,
                          child: Text('${AppController.priceFormat(UserController.user.value.creditUser.value)}',style: AppController.fontStyle(fontTypes.header5, blackColor),)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: 10),
                          Text('${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(fontTypes.bodyMD, additionalColor2Shade700)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          empty?Container():MyDivider(color: additionalColor2Shade300,margin: 15,),
          empty?Container():Btn(btnTypes.primary,text: '${AppController.of(context)!.value('account settlement')}',loadingTag: 'add-money',onClick: (){
            UserController.checkWallet(double.parse(UserController.user.value.creditUser.value.toString()));

          },)
        ],
      ),
    );
  }
}
