import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/Pages/Main/shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Logic/Controllers/user-controller.dart';
import '../../../Models/message.dart';
import '../../Components/General/column-scroll.dart';
import '../../Components/General/loading.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return  WillPopScope(
      onWillPop: ()async {
        SystemNavigator.pop();
        return true;
      },child: SafeArea(
      child: Scaffold(
          backgroundColor: whiteColor,
          body:Container(
            width: size.width,
            height: size.height,
            child:Shape(100,
                [
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Img(arrow_right_icon,color: whiteColor,onClick: (){
                        Navigator.pop(context);

                      },),
                      Spacer(),
                      Text('${AppController.of(context)!.value('messages')}',style: AppController.fontStyle(fontTypes.header4, whiteColor),),
                      Spacer(),
                    ],
                  ),
                ],
                [

                  Loading(loadingName: ['get-message'],height: size.height-300,getLoadedComponent: ()=>
                      ColumnScroll(
                          padding: 0,
                          // loadingTag: ['message'],
                          checkEmptyList:( )=>UserController.messages.value.isEmpty,
                          emptyList: Column(
                            children: [
                              SizedBox(height: 100),
                              Img(no_data_icon,width: 280,height: 185,),
                              SizedBox(height: 20),
                              Text('${AppController.of(context)!.value('you have no message yet!')}',style: AppController.fontStyle(fontTypes.header6, blackColor),),
                              SizedBox(height: 10),
                              Text('${AppController.of(context)!.value('you can see your messages here')}',style: AppController.fontStyle(fontTypes.captionMD, blackColor),),],
                          ),

                          getLoadedWidgets:()=>
                              Column(
                                children: [
                                  for(Message text in UserController.messages.value)
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              boxShadow: boxShadow,
                                              borderRadius: BorderRadius.circular(15),
                                              color: whiteColor,
                                              border: Border.all(color: additionalColor1Shade100)
                                          ),
                                          padding: EdgeInsets.all(15),
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text('${text.message}',style: AppController.fontStyle(fontTypes.bodySM, blackColor),),
                                              SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Img(manegementIcon,width: 15,height: 15,),
                                                      SizedBox(width: 2,),
                                                      Text('${AppController.of(context)!.value('management')}',style: AppController.fontStyle(fontTypes.bodySM, accentColor),),

                                                    ],
                                                  ),
                                                  Text('${text.date!.preview}',style: AppController.fontStyle(fontTypes.captionMD, accentColor),),

                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20,)
                                      ],
                                    ),
                                ],
                              )

                      ),
                  )
                ]),
          )
      ),
    ),
    );
  }
}
