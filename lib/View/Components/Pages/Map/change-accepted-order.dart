import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Models/order.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/Pages/Map/show-price-box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChangeAcceptedOrder extends StatelessWidget {
  bool left;
  // String price;
  Order order;
  Function? onClick;
  ChangeAcceptedOrder(this.order,{this.left = true,this.onClick}) : super();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        this.onClick!();
      },
      child: Container(
        child: left?Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Img(arrow_left_icon),
              Center(child: Text('${AppController.of(context)!.value('previous trip')}',style: AppController.fontStyle(fontTypes.buttonSM, whiteColor),textAlign: TextAlign.center)),
            ],
          )
          ],
        ):Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Img(arrow_right_icon1),
                 Center(child: Text('${AppController.of(context)!.value('next trip')}',style: AppController.fontStyle(fontTypes.buttonSM, whiteColor),textAlign: TextAlign.center,)),

              ],
            ),

          ],
        )
      ),
    );
  }
}
