import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/Inputs/code-input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../General/loading.dart';

class OTPBox extends StatelessWidget {
  const OTPBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var verifyCode;
    return Container(
      margin: EdgeInsets.only(right: 45,left: 45,top: 40),
      padding: EdgeInsets.only(right: 20,left: 20,bottom: 10,top: 10),
      width: maxItemWidth,
      height: 370,
      decoration: BoxDecoration(
          boxShadow: boxShadow,
          color: whiteColor,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Img(arrow_right_icon,height: 25,width: 25,color: additionalColor2Shade700,
            onClick: (){
              UserController.timer.value=0;
            Navigator.pop(context);
            },
          ),
          SizedBox(height: 15),
          Text('${AppController.of(context)!.value('enter the verification code')}',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
          SizedBox(height: 20),
          Row(
            children: [
              Text('${AppController.of(context)!.value('verification code to mobile number')}',style: AppController.fontStyle(fontTypes.captionMD, additionalColor2Shade700),),
              Text('${UserController.mobile}',style: AppController.fontStyle(fontTypes.captionMD, additionalColor2Shade900),),
              Text('${AppController.of(context)!.value('we sent')}',style: AppController.fontStyle(fontTypes.captionMD, additionalColor2Shade700),),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Text('${AppController.of(context)!.value('Is the mobile number wrong?')}',style: AppController.fontStyle(fontTypes.captionMD, additionalColor2Shade700),),
              InkWell(
                onTap: (){
                  UserController.timer.value=0;
                  Navigator.pop(context);
                },
                  child: Text('${AppController.of(context)!.value('edit')}',style: AppController.fontStyle(fontTypes.captionMD,dominantColorShade400),)),
            ],
          ),
          SizedBox(height: 20),
          CodeInput(onComplete: (code)async{
            verifyCode=code;
            await UserController.verify(verifyCode);
          }),
          SizedBox(height: 10),
          Btn(btnTypes.black,text: '${AppController.of(context)!.value('registration')}',onClick: ()async{
           await UserController.verify(verifyCode);
          },),
          SizedBox(height: 20),
          Obx( () {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${AppController.of(context)!.value('Did not get the code?')}',style: AppController.fontStyle(fontTypes.captionMD, additionalColor2Shade700),),
                InkWell(
                    onTap: (){
                      if(UserController.timer.value==0)
                        UserController.login(false);
                    },
                    child: UserController.timer.value>0?Text('00:${UserController.timer.value.toString().padLeft(2, '0')}',style: AppController.fontStyle(fontTypes.captionLG, accentColor),): Loading(loadingName: ['login'],width:20,height: 15,size: 12 ,getLoadedComponent: ()=>  Text('${AppController.of(context)!.value('resubmit the code')}',style: AppController.fontStyle(fontTypes.captionLG, accentColor),))),
              ],
            );
          }
          )
        ],
      ),
    );
  }
}
