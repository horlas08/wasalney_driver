

import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/config.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:flutter/material.dart';

showAlertDialogRouting(BuildContext context,{Function? onClose,Function? googleClick,Function? wazeClick,String? title,Widget? child}) {

  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    titlePadding: EdgeInsets.all(15),
    // content: Text(text!,textAlign: TextAlign.center,style: TextStyle(color: itemColor2,fontWeight: FontWeight.w400,fontSize: 14)),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              if(googleClick!=null)
                googleClick();
            },
            child: Container(
              width: 160,
              height: 120,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: appColor)
              ),
              child:Column(
                children: [
                  Img(googleMap_icon,width: 50,height: 60,),
                  SizedBox(height: 2,),
                  Text('Google Map',style: AppController.fontStyle(fontTypes.header6, dominantColorShade400)),
                ],
              ) ,
            ),
          ),
          SizedBox(width: 15,),
          InkWell(
            onTap: (){
              if(wazeClick!=null)
                wazeClick();
            },
            child: Container(
              width: 160,
              height: 120,
              padding: EdgeInsets.all(5),

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: appColor)
              ),
              child:Column(
                children: [
                  Img(waze_icon,width: 50,height: 60,),
                  SizedBox(height: 2,),
                  Text('Waze',style: AppController.fontStyle(fontTypes.header6, dominantColorShade400)),
                ],
              ) ,
            ),
          ),


        ],
      )
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