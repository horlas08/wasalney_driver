import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Inputs/input.dart';
import 'package:flutter/cupertino.dart';

class EditInput extends StatelessWidget {
  String title;
  bool? isnum;
  Widget? icon;
  TextAlign align;
  double leftPadding;
  var initValue;
  double iconSpace;
  Function? onChange;
  EditInput(this.title,{this.isnum=false,this.onChange,this.initValue,this.icon,this.align=TextAlign.right,this.leftPadding=0,this.iconSpace=13});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: maxItemWidth,
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(title,style: AppController.fontStyle(fontTypes.captionLG, additionalColor1Shade800),)
            ],
          ),
          SizedBox(height: 5),
          Stack(
            children: [
              Input(height: 45,width: maxItemWidth,isNumber: isnum??false,align: align,leftPadding: leftPadding,initValue: this.initValue,onChange: (text){
                this.onChange!(text);
              },),
              Positioned(
                  left: 25,
                  top: iconSpace,
                  child: icon??Container())
            ],
          )
        ],
      ),
    );
  }
}

