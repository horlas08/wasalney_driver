import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorBtn extends StatelessWidget {
  String text = '${AppController.of(Get.context!)!.value('cancel the trip')}';
  Function? onClick;
  String? loadingTag;
  double height,width;
  ErrorBtn(this.text,{this.width = 170,this.height=50,this.loadingTag,this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(this.onClick!=null && (loadingTag==null || !AppController.loadingList.value.contains(loadingTag)))
          this.onClick!();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1,color: errorColor)
        ),
        child: Center(
          child: Obx((){
            return AppController.loadingList.value.contains(loadingTag) && loadingTag!=null   ?
            Container(
              width: height==null?25:(height/2),
              height: height==null?25:(height/2),
              child: CircularProgressIndicator(
                color: accentColor,
                strokeWidth: 3,
              ),
            ):
               Text(text,style: AppController.fontStyle(fontTypes.buttonSM, errorColor),);
            }
          ),
        ),
      ),
    );
  }
}
