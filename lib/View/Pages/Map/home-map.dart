import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/main-controller.dart';
import 'package:driver/Logic/Controllers/map-controller.dart';
import 'package:driver/Models/marker-name.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:driver/View/Components/Pages/Home/gps-btn.dart';
import 'package:driver/View/Components/Pages/Home/home-footer.dart';
import 'package:driver/View/Components/Pages/Home/inventory-box.dart';
import 'package:driver/View/Components/Pages/Home/orders-page.dart';
import 'package:driver/View/Components/Pages/Home/profile-btn.dart';
import 'package:driver/View/Components/Pages/Main/popup-main.dart';
import 'package:driver/View/Pages/Main/financial-page.dart';
import 'package:driver/View/Pages/Auth/user-information-page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Logic/Controllers/order-controller.dart';
import '../../../Logic/Controllers/user-controller.dart';
import '../../../Models/message.dart';
import '../../../Models/order.dart';
import '../../../Public/config.dart';
import '../../Components/Buttons/switch-btn.dart';
import '../../Components/General/column-scroll.dart';
import '../../Components/General/loading.dart';
import '../../Components/Header/tab-item-orders.dart';
import '../../Components/Pages/Main/order-history-item.dart';
import '../../Components/Pages/Main/shape.dart';
import '../../Components/Pages/Map/change-price-btn.dart';
import '../../Components/Pages/Map/map.dart';
import '../../Components/Pages/Map/request-trip-box.dart';
import '../../Components/Popups/snackbar.dart';
import '../Main/report-page.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({Key? key}) : super(key: key);

  @override
  State<HomeMap> createState() => _HomeMapState();
}

