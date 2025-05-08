import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Models/order.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/Pages/Map/show-price-box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChangePriceBtn extends StatelessWidget {
  bool left;
  // String price;
  Order order;
  Function? onClick;
  ChangePriceBtn(this.order,{this.left = true,this.onClick}) : super();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        this.onClick!();
      },
      child: Container(
        width: 115,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: dominantColorShade300
        ),
        child: left?Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShowPriceBox(AppController.priceFormat(order.price!),small: true,width: 90,height: 40,),
            Img(arrow_left2_icon)
          ],
        ):Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Img(arrow_right2_icon),
            ShowPriceBox(AppController.priceFormat(order.price),small: true,width: 90,height: 40,),
          ],
        )
      ),
    );
  }
}
