import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconHeader extends StatelessWidget {
  String title = '${AppController.of(Get.context!)!.value('edit bank information')}';
  String?icon;
  Function? onclick;
  IconHeader(this.title,{this.icon=card_edit_icon,this.onclick}) : super();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          child: Img(cancle_icon,width: 13,height: 13,color: whiteColor,onClick: (){
            Navigator.pop(context);
          }),
        ),
        Spacer(),
        Text(title!,style: AppController.fontStyle(fontTypes.header6, whiteColor),),
        SizedBox(width: 15),
        if(icon!=null)
        InkWell(
          onTap: (){
            onclick!();
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: dominantColorShade400
            ),
            child: Img(icon!,width: 25,height: 25,color: whiteColor,),
          ),
        ),

      ],
    );
  }
}
