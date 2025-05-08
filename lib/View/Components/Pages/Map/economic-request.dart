import 'package:driver/Logic/Controllers/order-controller.dart';
import 'package:driver/Models/order.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/Pages/Map/adrress-icon-item.dart';
import 'package:driver/View/Components/Pages/Map/show-price-box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../Logic/Controllers/app-controller.dart';
import '../../../../Public/images.dart';
import '../../General/img.dart';

class EconomicRequestBox extends StatelessWidget {
  Order order;
  EconomicRequestBox(this.order);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size.width-100,
          margin: EdgeInsets.only(right: 20,left: 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: maxItemWidth,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(top: 20,bottom: 20,right: 15,left: 15),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: boxShadow
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    order.economic==true?
                    Container(
                      width: 80,
                      height: 25,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(color:warningColor,borderRadius: BorderRadius.circular(20)),
                      child: Center(child: Text('${AppController.of(context)!.value('economic')}',style: AppController.fontStyle(fontTypes.captionLG, whiteColor))),
                    ):Container(),
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Img(origin_icon,width: 25,height: 30,),
                                    SizedBox(width: 10),
                                    Text('${AppController.of(context)!.value('origin')}',style: AppController.fontStyle(fontTypes.captionMD, blackColor))
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 13),
                                    Img(line_icon,width: 2,height: 25,),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Img(destination_icon,width: 25,height: 30,),
                                    SizedBox(width: 10),
                                    Text('${AppController.of(context)!.value('destination')}',style: AppController.fontStyle(fontTypes.captionMD, blackColor))
                                  ],
                                ),
                                if(order.info.length>2)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 13),
                                      Img(line_icon,width: 2,height: 40,),
                                      Img(destination_icon,width: 25,height: 30,),
                                      SizedBox(width: 10),
                                      Container(
                                        height: 43,
                                        width: 40,
                                        child: Stack(
                                          children: [
                                            Positioned(top: 0,child: Text('${AppController.of(context)!.value('destination')}',style: AppController.fontStyle(fontTypes.bodySM, blackColor),)),
                                            Positioned(bottom: 0,child: Text('${AppController.of(context)!.value('second')}',style: AppController.fontStyle(fontTypes.bodySM, blackColor),)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            SizedBox(width: 30,),
                            Column(
                              children: [
                                Container(
                                  width: 230,
                                  height: 30,
                                  padding: EdgeInsets.only(right: 10,left: 10,bottom: 10),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(width: 1,color: complementaryColorShade300),
                                  ),
                                  child: Center(
                                    child: Text('${order.info[0].address}',
                                      style: AppController.fontStyle(fontTypes.captionMD, blackColor),maxLines: 2,overflow: TextOverflow.clip,),
                                  ),
                                ),
                                for(var info in order.info.skip(1))
                                  Container(
                                    width: 230,
                                    height: 30,
                                    margin: EdgeInsets.only(top: 10),

                                    padding: EdgeInsets.only(right: 10,left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(width: 1,color: complementaryColorShade300)
                                    ),
                                    child: Center(
                                      child: Text('${info.address}',
                                        style: AppController.fontStyle(fontTypes.captionMD, blackColor),maxLines: 2,overflow: TextOverflow.clip,),
                                    ),
                                  ),

                              ],
                            )
                          ],
                        )),
                    if(order.comeback==true || order.stopTime!=null || order.stopTime2!=null)
                      Padding(
                        padding:  EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if(order.comeback==true)
                              bottun(programming_arrows_icon, '${AppController.of(context)!.value('back to the origin')}',(){}),
                            if(order.stopTime!=null)
                              bottun(timer_icon, ' ${order.stopTime} ${AppController.of(context)!.value('stop')} ',(){}),
                            if(order.stopTime2!=null)
                              bottun(timer_icon, ' ${order.stopTime2} ${AppController.of(context)!.value('driverless stop')} ',(){}),
                          ],
                        ),
                      ),
                    SizedBox(height: 20,),
                    // Spacer(),
                    Btn(btnTypes.primary,fontType: fontTypes.captionMD,height: 27,width: maxItemWidth,loadingTag: 'accept-order',text: '${AppController.of(context)!.value('accept the trip')}',
                      onClick: (){
                        OrderController.acceptOrder(order.id!);
                      },
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 0,
                  child: ShowPriceBox('${AppController.priceFormat(order.price)}',width: 95,height: 30,smallText: true,)),
            ],
          ),
        ),
      ],
    );
  }
}

Widget bottun(String icon,String title,Function? onClick){
  return InkWell(
    onTap: (){
      onClick!();
    },
    child: Container(
      width: 170,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: complementaryColorShade100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Img(icon,width: 25,height: 25,color: Color(0xff353535),),
          SizedBox(width: 5),
          Text(title,style: AppController.fontStyle(fontTypes.bodySM, Color(0xff353535)),)
        ],
      ),
    ),
  );
}
