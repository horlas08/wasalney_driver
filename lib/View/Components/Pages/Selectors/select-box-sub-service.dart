import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/main-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:flutter/material.dart';


class SelectBoxSubService extends StatefulWidget {
  List<dynamic> options=[];
  Function? onSelect;
  String text;
  Color?backColor,borderColor;
  Widget? icon;
  var value;
  double width;
  bool?condition;
  SelectBoxSubService(this.options,{this.onSelect,this.text='',this.icon,this.value,this.width=maxItemWidth,this.borderColor,this.backColor,this.condition});
  @override
  _SelectBoxSubServiceState createState() => _SelectBoxSubServiceState();
}

class _SelectBoxSubServiceState extends State<SelectBoxSubService> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: widget.width,
      padding: EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
        color:widget.backColor?? dominantColorShade100.withOpacity(0.7),
        border: Border.all(width: borderSize,color:widget.borderColor?? dominantColorShade100.withOpacity(0.7)),
        borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value:widget.value ,
          isExpanded: true,
          focusColor: Colors.transparent,
          isDense: true,
          icon: Img(arrow_down2_icon,width: 25,height: 25,color: additionalColor1Shade800,),
          hint: Row(
            children: [
              widget.icon!=null?widget.icon!:Container(),
              SizedBox(width: 10),
              Text(widget.text!=null?'${widget.text}':'انتخاب',style: TextStyle(color:widget.text!=null?additionalColor2Shade800: additionalColor2Shade400,fontSize: 14,fontWeight: FontWeight.w500),)
            ],
          ),
          items:[
            for(var item in MainController.subServices)
              if(item.service!.id==UserController.user.value.parentType!.id)
              DropdownMenuItem(
                value: item,
                child: Text('${item.title}',style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade800)),
              )
          ],
          onChanged: (val) {
            setState(() {
              this.widget.value=val;
            });
            if(widget.onSelect!=null)
              widget.onSelect!(widget.value);
          },
        ),
      ),
    );
  }
}
