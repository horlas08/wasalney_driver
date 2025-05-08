import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:flutter/cupertino.dart';

class KeyValue extends StatelessWidget {
  String x,y;
  bool ltr;
  KeyValue(this.x,this.y,{this.ltr=false}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(x!=null?'${x}':'',style: AppController.fontStyle(fontTypes.bodyLG, additionalColor2Shade600),),
          Directionality(
              textDirection:ltr? TextDirection.ltr:TextDirection.rtl,
              child: Text(y!=null?'${y}':'',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: blackColor,height: 2)))
        ],
      ),
    );
  }
}