// class _HomeMapState extends State<HomeMap>  with WidgetsBindingObserver{
class _HomeMapState extends State<HomeMap>  with WidgetsBindingObserver  {
  int i=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Future.delayed(Duration(seconds: 1),(){
    UserController.getMyLocation();
    setState(() {
      Future.delayed(Duration(seconds: 1),(){
      MapApiController.setCameraPosition(UserController.myPosition.latitude, UserController.myPosition.longitude);
      });
    });


    // });
    // MapApiController.mainController!.animateCamera(CameraUpdate.newLatLng(LatLng(UserController.myPosition.latitude, UserController.myPosition.longitude,),));
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('state home >>>$state');
    if (state == AppLifecycleState.resumed) {
      // App came to the foreground
      // call update data at here
      setState(() {});
      OrderController.allOrders();
    }
  }
  @override
  Widget build(BuildContext context) {
    print('set state>>>${OrderController.orders.value.length}');
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()async {
        SystemNavigator.pop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Obx(() {
            return Stack(
              alignment: Alignment.center,
              children: [

                Container(
                    width: size.width,
                    height: size.height,
                    child: MainMap()
                ),
                MainController.homePage.value=='message'?
                OrdersHistoryPage()
                    :Container(),
                // MainController.homePage.value=='message'?
                // Container(
                //   width: size.width,
                //   height: size.height,
                //   child:Shape(100,
                //       [
                //         SizedBox(height: 15),
                //         Text('${AppController.of(context)!.value('messages')}',style: AppController.fontStyle(fontTypes.header4, whiteColor),),
                //       ],
                //       [
                //
                //         Loading(loadingName: ['get-message'],height: size.height-300,getLoadedComponent: ()=>
                //             ColumnScroll(
                //                 padding: 0,
                //                 // loadingTag: ['message'],
                //                 checkEmptyList:( )=>UserController.messages.value.isEmpty,
                //                 emptyList: Column(
                //                   children: [
                //                     SizedBox(height: 100),
                //                     Img(no_data_icon,width: 280,height: 185,),
                //                     SizedBox(height: 20),
                //                     Text('${AppController.of(context)!.value('you have no message yet!')}',style: AppController.fontStyle(fontTypes.header6, blackColor),),
                //                     SizedBox(height: 10),
                //                     Text('${AppController.of(context)!.value('you can see your messages here')}',style: AppController.fontStyle(fontTypes.captionMD, blackColor),),],
                //                 ),
                //
                //                 getLoadedWidgets:()=>
                //                     ColumnScroll(
                //                       padding: 0,
                //                       children: [
                //                         for(Message text in UserController.messages.value)
                //                           Column(
                //                             mainAxisSize: MainAxisSize.min,
                //                             children: [
                //                               Container(
                //                                 decoration: BoxDecoration(
                //                                     boxShadow: boxShadow,
                //                                     borderRadius: BorderRadius.circular(15),
                //                                     color: whiteColor,
                //                                     border: Border.all(color: additionalColor1Shade100)
                //                                 ),
                //                                 padding: EdgeInsets.all(15),
                //                                 child:Column(
                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                //                                   mainAxisAlignment: MainAxisAlignment.start,
                //                                   children: [
                //                                     Text('${text.message}',style: AppController.fontStyle(fontTypes.bodySM, blackColor),),
                //                                     SizedBox(height: 10,),
                //                                     Row(
                //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                                       children: [
                //                                         Row(
                //                                           children: [
                //                                             Img(manegementIcon,width: 15,height: 15,),
                //                                             SizedBox(width: 2,),
                //                                             Text('${AppController.of(context)!.value('management')}',style: AppController.fontStyle(fontTypes.bodySM, accentColor),),
                //
                //                                           ],
                //                                         ),
                //                                         Directionality(
                //                                           textDirection: TextDirection.ltr,
                //                                             child: Text('${text.date!.main!.replaceAll('-', '/')}',style: AppController.fontStyle(fontTypes.captionMD, accentColor),)),
                //
                //                                       ],
                //                                     )
                //                                   ],
                //                                 ),
                //                               ),
                //                               SizedBox(height: 20,)
                //                             ],
                //                           ),
                //                         SizedBox(height: 100,)
                //                       ],
                //                     )
                //
                //             ),
                //         )
                //       ]),
                // ):Container(),
                MainController.homePage.value!='message'?
                Positioned(
                    top: 45,
                    child:
                    ( UserController.user.value.state==false) && OrderController.acceptedOrder.length==0?
                    Container(
                      width: size.width>maxItemWidth?maxItemWidth:size.width-40,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                i==1?i=2:i=1;
                              });
                            },
                            child: Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: boxShadow,
                                  color: whiteColor
                              ),
                              child: Img(menu_icon,width: 30,height: 30,color: dominantColorShade400),
                            ),
                          ),
                          Spacer(),

                          InventoryBox(),

                          Spacer(),

                          ProfileBtn(),
                        ],
                      ),
                    ):
                    Container(
                      width: size.width>maxItemWidth?maxItemWidth:size.width-40,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                i==1?i=2:i=1;
                              });
                            },
                            child: Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: boxShadow,
                                  color: whiteColor
                              ),
                              child: Img(menu_icon,width: 30,height: 30,color: dominantColorShade400),
                            ),
                          ),
                          Spacer(),

                          SwitchBtn('${AppController.of(context)!.value('on')}','${AppController.of(context)!.value('off')}',onChange: (val){
                            if(val)
                              UserController.changeState(1);
                            else
                             {
                               setState(() {
                                 MapApiController.removeMarker(MarkerName.origin);
                                 MapApiController.removeMarker(MarkerName.des);
                                 MapApiController.removeMarker(MarkerName.secDes);
                                 MapApiController.removeMarker(MarkerName.newDes);
                               });

                               UserController.changeState(0);
                             }
                          },),

                          Spacer(),

                          ProfileBtn(),
                        ],
                      ),
                    )
                ):Container(),
                MainController.homePage.value!='message'?
                Positioned(
                    bottom: 210,
                    child: Container(
                      width: size.width>maxItemWidth?maxItemWidth:size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: size.width>maxItemWidth?0:20),
                          GpsBtn(onClick: () async {
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
                                setState(() {
                                  MapApiController.mainController!.animateCamera(CameraUpdate.newLatLng(LatLng(UserController.myPosition.latitude, UserController.myPosition.longitude,),));

                                });
                              }
                            }
                          },)
                        ],
                      ),
                    )
                ):Container(),

                if( UserController.user.value.state==false)
                  PopupMainPage(heigth:  i==1?0:470,onChangeClose: (){
                    setState(() {
                      i==1?i=2:i=1;
                    });
                  },),
                UserController.user.value.state==false?
                Positioned(
                  bottom: 0,
                  child: HomeFooter(false),
                ):

                OrderController.orders.value.length==0?
                Container():
                OrderController.orders.value.length!=0 &&MainController.homePage.value!='message'?
                Positioned(
                    bottom: 25,
                    child:OrderController.orders.value.length!=0 && OrderController.orders.value.length==1?
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TakingTripBox(OrderController.orders[0]),
                      ],
                    ):
                    OrderController.orders.value.length!=0 && OrderController.orders.value.length>1?
                    Column(
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
                                  if(OrderController.indexOrder.value>0)
                                    ChangePriceBtn(OrderController.orders.elementAt(OrderController.indexOrder.value-1),left: true,onClick: (){

                                      double latDes=double.parse(OrderController.orders[OrderController.indexOrder.value].destinationLat.toString());
                                      double langDes=double.parse(OrderController.orders[OrderController.indexOrder.value].destinationLong.toString());
                                      // MapApiController.removeMarker(MarkerName.origin);
                                      // MapApiController.removeMarker(MarkerName.des);
                                      // MapApiController.removeMarker(MarkerName.newDes);
                                      // MapApiController.removeMarker(MarkerName.secDes);
                                      //
                                      // MapApiController.setMarker(latOrigin, langOrigin, MarkerName.origin, origin_icon);
                                      // MapApiController.setMarker(latDes, langDes, MarkerName.des, destination_icon);
                                      // if(OrderController.orders[OrderController.indexOrder.value].info.length>2){
                                      //   MapApiController.setMarker(double.parse(OrderController.orders[OrderController.indexOrder.value].info[2].lat.toString()), double.parse(OrderController.orders[OrderController.indexOrder.value].info[2].long.toString()), MarkerName.secDes, sec_destination_icon);
                                      // }
                                      OrderController.indexOrder.value-=1;
                                      double latOrigin=double.parse(OrderController.orders[OrderController.indexOrder.value].originLat.toString());
                                      double langOrigin=double.parse(OrderController.orders[OrderController.indexOrder.value].originLong.toString());
                                      MapApiController.setCameraPosition(latOrigin,langOrigin);
                                      MapApiController.addMarkerOrder(OrderController.orders[OrderController.indexOrder.value]);

                                      print(OrderController.indexOrder.value);

                                    },),
                                ],
                              ),
                              if(OrderController.orders.length>1 && OrderController.orders.length-1!=OrderController.indexOrder.value)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ChangePriceBtn(OrderController.orders.elementAt(OrderController.indexOrder.value+1),left: false,onClick: (){
                                      OrderController.indexOrder.value+=1;
                                      MapApiController.setCameraPosition(double.parse(OrderController.orders[OrderController.indexOrder.value].originLat.toString()),double.parse(OrderController.orders[OrderController.indexOrder.value].originLong.toString()));
                                      print(OrderController.indexOrder.value);
                                      MapApiController.addMarkerOrder(OrderController.orders[OrderController.indexOrder.value]);
                                    },
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        for(int i=0;i<OrderController.orders.length;i++)
                          if(i==OrderController.indexOrder.value)
                            TakingTripBox(OrderController.orders[i]),
                      ],
                    ):OrderController.orders.length==0?Container():Container()
                ):
                Container(),
                if( UserController.user.value.state!=false)
                  PopupMainPage(heigth:  i==1?0:470,onChangeClose: (){
                    setState(() {
                      i==1?i=2:i=1;
                    });
                  },),

              ],
            );
          }
          ),
        ),
      ),
    );
  }
}


