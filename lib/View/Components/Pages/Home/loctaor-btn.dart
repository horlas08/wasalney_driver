import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/order-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:driver/View/Components/Popups/bottom-modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../Models/order.dart';

class LocatorBtn extends StatelessWidget {
  Order order;
  Function?onClick;
  String text = '${AppController.of(Get.context!)!.value('routing')}';
  LocatorBtn(this.order,this.text,{this.onClick}) ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        if(order.destinationLat!=null) {

          if(this.onClick!=null){
            this.onClick!();
          }
        }
        },
      child: Container(
        width: 180,
        height: 50,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: boxShadow,
            color: whiteColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Img(map_icon,width: 25,height: 25,color: dominantColorShade400),
            SizedBox(width: 5),
            Text('${this.text}',style: AppController.fontStyle(fontTypes.header6, dominantColorShade400))
          ],
        ),
      ),
    );
  }
}
