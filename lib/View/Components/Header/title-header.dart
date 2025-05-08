import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  bool closeIcon;
  String title;

  TitleHeader({this.title = '',this.closeIcon=false}) : super();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        closeIcon?Container(
          width: 30,
            height: 50,
            child: Img(cancle_icon,width: 13,height: 13,color: whiteColor,onClick: ()=>Navigator.pop(context),)):Img(arrow_right_icon,width: 25,height: 25,color: whiteColor,onClick: ()=>Navigator.pop(context)),
        Spacer(),
        Text(title,style: AppController.fontStyle(fontTypes.header4, whiteColor),),
        Spacer(),
        
      ],
    );
  }
}
