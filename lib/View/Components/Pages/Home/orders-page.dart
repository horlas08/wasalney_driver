import 'package:driver/Public/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Logic/Controllers/app-controller.dart';
import '../../../../Logic/Controllers/order-controller.dart';
import '../../../../Models/order.dart';
import '../../../../Public/images.dart';
import '../../../../Public/styles.dart';
import '../../General/column-scroll.dart';
import '../../General/img.dart';
import '../../General/loading.dart';
import '../../Header/tab-item-orders.dart';
import '../Main/order-history-item.dart';

class OrdersHistoryPage extends StatelessWidget {
  const OrdersHistoryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Container(
      width: size.width,
      height: size.height,
      color: whiteColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: maxItemWidth,
            height: size.height,
            color: whiteColor,
            padding: EdgeInsets.only(top: 100),
            child:
            TabOrders(pages: [
              Loading(loadingName:['my-order'],
                getLoadedComponent:()=>
                    ColumnScroll(
                      padding: 0,
                      checkEmptyList:( )=>OrderController.acceptedOrder.value.isEmpty,
                      emptyList: Column(
                        children: [
                          SizedBox(height: 100),
                          Img(no_data_icon,width: 280,height: 185,),
                          SizedBox(height: 20),
                          Text('${AppController.of(context)!.value('You have not had any orders yet')}',style: AppController.fontStyle(fontTypes.header6, blackColor),),
                          SizedBox(height: 10),
                          Text('${AppController.of(context)!.value('Here you can view your orders')}',style: AppController.fontStyle(fontTypes.captionMD, blackColor),),],
                      ),
                      children: [
                        for(Order order in OrderController.acceptedOrder)
                          OrderHistoryItem(order: order,type: 'accept',)
                      ],
                    ),
              ),
              Loading(loadingName:['future-order'],
                getLoadedComponent:()=>
                    Obx( () {
                      return ColumnScroll(
                        padding: 0,
                        checkEmptyList:( )=>OrderController.futureOrders.value.isEmpty,
                        emptyList: Column(
                          children: [
                            SizedBox(height: 100),
                            Img(no_data_icon,width: 280,height: 185,),
                            SizedBox(height: 20),
                            Text('${AppController.of(context)!.value('You have not had any orders yet')}',style: AppController.fontStyle(fontTypes.header6, blackColor),),
                            SizedBox(height: 10),
                            Text('${AppController.of(context)!.value('Here you can view your orders')}',style: AppController.fontStyle(fontTypes.captionMD, blackColor),),],
                        ),
                        children: [
                          for(Order order in OrderController.futureOrders)
                            OrderHistoryItem(order: order,type: 'future',)
                        ],
                      );
                    }
                    ),
              ),

              Loading(loadingName:['last-order'],
                getLoadedComponent:()=>
                    ColumnScroll(
                      padding: 0,
                      checkEmptyList:( )=>OrderController.lastOrders.value.isEmpty,
                      emptyList: Column(
                        children: [
                          SizedBox(height: 100),
                          Img(no_data_icon,width: 280,height: 185,),
                          SizedBox(height: 20),
                          Text('${AppController.of(context)!.value('You have not had any orders yet')}',style: AppController.fontStyle(fontTypes.header6, blackColor),),
                          SizedBox(height: 10),
                          Text('${AppController.of(context)!.value('Here you can view your orders')}',style: AppController.fontStyle(fontTypes.captionMD, blackColor),),],
                      ),
                      children: [
                        for(Order order in OrderController.lastOrders)
                          OrderHistoryItem(order: order,type: 'last-order',)
                      ],
                    ),
              ),
            ],),
          ),
          Positioned(
            top: 0,
            child:  Container(
              width: maxItemWidth,
              height: 100,
              color:dominantColorShade700,
              child: Center(child: Text('${AppController.of(context)!.value('trips')}',style: AppController.fontStyle(fontTypes.header4,whiteColor),)),
            ),),
        ],
      ),

    );
  }
}
