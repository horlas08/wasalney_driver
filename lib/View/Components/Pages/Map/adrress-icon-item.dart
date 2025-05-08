import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:flutter/cupertino.dart';

import '../../../../Models/order.dart';

class AddressIconItem extends StatelessWidget {
  Order?order;
  AddressIconItem(this.order) ;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Img(origin_icon,width: 20,height: 30,),
                SizedBox(width: 5),
                Text('${AppController.of(context)!.value('origin')}',style: AppController.fontStyle(fontTypes.bodySM, blackColor))
              ],
            ),
            Row(
              children: [
                SizedBox(width: 10),
                Img(line_icon,width: 2,height: 40,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Img(destination_icon,width: 20,height: 30,),
                SizedBox(width: 10),
                Text('${AppController.of(context)!.value('destination')}',style: AppController.fontStyle(fontTypes.bodySM, blackColor))
              ],
            ),
            if(order!.info.length>2)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 13),
                  Img(line_icon,width: 2,height: 40,),
                ],
              ),
            if(order!.info.length>2)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Img(destination_icon,width: 28,height: 40,),
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
              // margin: EdgeInsets.only(left: 15),
              width: 270,
              height: 65,
              padding: EdgeInsets.only(right: 10,left: 10,bottom: 10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1,color: complementaryColorShade300)
              ),
              child: Center(
                child: Text('${order!.info[0].address}',
                  style: AppController.fontStyle(fontTypes.captionMD, blackColor),maxLines: 2,overflow: TextOverflow.clip,),
              ),
            ),
            for(var info in order!.info.skip(1))
              Container(
                width: 270,
                height: 65,
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
    );
  }
}
