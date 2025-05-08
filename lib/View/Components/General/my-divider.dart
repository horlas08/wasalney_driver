import 'package:driver/Public/styles.dart';
import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  double? padding,width,height,margin;
  Color color;
  MyDivider({this.padding=0,this.width=maxItemWidth,this.height=1,this.margin=0,this.color=additionalColor1Shade100});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
      margin: EdgeInsets.only(left: padding!,right: padding!,top: margin!,bottom: margin!),
    );
  }
}
