import 'package:driver/Logic/Controllers/order-controller.dart';
import 'package:driver/Models/order.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:driver/View/Pages/Map/accepted-page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Logic/Controllers/app-controller.dart';
import '../../../../Logic/Controllers/user-controller.dart';
import '../../../Pages/Main/chat-page.dart';
import '../../Popups/routing.dart';
import '../Map/order-truck-detail.dart';
class OrderHistoryItem extends StatelessWidget {
  Order?order;
  String?type;
  OrderHistoryItem({this.order,this.type});
  void _launchMapsUrl(String url) async {
    if (await canLaunch(url)) {
      await  launch(url);

    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(type=='accept')
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AcceptedPage(OrderController.acceptedOrder,OrderController.indexAcceptOrder.value,hasBack: true,)));
        else if(type=='future')
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AcceptedPage(OrderController.futureOrders,OrderController.indexfutureOrder.value,hasBack: true)));
      },
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: boxShadow,
          color: whiteColor
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Img(money_recive_icon,width: 25,height: 25,color: blackColor,),
                Text('  ${AppController.priceFormat(order!.price)}  ${AppController.of(context)!.value('rial')}   ',style: AppController.fontStyle(fontTypes.bodySM, blackColor)),
              ],
            ),

            MyDivider(margin: 5,),
            Text('${AppController.of(context)!.value('origin')}',style: AppController.fontStyle(fontTypes.bodySM, blackColor)),
            Row(
              children: [
                Expanded(child: Text('${order!.originAddress}',style: AppController.fontStyle(fontTypes.bodySM, blackColor),maxLines: 2,)),
              ],
            ),
            Text('${AppController.of(context)!.value('destination')}',style: AppController.fontStyle(fontTypes.bodySM, blackColor)),
            Row(
              children: [
                Expanded(child: Text('${order!.destinationAddress}',style: AppController.fontStyle(fontTypes.bodySM, blackColor),maxLines: 2,)),
              ],
            ),
            MyDivider(margin: 15,),
            Text('${AppController.of(context)!.value('time')}: ',style: AppController.fontStyle(fontTypes.bodySM, blackColor)),
            order!.reserve==true?
            Text(' ${order!.dateReserve!.preview} - ${AppController.of(context)!.value('hour')}  ${order!.timeReserve} ',style: AppController.fontStyle(fontTypes.bodySM, blackColor)):
            order!.private==true?
              Text(' ${order!.optionPrivate!.datePrivate!.preview} - ${AppController.of(context)!.value('hour')} ${order!.optionPrivate!.timePrivate} ',style: AppController.fontStyle(fontTypes.bodySM, blackColor)):
              Text(' ${order!.updatedAt!.date} - ${AppController.of(context)!.value('hour')} ${order!.updatedAt!.time} ',style: AppController.fontStyle(fontTypes.bodySM, blackColor)),

            SizedBox(height: 20,),
            if(order!.truckDetail!=null)
              OrderDetailTruck(order),
            if(order!.motorDetail!=null)
              Container(child:Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(order!.motorDetail?.typeProduct!=null && order!.motorDetail?.priceProduct!=null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('${AppController.of(context)!.value('the type of shipment and the value of the shipment')}',style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade800)),
                            Row(
                              children: [
                                Text('${order!.motorDetail?.typeProduct}  ${order!.motorDetail?.priceProduct}  ',style: AppController.fontStyle(fontTypes.bodySM, accentColor)),
                              ],
                            ),
                            // MyDivider(margin: 25,color: complementaryColorShade200,),
                          ],
                        ),
                    ],
                  )
                ],
              )),

            if(this.type!='last-order')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    OrderController.getOrderMessage( order);
                  },
                  child: Container(
                    height: 40,width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: blackColor,
                    ),
                    child: Center(child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Img(messages_icon,width: 25,height: 25,color: whiteColor),
                          Text('  ${AppController.of(context)!.value('Send a message')}',style: AppController.fontStyle(fontTypes.captionLG, whiteColor))
                      ],
                    )),
                  ),
                ),
                if(order!.private==true)
                Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 15,right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: additionalColor2Shade200,
                  ),
                  child: Row(
                    children: [
                      Text(' ${AppController.of(context)!.value('Private')} ',style: AppController.fontStyle(fontTypes.bodySM, blackColor)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(order!.info.length==2){
                      showAlertDialogRouting(context,googleClick: (){
                        if(order!.state!.id==2){

                          _launchMapsUrl('https://www.google.com/maps/dir/${UserController.myPosition.latitude},${UserController.myPosition.longitude}/${order!.originLat},${order!.originLong}');
                        }
                        else if(order!.state!.id! >2){
                          _launchMapsUrl('https://www.google.com/maps/dir/${UserController.myPosition.latitude},${UserController.myPosition.longitude}/${order!.destinationLat},${order!.destinationLong}');
                        }
                        Navigator.of(context).pop();
                      },
                        wazeClick: (){
                          if(order!.state!.id==2){
                            _launchMapsUrl('https://waze.com/ul?ll=${order!.originLat},${order!.originLong}&navigate=yes');
                          }
                          else if(order!.state!.id! >2){
                            _launchMapsUrl('https://waze.com/ul?ll=${order!.destinationLat},${order!.destinationLong}&navigate=yes');

                          }
                          Navigator.of(context).pop();
                        },);                    }
                    else if(order!.info.length >2){
                      showAlertDialogRouting(context,googleClick: (){
                        _launchMapsUrl('https://www.google.com/maps/dir/${UserController.myPosition.latitude},${UserController.myPosition.longitude}/${order!.info.last.lat},${order!.info.last.long}');
                        Navigator.of(context).pop();
                      },
                        wazeClick: (){

                          _launchMapsUrl('https://waze.com/ul?ll=${order!.info.last.lat},${order!.info.last.long}&navigate=yes');

                          Navigator.of(context).pop();
                        },);                    }
                  },
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 20,right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: blackColor,
                    ),
                    child: Row(
                      children: [
                        Img(map_icon,width: 25,height: 25,color: whiteColor,),
                        Text(' ${AppController.of(context)!.value('routing')} ',style: AppController.fontStyle(fontTypes.bodySM, whiteColor)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
