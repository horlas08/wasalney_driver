import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NoColorBtn extends StatelessWidget {
  String text;
  Function? onClick;
  double height,width;
  NoColorBtn(this.text,{this.width = 160,this.height=50,this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        this.onClick!();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.transparent,
        ),
        child: Center(
          child: Text(text,style: AppController.fontStyle(fontTypes.buttonSM, complementaryColorShade700),),
        ),
      ),
    );
  }
}
