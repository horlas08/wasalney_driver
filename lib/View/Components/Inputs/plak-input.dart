import 'package:driver/View/Components/General/img.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Public/images.dart';
import '../../../Public/styles.dart';
class PlakInput extends StatefulWidget {
  int max;
  Function onChange;
  var initValue;
  double?width;
   PlakInput(this.max,this.onChange,{this.initValue,this.width}) ;

  @override
  State<PlakInput> createState() => _PlakInputState();
}

class _PlakInputState extends State<PlakInput> {
  TextEditingController? _textController;
  final _focusNode = new FocusNode();
  @override


    @override
    void initState() {
      super.initState();
      _textController = TextEditingController(text: widget.initValue??'');
      _focusNode.addListener(() {
        if(_focusNode.hasFocus){
          _textController!.text=_textController!.text+'';
        }
      }
      );
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      width:widget.width?? 30,
      height: 33,
      child: Column(
        children: [
          Container(
            width:widget.width?? 30,
            height: 30,
            child: TextFormField(
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: blackColor),
              controller:_textController ,
              maxLength: widget.max,
              showCursor: true,
              cursorWidth: 1,
              cursorHeight: 15,
              cursorColor: dominantColor,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.only(bottom: 10),
                  border: InputBorder.none
              ),
              onChanged: (text) {

                widget.onChange(text);
              },
            ),
          ),
          Img(dashed_line_icon,width: 30,height: 3,color: dominantColor,)
        ],
      ),
    );;
  }
}
