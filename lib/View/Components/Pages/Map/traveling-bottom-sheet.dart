import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/main-controller.dart';
import 'package:driver/Models/order.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/General/column-scroll.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:driver/View/Components/Pages/Map/adrress-icon-item.dart';
import 'package:driver/View/Components/Pages/Map/order-truck-detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Logic/Controllers/order-controller.dart';
import '../../../../Public/config.dart';
import '../../General/loading.dart';
import '../../Popups/snackbar.dart';

class TravelingBottomSheet extends StatelessWidget {
  int index;
  TravelingBottomSheet(this.index);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx( () {
      Order order=OrderController.acceptedOrder[index];
        return Container(
          child:  Column(
                children: [
                  SizedBox(height: 10),
                  Img(arrow_down_icon,width: 40,height: 25,color: additionalColor2Shade400,onClick: (){
                    Navigator.pop(context);
                  },),
                  SizedBox(height: 20),
                  Expanded(
                    child: ColumnScroll(
                      children: [
                        Row(
                          children: [
                            Text('${order.payType!.title} ${AppController.priceFormat(order.price)} ${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(fontTypes.header5, blackColor),),
                            SizedBox(width: 15),
                            if(order.payType!.id!=1)
                              Container(
                                width: 55,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: dominantColorShade600
                                ),
                                child: Center(child: Text('${AppController.of(context)!.value('impure')}',style: AppController.fontStyle(fontTypes.overlineLG, whiteColor))),
                              ),
                            Spacer(),
                            Loading(loadingName: ['get-order'],size: 15,width: 25,height: 25,getLoadedComponent: ()=>
                                Img(refresh_circle_icon,width: 25,height: 25,color: dominantColor,onClick: (){
                                  OrderController.getOrder(order);
                                },),
                            )
                          ],
                        ),
                        if(order.payType!.id==1)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              order.deliveryId==3 || order.deliveryId==1?
                              Text('${AppController.of(context)!.value('Get the travel fee in cash from the passenger.')}',
                                style: AppController.fontStyle(fontTypes.captionLG, dominantColorShade400),):
                              Text('${AppController.of(context)!.value('travel expenses in cash')} ',
                                style: AppController.fontStyle(fontTypes.captionLG, dominantColorShade400),),
                            ],
                          ),
                        SizedBox(height: 10),
                        if( order.payType!.id !=1 && order.netPrice!=null)
                          Row(
                            children: [
                              Img(wallet3_icon,width: 25,height: 25,color: dominantColor,),
                              SizedBox(width: 10),
                              Text('${AppController.of(context)!.value('net receipts')} ${AppController.priceFormat(order.netPrice)} ${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(fontTypes.header6, blackColor),),
                            ],
                          ),
                        MyDivider(color: additionalColor2Shade200,margin: 20),
                        AddressIconItem(order),
                        MyDivider(color: additionalColor2Shade200,margin: 20),
                        OrderDetailTruck(order),
                        MyDivider(color: additionalColor2Shade200,margin: 20),
                        if(order.deliveryId!=3 && order.deliveryId!=1)
                          Column(
                            children: [
                              for(var info in order.info)
                                Column(
                                  children: [
                                    Container(
                                      width: maxItemWidth-20,
                                      child: Wrap(
                                        children: [
                                          Text('${info.type} :',style: AppController.fontStyle(fontTypes.bodySM, accentColor),),
                                          info.name !=null?Text(' في الاسم ${info.name} ،  ',style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade800),maxLines: null,):Container(),
                                          info.unit !=null?Text(' الوحده ${info.unit} ،  ',style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade800),maxLines: null,):Container(),
                                          info.houseNumber!=null?Text(' رقم الدار${info.houseNumber} ، ',style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade800),maxLines: null,):Container(),
                                          info.phone!=null?Text(' رقم الهاتف  ${info.phone} ، ',style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade800),maxLines: null,):Container(),
                                          info.description!=null?Text(' شرح إضافي:  ${info.description} .',style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade800),maxLines: 2,):Container(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              MyDivider(color: additionalColor2Shade200,margin: 20),
                            ],
                          ),
                        InkWell(
                          onTap: ()async{
                            launch("tel:${ MainController.support}");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Img(message_question_icon,width: 25,height: 25,color: dominantColor,),
                              SizedBox(width: 15),
                              Text('${AppController.of(context)!.value('support')}',style: AppController.fontStyle(fontTypes.header6, dominantColor),)
                            ],
                          ),
                        ),
                        MyDivider(color: additionalColor2Shade200,margin: 20),
                        Row(
                          children: [
                            Text('${order.name}',style: AppController.fontStyle(fontTypes.header5, blackColor),),
                            Spacer(),
                            InkWell(
                              onTap: (){
                                launch("tel:${ order.mobile}");
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [BoxShadow(color: blackColor.withOpacity(0.1),blurRadius: 4,offset: Offset(1,2))]
                                ),
                                child: Img(calling_icon,width: 30,height: 30,color: accentColor),
                              ),
                            ),
                          ],
                        ),
                        MyDivider(color: additionalColor2Shade200,margin: 20),
                      ],
                    ),
                  ),

                  // SizedBox(height: 20,),
                  order.deliveryId==3 || order.deliveryId==1?
                  Btn(btnTypes.primary,text:order.step==2? '${AppController.of(context)!.value('I reached the origin')}':order.step==3? '${AppController.of(context)!.value('The passenger boarded')}':order.step==4? '${AppController.of(context)!.value('the end of the trip')}':"",width: size.width>maxItemWidth?maxItemWidth-40:size.width-40,loadingTag: 'change-status',onClick: (){
                    OrderController.changeStatus(order.id,order.step,context);
                    Navigator.pop(context);
                  },):order.deliveryId!=3 && order.deliveryId!=1?Btn(btnTypes.primary,text:order.step==2? '${AppController.of(context)!.value('I reached the origin')}':order.step==3? '${AppController.of(context)!.value('It was delivered')}':order.step==4? '${AppController.of(context)!.value('the end of the trip')}':"",width: size.width>maxItemWidth?maxItemWidth-40:size.width-40,loadingTag: 'change-status',onClick: (){
                    OrderController.changeStatus(order.id,order.step,context);
                    Navigator.pop(context);
                  },):Btn(btnTypes.primary,text:order.step==2? '${AppController.of(context)!.value('I reached the origin')}':order.step==3? '${AppController.of(context)!.value('The passenger boarded')}':order.step==4? '${AppController.of(context)!.value('the end of the trip')}':"",width: size.width>maxItemWidth?maxItemWidth-40:size.width-40,loadingTag: 'change-status',onClick: (){
                    OrderController.changeStatus(order.id,order.step,context);
                    Navigator.pop(context);
                  },),
                  SizedBox(height: 20,)
                ],
              ),
        );
      }
    );
  }
}
