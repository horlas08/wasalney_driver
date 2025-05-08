import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchBtn extends StatefulWidget {
  Function? onChange;
  String lable1,lable2;
  SwitchBtn(this.lable1,this.lable2,{this.onChange,});

  @override
  State<SwitchBtn> createState() => _SwitchBtnState();
}

class _SwitchBtnState extends State<SwitchBtn> {
  bool positive = false;
  @override
  Widget build(BuildContext context) {
    return   Loading(height: 45,width:100,loadingName: ['change-state'] ,color: Colors.transparent,getLoadedComponent: ()=>
       AnimatedToggleSwitch<bool>.dual(
        current: UserController.user.value.state!=null?UserController.user.value.state:positive,
        first: true,
        second: false,
        spacing: 50.0,
        style: ToggleStyle(
          borderColor: Colors.transparent,
        backgroundColor: UserController.user.value.state==true?dominantColorShade500:additionalColor2Shade800.withOpacity(0.5)),
        borderWidth: 0.0,
        height: 45,
        onChanged: (b) {

          setState(() {
            UserController.user.value.state = b;
          });
          widget.onChange!(b);

        },
        styleBuilder: (b) =>
            ToggleStyle(indicatorColor: b ? whiteColor : whiteColor),
        iconBuilder: (value) => value
            ? Img(power_off_icon,width: 30,height: 30,color: blackColor,)
            : Img(power_off_icon,width: 30,height: 30,color: blackColor,),
        textBuilder: (value) => value
            ? Center(child: Text('${widget.lable1}',style: AppController.fontStyle(fontTypes.header6, whiteColor)))
            : Center(child: Text('${widget.lable2}',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade800),)),
      ),
    );
  }
}
