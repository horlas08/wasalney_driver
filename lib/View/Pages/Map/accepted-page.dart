import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/map-controller.dart';
import 'package:driver/Logic/Controllers/order-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Models/order.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/Header/home-header.dart';
import 'package:driver/View/Components/Pages/Home/gps-btn.dart';
import 'package:driver/View/Components/Pages/Home/inventory-box.dart';
import 'package:driver/View/Components/Pages/Home/loctaor-btn.dart';
import 'package:driver/View/Components/Pages/Home/rectangle-btn.dart';
import 'package:driver/View/Components/Pages/Map/address-origin-item.dart';
import 'package:driver/View/Components/Pages/Map/change-accepted-order.dart';
import 'package:driver/View/Components/Pages/Map/change-price-btn.dart';
import 'package:driver/View/Components/Pages/Map/economic-request.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Components/Pages/Map/map.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Components/Pages/Map/traveling-bottom-sheet.dart';
import '../../Components/Popups/bottom-modal.dart';
import '../../Components/Popups/routing.dart';
import '../Main/chat-page.dart';


class AcceptedPage extends StatefulWidget {
  var orderList;
  int indexList;
  bool?hasBack;
  AcceptedPage(this.orderList,this.indexList,{this.hasBack=false});
  @override
  State<AcceptedPage> createState() => _AcceptedPageState();
}

