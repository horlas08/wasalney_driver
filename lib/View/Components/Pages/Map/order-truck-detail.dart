import 'package:driver/Public/enums.dart';
import 'package:flutter/material.dart';

import '../../../../Logic/Controllers/app-controller.dart';
import '../../../../Models/order.dart';
import '../../../../Public/styles.dart';
class OrderDetailTruck extends StatelessWidget {
  Order?order;
   OrderDetailTruck(this.order) ;

  @override
  Widget build(BuildContext context) {
    return  Container(child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(order!.truckDetail?.equipment!=null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('${AppController.of(context)!.value('heavy equipment and the number of workers')}',style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade800)),
              Wrap(
                children: [
                  for(var e in order!.truckDetail!.equipment)
                  Text('${e.count} ${AppController.of(context)!.value('number')} ${e.name} -  ',style: AppController.fontStyle(fontTypes.bodySM, accentColor),maxLines: null,),
                  Text('${order!.truckDetail!.countWorker}${AppController.of(context)!.value('worker number')}  ',style: AppController.fontStyle(fontTypes.bodySM, accentColor),maxLines: null,),

                ],
              ),
              SizedBox(height: 15,),
              Text('${AppController.of(context)!.value('number of floors and elevators')}',style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade800)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('${AppController.of(context)!.value('origin')} :',style: AppController.fontStyle(fontTypes.bodySM, accentColor)),
                      Text(' ${AppController.of(context)!.value('the floor')} ${order!.truckDetail!.countFloorsOrigin}       ${AppController.of(context)!.value('elevator')}   ${order!.truckDetail!.elevatorOrigin}' ,style: AppController.fontStyle(fontTypes.bodySM, accentColor)),

                    ],
                  ),
                  Row(
                    children: [
                      Text('${AppController.of(context)!.value('destination')} :',style: AppController.fontStyle(fontTypes.bodySM, accentColor)),
                      Text('${AppController.of(context)!.value('the floor')} ${order!.truckDetail!.countFloorsDestination}       ${AppController.of(context)!.value('elevator')}   ${order!.truckDetail!.elevatorDestination}' ,style: AppController.fontStyle(fontTypes.bodySM, accentColor)),

                    ],
                  ),

                ],
              )

              // MyDivider(margin: 25,color: complementaryColorShade200,),
            ],
          ),
        SizedBox(height: 20),

        if(order!.truckDetail?.date!=null && order!.truckDetail!.date!.preview!=null )
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('${AppController.of(context)!.value('date and time of removal')}',style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade800)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${AppController.of(context)!.value('day')} ${ order!.truckDetail!.date!.preview }   ${AppController.of(context)!.value('hour')}  ${order!.truckDetail!.time} ',style: AppController.fontStyle(fontTypes.bodySM, accentColor)),
                ],
              )
            ],
          ),
      ],
    ));
  }
}
