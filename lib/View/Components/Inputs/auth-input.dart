import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/config.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthInput extends StatefulWidget {
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
  AuthInput({this.lable,this.width=maxItemWidth,this.height=50,this.hint,this.initValue,this.onChange,this.isNumber=false,this.icon1,this.icon2,this.lines=1,this.align=TextAlign.right,this.hasBorder=true,this.hintFontType=fontTypes.bodySM});

  @override
  State<AuthInput> createState() => _InputState();
}

class _InputState extends State<AuthInput> {
  late final _textController;
  final _focusNode = new FocusNode();
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initValue??'');
    _focusNode.addListener(() {
      if(_focusNode.hasFocus){
        _textController.text=_textController.text+'';
      }
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    if(WidgetsBinding.instance.window.viewInsets.bottom==0 && FocusManager.instance.primaryFocus!=null){
      FocusManager.instance.primaryFocus!.unfocus();
    }
    var size=MediaQuery.of(context).size;
    return Container(
      height: widget.lines==1?this.widget.height??null:null,
      width: this.widget.width??maxItemWidth,
      alignment: Alignment.center,

      child: TextFormField(
        // initialValue: isNumber || initValue=='' || initValue==null?'${initValue??''}':'${initValue??''} ',
        controller: _textController,
        focusNode: _focusNode,
        textAlign: widget.align,
        minLines: widget.lines,
        maxLines: widget.lines,
        textDirection: widget.isNumber?TextDirection.ltr:TextDirection.rtl,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 5,right: 15,left: 15),
          filled: true,
          fillColor: whiteColor,
          prefixIcon: widget.icon1!=null?widget.icon1:null,
          suffixIcon: widget.icon2!=null?widget.icon2:null,
          errorBorder: widget.hasBorder? OutlineInputBorder(
            borderSide: BorderSide(color: accentColorShade500,width: borderSize),
            borderRadius: BorderRadius.circular(10.0),
          ):InputBorder.none,
          enabledBorder:widget.hasBorder? OutlineInputBorder(
            borderSide: BorderSide(color: additionalColor2Shade500,width: borderSize),
            borderRadius: BorderRadius.circular(10.0),
          ):InputBorder.none,
          focusedBorder:widget.hasBorder? OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: dominantColor,width: borderSize),
          ):InputBorder.none,
          floatingLabelStyle:TextStyle(color: appColor),
          labelStyle: AppController.fontStyle(fontTypes.buttonLG, additionalColor2),
          alignLabelWithHint: true,
          labelText: this.widget.lable,
          hintText: this.widget.hint,
          hintStyle: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade400),

        ),
        keyboardType: widget.isNumber?TextInputType.number:TextInputType.text,
        inputFormatters: <TextInputFormatter>[
          widget.isNumber?FilteringTextInputFormatter.digitsOnly:
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        onChanged: (text){
          if(widget.onChange!=null)
            this.widget.onChange!(text);
        },



      ),
    );
  }
}