Widget CustomRow(String icon,String title,Function onClick,{Color? color}){
  return InkWell(
    onTap: (){
      onClick();
    },
    child: Row(
      children: [
        Img(icon,width: 25,height: 25,color:color?? additionalColor2Shade800),
        SizedBox(width: 20),
        Text(title,style: AppController.fontStyle(fontTypes.bodySM, color??blackColor))
      ],
    ),
  );
}
Widget box2(String icon,String title,Function onclick){
  return InkWell(
    onTap: (){
      onclick();
    },
    child: Container(
      width: 110,
      height: 65,
      padding: EdgeInsets.only(top: 6,bottom: 6),
      decoration: BoxDecoration(
        color: complementaryColorShade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Img(icon,width: 25,height: 25,color: additionalColor2Shade800),
          SizedBox(height: 3),
          Text(title,style: AppController.fontStyle(fontTypes.captionSM,additionalColor2Shade800))
        ],
      ),
    ),
  );
}
Widget box(String icon,String title){
  return Container(
    width: 110,
    height: 65,
    padding: EdgeInsets.only(top: 6,bottom: 6),
    decoration: BoxDecoration(
      color: complementaryColorShade100,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Img(icon,width: 25,height: 25,color: additionalColor2Shade800),
        SizedBox(height: 3),
        Text(title,style: AppController.fontStyle(fontTypes.overlineSM,additionalColor2Shade800))
      ],
    ),
  );
}

