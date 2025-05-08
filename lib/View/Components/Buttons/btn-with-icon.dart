
import 'package:driver/Public/enums.dart';
import 'package:flutter/material.dart';
import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/config.dart';
import 'package:driver/Public/styles.dart';

class BtnIcon extends StatefulWidget {
  String text;
  Widget? icon;
  Function? onclick;

  BtnIcon({this.text='', this.icon,this.onclick});

  @override
  State<BtnIcon> createState() => _BtnIconState();
}

class _BtnIconState extends State<BtnIcon> {
  bool selected=false;
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return InkWell(
          onTap: (){
            setState(() {
              selected=true;
            });
            if(widget.onclick!=null)
              widget.onclick!();
          },
          child: Container(
            width: ((size.width<maxItemWidth?size.width:maxItemWidth)-(2*paddingSize))/2.1,
            height: 140,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: selected?[BoxShadow(color: appColor, spreadRadius: 1,blurRadius: 1)]:boxShadow
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.icon != null
                    ? widget.icon!
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.text,
                  style: AppController.fontStyle(fontTypes.bodyXL, selected?appColor:blackColor),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        );
  }
}


