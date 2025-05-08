import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListSelector extends StatefulWidget {
  String left,right;
  List <Widget>rightList,leftList;

  ListSelector(this.left,this.right,this.leftList,this.rightList,{Key? key}) : super();

  @override
  State<ListSelector> createState() => _ListSelectorState();
}

class _ListSelectorState extends State<ListSelector> {
  int state = 1;
  @override
  Widget build(BuildContext context) {
    Widget btn(String title,int i,bool left){
      return InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: (){
          setState(() {
            state = i;
          });
        },
        child: Container(
          width: 160,
          height: 40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              left?Img(select_left_icon,width: 160,height: 40,color:state==i? dominantColor:additionalColor2Shade400,):
              Img(select_right_icon,width: 160,height: 40,color:state==i?dominantColor:additionalColor2Shade400),
              Text(title,style: AppController.fontStyle(fontTypes.buttonLG, state==i?dominantColor:additionalColor2Shade400),)
            ],
          ),
        ),
      );
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            btn(widget.right, 1, false),
            Container(height: 1,width: 30,color: blackColor,),
            btn(widget.left, 2, true),
          ],
        ),
        SizedBox(height: 30),
        Container(
          width: maxItemWidth,
          child: Column(
            children: state==1?widget.rightList:widget.leftList,
          ),
        )
      ],
    );
  }
}
