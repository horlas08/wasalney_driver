import 'package:dotted_border/dotted_border.dart';
import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/Inputs/edit-input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../Logic/Controllers/user-controller.dart';
import '../../Inputs/input.dart';
import '../../Inputs/plak-input.dart';

class LicensePlate extends StatefulWidget {

  const LicensePlate({Key? key}) : super(key: key);

  @override
  State<LicensePlate> createState() => _LicensePlateState();
}

class _LicensePlateState extends State<LicensePlate> {
  // late final _textController;
  final _focusNode = new FocusNode();
  // @override
  // void initState() {
  //   super.initState();
  //   _textController = TextEditingController(text: widget.initValue??'');
  //   _focusNode.addListener(() {
  //     if(_focusNode.hasFocus){
  //       _textController.text=_textController.text+'';
  //     }
  //   }
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    int counter=0;
    var size = MediaQuery.of(context).size;

    return Container(
      height: 120,
      width: maxItemWidth,
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          SizedBox(height: 15,),
        Container(
              height: 100,
              width: maxItemWidth,
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10),
              ),
              child:
            Container(
                child:    EditInput('${AppController.of(context)!.value('plaque')} :',
                  initValue:  UserController.user.value.plak != null?'${UserController.user.value.plak}':'',
                  onChange: (text){
                    UserController.user.value.plak=text;
                  }
                ),
                // Text( UserController.user.value.plak!,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: blackColor)),
              )
            ),
        ],
      ),
    );
  }
}
