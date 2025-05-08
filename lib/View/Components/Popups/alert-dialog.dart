

import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context,{Function? onClose,String? title,Widget? child}) {

  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    title:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Container(
          width: 250,
            child: Row(
              children: [
                Expanded(child: Text(title!,style: AppController.fontStyle(fontTypes.header6, errorColor),maxLines: 2,textAlign: TextAlign.center,)),
              ],
            )),
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Img(cancle_icon,width: 13,height: 13,color: blackColor,),
        )

      ],
    ),
    titlePadding: EdgeInsets.all(15),
    // content: Text(text!,textAlign: TextAlign.center,style: TextStyle(color: itemColor2,fontWeight: FontWeight.w400,fontSize: 14)),
    actions: [
      child!=null?child:Container()
    ],

  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  ).then((value) {
    if(onClose!=null)
      onClose();
  } );
}