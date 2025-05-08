import 'package:driver/Public/enums.dart';
import 'package:flutter/material.dart';
import '../../../../Logic/Controllers/app-controller.dart';
import '../../../../Logic/Controllers/order-controller.dart';
import '../../../../Models/order.dart';
import '../../../../Public/images.dart';
import '../../../../Public/styles.dart';
import '../../General/img.dart';
class ChatHeader extends StatelessWidget {
  Order?order;

  ChatHeader(this.order) ;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return  Container(
      width: size.width,
      height: 120,
      decoration: BoxDecoration(color: whiteColor,boxShadow: boxShadow),
      padding: EdgeInsets.only(left: 20,right: 20),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  boxShadow: boxShadow,
                    shape: BoxShape.circle,
                    color: whiteColor
                ),
                child: Img(arrow_right_icon,width: 30,height: 30,),
              ),
            ),
            Row(
              children: [
                // Container(
                //   width: 45,
                //   height: 45,
                //   decoration: BoxDecoration(shape: BoxShape.circle),
                //   child:  order!.!.image!=null?Img(order!.driver!.image,isNetwork: true,height: 45,width: 45,radius: 100):Img(user_icon,height: 40,width: 40,radius: 100,),
                // ),
                SizedBox(width: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${order!.name}',style: AppController.fontStyle(fontTypes.buttonLG,blackColor),maxLines: null,),
                  ],
                ),

    ],
            )
          ],
        ),
      ),
    );
  }
}