class _AcceptedPageState extends State<AcceptedPage>with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      UserController.getMyLocation(controller: MapApiController.mainController);
      MapApiController.setCameraPosition(UserController.myPosition.latitude, UserController.myPosition.longitude);
    });
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  void _launchMapsUrl(String url) async {
    if (await canLaunch(url)) {
      await  launch(url);

    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()async {
        if(widget.hasBack!=null && widget.hasBack!=true)
          SystemNavigator.pop();
        else if(widget.hasBack!=null && widget.hasBack==true)
          Navigator.pop(context);
        return true;
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Obx(() {

            return
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: size.width,
                    height: size.height,
                    child: MainMap(),
                  ),

                  Positioned(
                      top: 45,
                      child: HomeHeader(
                          RectangleBtn(),
                          InventoryBox(),
                          widget.orderList.length>0 && widget.orderList[widget.indexList].state!.id! <4?
                          RectangleBtn(id:widget.orderList[widget.indexList].id,close: true,):Container())
                  ),
                  widget.orderList.length!=0 && widget.orderList.length>1?
                  Positioned(
                    top: 110,
                    child:  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: size.width>maxItemWidth?maxItemWidth:size.width-40,
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if(widget.indexList>0)
                                    ChangeAcceptedOrder(widget.orderList.elementAt(widget.indexList-1),left: true,onClick: (){
                                      print('index before is>>${ widget.indexList}');
                                      widget.indexList-=1;
                                      print('index after is>>${ widget.indexList}');
                                      MapApiController.setCameraPosition(double.parse(widget.orderList[widget.indexList].originLat.toString()),double.parse(widget.orderList[widget.indexList].originLong.toString()));
                                      MapApiController.addMarkerOrder(widget.orderList[widget.indexList]);

                                    },),
                                ],
                              ),
                              if(widget.orderList.length>1 && widget.orderList.length-1!=widget.indexList)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ChangeAcceptedOrder(widget.orderList.elementAt(widget.indexList+1),left: false,onClick: (){
                                      widget.indexList+=1;
                                      MapApiController.setCameraPosition(double.parse(widget.orderList[widget.indexList].originLat.toString()),double.parse(widget.orderList[widget.indexList].originLong.toString()));
                                      MapApiController.addMarkerOrder(widget.orderList[widget.indexList]);
                                      print(widget.indexList);
                                    },),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),):Container(),
                  widget.orderList.length>0 && widget.orderList[0].economic==true?
                  Positioned(
                      top: 150,
                      child:OrderController.economicOrders.length!=0 && OrderController.economicOrders.length==1?
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          EconomicRequestBox(OrderController.economicOrders[0]),
                        ],
                      ):

                      OrderController.economicOrders.length!=0 && OrderController.economicOrders.length>1?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width>maxItemWidth?maxItemWidth:size.width-40,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if(OrderController.indexEconomicOrder.value>0)
                                      ChangePriceBtn(OrderController.economicOrders.elementAt(OrderController.indexEconomicOrder.value-1),left: true,onClick: (){
                                        OrderController.indexEconomicOrder.value-=1;
                                        MapApiController.setCameraPosition(double.parse(OrderController.economicOrders[OrderController.indexEconomicOrder.value].originLat.toString()),double.parse(OrderController.orders[OrderController.indexEconomicOrder.value].originLong.toString()));
                                        print(OrderController.indexEconomicOrder.value);
                                      },),
                                  ],
                                ),

                                if(OrderController.economicOrders.length>1 && OrderController.economicOrders.length-1!=OrderController.indexEconomicOrder.value)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ChangePriceBtn(OrderController.economicOrders.elementAt(OrderController.indexEconomicOrder.value+1),left: false,onClick: (){
                                        OrderController.indexEconomicOrder.value+=1;
                                        MapApiController.setCameraPosition(double.parse(OrderController.economicOrders[OrderController.indexEconomicOrder.value].originLat.toString()),double.parse(OrderController.orders[OrderController.indexEconomicOrder.value].originLong.toString()));

                                        print(OrderController.indexEconomicOrder.value);
                                      },),
                                    ],
                                  ),

                                for(int i=0;i<OrderController.economicOrders.length;i++)
                                  if(i==OrderController.indexEconomicOrder.value)
                                    EconomicRequestBox(OrderController.economicOrders[i]),
                              ],
                            ),
                          ),

                        ],
                      ):OrderController.economicOrders.length==0?Container():Container()
                  ):Container(),
                  Positioned(
                      bottom: 0,
                      child: Column(
                        children: [
                          Container(
                            width: size.width>maxItemWidth?maxItemWidth:size.width-40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    if(OrderController.acceptedOrder.value.length!=0)
                                      LocatorBtn(OrderController.acceptedOrder[OrderController.indexAcceptOrder.value],'${AppController.of(Get.context!)!.value('routing')}',onClick: (){
                                        Order order=OrderController.acceptedOrder[OrderController.indexAcceptOrder.value];

                                        print('object');
                                        showAlertDialogRouting(context,googleClick: (){
                                          if(order.state!.id==2){

                                            _launchMapsUrl('https://www.google.com/maps/dir/${UserController.myPosition.latitude},${UserController.myPosition.longitude}/${order.originLat},${order.originLong}');
                                          }
                                          else if(order.state!.id! >2){
                                            _launchMapsUrl('https://www.google.com/maps/dir/${UserController.myPosition.latitude},${UserController.myPosition.longitude}/${order.destinationLat},${order.destinationLong}');
                                          }
                                          Navigator.of(context).pop();
                                        },
                                          wazeClick: (){
                                            if(order.state!.id==2){
                                              _launchMapsUrl('https://waze.com/ul?ll=${order.originLat},${order.originLong}&navigate=yes');
                                            }
                                            else if(order.state!.id! >2){
                                              _launchMapsUrl('https://waze.com/ul?ll=${order.destinationLat},${order.destinationLong}&navigate=yes');

                                            }
                                            Navigator.of(context).pop();
                                          },);
                                      }),


                                    if(OrderController.acceptedOrder.length!=0 && OrderController.acceptedOrder[OrderController.indexAcceptOrder.value].info.length>2)
                                      Padding(
                                        padding:  EdgeInsets.only(top: 8.0),
                                        child: LocatorBtn(OrderController.acceptedOrder[OrderController.indexAcceptOrder.value], '${AppController.of(context)!.value('second destination routing')}',onClick: (){
                                          Order order=OrderController.acceptedOrder[OrderController.indexAcceptOrder.value];
                                          showAlertDialogRouting(context,googleClick: (){
                                            _launchMapsUrl('https://www.google.com/maps/dir/${UserController.myPosition.latitude},${UserController.myPosition.longitude}/${order.info.last.lat},${order.info.last.long}');
                                            Navigator.of(context).pop();
                                          },
                                            wazeClick: (){

                                              _launchMapsUrl('https://waze.com/ul?ll=${order.info.last.lat},${order.info.last.long}&navigate=yes');

                                              Navigator.of(context).pop();
                                            },);
                                        },),
                                      ),
                                  ],
                                ),
                                GpsBtn(onClick: ()async{
                                  if(kIsWeb){
                                    await UserController.getMyLocation();
                                    MapApiController.setCameraPosition(UserController.myPosition.latitude, UserController.myPosition.longitude);
                                  }
                                  else{
                                    Map<Permission, PermissionStatus> statuses = await [
                                      Permission.location,
                                    ].request();
                                    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
                                      await UserController.getMyLocation();
                                      MapApiController.setCameraPosition(UserController.myPosition.latitude, UserController.myPosition.longitude);
                                    }
                                  }
                                },),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                              padding: EdgeInsets.only(right: 20,left: 20),
                              width: size.width>maxItemWidth?maxItemWidth:size.width,
                              // height: 310,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                                  color: whiteColor
                              ),
                              child: widget.orderList.length!=0?
                              Column(
                                children: [
                                  for(int i=0;i<widget.orderList.length;i++)
                                    if(i==widget.indexList)
                                      if(widget.orderList[i].step <5)
                                        Column(
                                          children: [
                                            SizedBox(height: 5),

                                            InkWell(
                                              onTap: (){
                                                showBottomModal(context, 670,
                                                    TravelingBottomSheet(i));
                                              },
                                              child: Container(
                                                  height: 25,width: 40,
                                                  child: Img(arrow_up_icon,width: 40,height: 25)),
                                            ),
                                            SizedBox(height: 10),
                                            widget.orderList[i].step<4?
                                            AddressOriginItem('${ widget.orderList[i].info[0].address}','${AppController.of(context)!.value('origin')}' ):
                                            AddressOriginItem('${ widget.orderList[i].info[1].address}','${AppController.of(context)!.value('destination')}', ),
                                            SizedBox(height: 20),
                                            InkWell(
                                              onTap: (){
                                                OrderController.getOrderMessage(widget.orderList[i]);
                                                // Navigator.push(Get.context!, MaterialPageRoute(builder: (context)=>ChatPage()));

                                              },child:
                                            Padding(
                                              padding: EdgeInsets.only(left: 10,right: 10),
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(80),
                                                    color: dominantColorShade200.withOpacity(0.2)
                                                ),
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 10),
                                                    Img(messages_icon,width: 25,height: 25,color: blackColor),
                                                    SizedBox(width: 10),
                                                    Text('${AppController.of(context)!.value('Send a message to the passenger')}',style: AppController.fontStyle(fontTypes.captionMD, blackColor))
                                                  ],
                                                ),
                                              ),
                                            ),

                                            ),
                                            // Row(
                                            //   children: [
                                            //     Text('${ widget.orderList[i].name}',style: AppController.fontStyle(fontTypes.header5, blackColor),),
                                            //     Spacer(),
                                            //     InkWell(
                                            //       onTap:(){
                                            //         launch("tel:${ widget.orderList[i].mobile}");
                                            //       },
                                            //       child: Container(
                                            //         width: 50,
                                            //         height: 50,
                                            //         decoration: BoxDecoration(
                                            //             color: whiteColor,
                                            //             borderRadius: BorderRadius.circular(100),
                                            //             boxShadow: [BoxShadow(color: blackColor.withOpacity(0.1),blurRadius: 4,offset: Offset(1,2))]
                                            //         ),
                                            //         child: Img(calling_icon,width: 30,height: 30,color: accentColor),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            SizedBox(height: 20),
                                            Btn(btnTypes.primary,text: widget.orderList[i].step==2? '${AppController.of(context)!.value('I reached the origin')}': widget.orderList[i].step==3? '${AppController.of(context)!.value('The passenger boarded')}': widget.orderList[i].step==4? '${AppController.of(context)!.value('the end of the trip')}':"",width: size.width>maxItemWidth?maxItemWidth-40:size.width-40,loadingTag: 'change-status',onClick: (){
                                              // print('state>>>${OrderController.step.value}');
                                              OrderController.changeStatus( widget.orderList[i].id, widget.orderList[i].step,context);
                                            },),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                ],
                              ):Container()
                          ),
                        ],
                      )
                  ),
                ],
              );
          }
          ),
        ),
      ),
    );
  }
}
