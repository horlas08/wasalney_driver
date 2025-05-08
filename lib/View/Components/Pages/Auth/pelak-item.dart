import 'package:driver/Public/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../Logic/Controllers/app-controller.dart';
import '../../../../Logic/Controllers/user-controller.dart';
import '../../../../Public/styles.dart';


class Pelak extends StatelessWidget {
  const Pelak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Container(
          width: 125,
          height: 58,
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${AppController.of(context)!.value('iran')}',style: AppController.fontStyle(fontTypes.captionMD, blackColor),),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Container(width: 1,height: 20,color: additionalColor2Shade400,),
                  //     SizedBox(height: 5,)
                  //   ],
                  // ),
                  Column(
                    children: [
                      Container(width: 10,height: 2,color: Colors.red,),
                      SizedBox(height: 2),
                      Container(width: 10,height: 2,color: Colors.black,),
                    ],
                  )
                  ],),
              if(UserController.user.value.carDetails?.length!=0 && UserController.user.value.carDetails?[0].plak!=null)
              Padding(
                    padding: const EdgeInsets.only(left: 3,right: 3),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${UserController.user.value.carDetails?[0].plak}',style: AppController.fontStyle(fontTypes.bodySM, blackColor),),

                        ],
                      ),
                    ),
                  )
            ],
          ),
        );
      }
    );
  }
}
