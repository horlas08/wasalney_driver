import 'package:driver/Public/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


showBottomModal(BuildContext context,double height,Widget child,{String? title,bool dragable=true,Function?close}){

  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      enableDrag: dragable,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: maxItemWidth,
      ),
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0)),
      ),
      builder: (builder){
        return Container(
          width: maxItemWidth,
          height: height+WidgetsBinding.instance.window.viewInsets.bottom,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              title!=null?Container(
                  margin: EdgeInsets.only(top: 10,bottom: 30),
                  child: Text(title,style: TextStyle(color: additionalColor2Shade800,fontWeight: FontWeight.w700,fontSize: 21),)
              ):Container(),
              Expanded(child: child)
            ],
          ),
        );
      }
  ).then((value){
    if(close!=null){
      close();
    }
  });
}




