import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Logic/Helpers/token-methods.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Img extends StatelessWidget {
  String path;
  double? width,height,radius;
  Color? color;
  Function? onClick;
  bool isNetwork;
  bool isPv;
  Img(this.path,{this.width,this.height,this.radius,this.color,this.onClick,this.isNetwork=false,this.isPv=false});



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onClick==null?null:(){
      this.onClick!();
            },
      child: Container(
        width: width,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(radius??0)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius??0),
                child: path.split('.').last=='svg'?
                isNetwork?
                SvgPicture.network(this.path,color: this.color,fit: height!=null?BoxFit.fill:BoxFit.fitWidth):
                SvgPicture.asset(this.path,color: this.color,fit: height!=null?BoxFit.fill:BoxFit.fitWidth,) :
                isNetwork && isPv?
                Image.network(path,fit: height!=null?BoxFit.fill:BoxFit.fitWidth,headers: {
                "Authorization": UserController.token!
                },):
                isNetwork && !isPv?
                Image.network(path,fit: height!=null?BoxFit.fill:BoxFit.fitWidth):
                !isNetwork && !isPv?
                Image.asset(path,fit: height!=null?BoxFit.fill:BoxFit.fitWidth):Container()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
