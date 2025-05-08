
import 'package:dotted_border/dotted_border.dart';

import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Logic/Controllers/user-controller.dart';
import '../Buttons/btn.dart';
// class PinCodeController{
//   final List<TextEditingController> controllers = List.generate(
//     4,
//         (index) => TextEditingController(),
//   );
// }
class BankInput extends StatefulWidget {
  String? lable,hint;
  Function? onChange;
  bool isNumber,hasBorder;
  TextAlign align;
  Widget? icon1,icon2;
  double? width;
  double? height;
  int lines;
  var initValue;
  fontTypes hintFontType;
  double leftPadding;
  BankInput({this.lable,this.width=maxItemWidth,this.height=50,this.initValue,this.hint,this.onChange,this.isNumber=false,this.icon1,this.icon2,this.lines=1,this.align=TextAlign.right,this.hasBorder=true,this.hintFontType=fontTypes.bodySM,this.leftPadding=0});

  @override
  State<BankInput> createState() => _BankInputState();
}

class _BankInputState extends State<BankInput> {

  late final TextEditingController controllers;
  // final _focusNode = new FocusNode();
  @override
  void initState() {
    super.initState();
      controllers = TextEditingController(text:widget.initValue!=null ? widget.initValue: '');




    // _focusNode.addListener(() {
    //   if(_focusNode.hasFocus){
    //     _textController.text=_textController.text+'';
    //   }
    // }
    // );
  }
  // final PinCodeController pinCodeController = PinCodeController();

  @override
  Widget build(BuildContext context) {
    if(WidgetsBinding.instance.window.viewInsets.bottom==0 && FocusManager.instance.primaryFocus!=null){
      FocusManager.instance.primaryFocus!.unfocus();
    }
    var size=MediaQuery.of(context).size;
    return  Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DottedBorder(
            strokeWidth: 1.5,
            dashPattern: [10,5],
            radius: Radius.circular(20),
            color: dominantColor,
            child: Container(
              width: 80,
              height: 50,
              child: TextFormField(
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: accentColor),
                controller: controllers,
                // initialValue: widget.initValue?.length!=0?widget.initValue![index]:'2',
                maxLength: 4,
                showCursor: true,
                cursorWidth: 1,
                cursorHeight: 20,
                cursorColor: accentColor,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: '_ _ _ _',
                    hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: accentColor),
                    counterText: '',
                    contentPadding: EdgeInsets.all(5),
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none
                ),
                onChanged: (value){
                  print('bank>>>${value}');
                  if (value.length==4){
                    if(widget.onChange!=null)
                      widget.onChange!(value);
                    UserController.infoBank.number.add(value);
                    print('infoBank.number length>>>${UserController.infoBank.number.length}');
                    FocusScope.of(context).nextFocus();
                  }
                },
              ),
            ),
          )]

          ),
        );
  }
}






