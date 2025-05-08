import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/config.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';




class Btn extends StatelessWidget {
  Function? onClick;
  btnTypes btnType;
  String? loadingTag;
  String? text;
  double? width;
  double? height;
  double? margin;
  fontTypes fontType;
  Widget? icon;
  Btn(this.btnType,{this.text,this.onClick,this.width,this.height,this.fontType=fontTypes.buttonLG,this.loadingTag,this.margin,this.icon});

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return  Center(
      child: Container(
        width: this.width??maxItemWidth,
        height: height??50,
        margin: EdgeInsets.only(left: margin??0,right: margin??0),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color:this.btnType==btnTypes.secondary?Colors.transparent:this.btnType==btnTypes.withBorder?accentColor:Colors.transparent,width: borderSize),
            borderRadius: BorderRadius.circular(10)
        ),
        child: ElevatedButton(
            onPressed: ()async{
              if(this.onClick!=null && (loadingTag==null || !AppController.loadingList.value.contains(loadingTag)))
                this.onClick!();
            },
            child:
            Obx(
                    () {
                  return AppController.loadingList.value.contains(loadingTag) && loadingTag!=null   ?
                  Container(
                    width: height==null?25:(height!/2),
                    height: height==null?25:(height!/2),
                    child: CircularProgressIndicator(
                      color: additionalColor2,
                      strokeWidth: 3,
                    ),
                  )
                      :Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon??Container(),
                      SizedBox(width: icon == null?0:5),
                      Text(this.text??'',style: AppController.fontStyle(fontType,btnType==btnTypes.primary ? whiteColor:btnType==btnTypes.secondary?dominantColor:this.btnType==btnTypes.withBorder?accentColor:whiteColor)),
                    ],
                  );
                }
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(btnType==btnTypes.primary?dominantColorShade500:btnType==btnTypes.secondary?dominantColorShade100:this.btnType==btnTypes.withBorder?whiteColor:dominantColorShade900),
                elevation: MaterialStateProperty.all(0),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),

                    )
                )

            )
        ),
      ),
    );
  }
}
