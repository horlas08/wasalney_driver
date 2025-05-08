import 'package:driver/Models/message-order.dart';
import 'package:driver/Public/enums.dart';
import 'package:flutter/material.dart';

import '../../../../Logic/Controllers/app-controller.dart';
import '../../../../Public/config.dart';
import '../../../../Public/styles.dart';
class ChatBox extends StatelessWidget {
  MessageOrder?message;
  ChatBox(this.message) ;
  Color boxColor(){
    if(message!.driverSent==true)
    return appColor;
    else
      return whiteColor;
  }
  Color textColor(){
    if(message!.driverSent==true)
    return whiteColor;
    else
      return blackColor;
  }
  BorderRadius borderRadius(){
    if(message!.driverSent==true)

      return BorderRadius.only(bottomLeft: Radius.circular(15),topRight:  Radius.circular(15),topLeft:  Radius.circular(15));
    else
      return BorderRadius.only(bottomRight: Radius.circular(15),topRight:  Radius.circular(15),topLeft:  Radius.circular(15));
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
    IntrinsicWidth(
          child: Container(
            constraints: BoxConstraints(minWidth: 65, maxWidth:350,minHeight: 35),

            padding:  EdgeInsets.only(top: 15,right: 20,left: 20),
            decoration: BoxDecoration(color:boxColor(),borderRadius:borderRadius(),boxShadow: boxShadow),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child:
                        Text('${message!.messsage}',style: AppController.fontStyle(fontTypes.bodySM, textColor()),maxLines: null,)),
                  ],
                ),
                SizedBox(height: 7,),
                if(message!.createdAt!=null)
                Text('${message!.createdAt!.time}    ${message!.createdAt!.day}/${message!.createdAt!.month}/${message!.createdAt!.year}',style: AppController.fontStyle(fontTypes.captionMD, textColor()),),
              ],
            ),

          ),
        ),
        SizedBox(height: 25,)
      ],
    );
  }
}
