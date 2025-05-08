import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayMonthSelector extends StatelessWidget {
  String title;
  bool condition;
   DayMonthSelector(this.title,this.condition) ;

  @override
  int state = 1;

  Widget build(BuildContext context) {
    return Container(
      // width: 195,
      height: 55,
      decoration: BoxDecoration(
          color: condition==true?dominantColorShade500:additionalColor2Shade200,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Text('$title',style: AppController.fontStyle(fontTypes.header4,condition==true?whiteColor:blackColor),),
      ),
    );
  }
}
