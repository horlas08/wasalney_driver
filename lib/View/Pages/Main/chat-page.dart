import 'package:driver/Models/message-order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Logic/Controllers/app-controller.dart';
import '../../../Logic/Controllers/order-controller.dart';
import '../../../Models/message.dart';
import '../../../Models/order.dart';
import '../../../Public/styles.dart';
import '../../Components/General/column-scroll.dart';
import '../../Components/General/loading.dart';
import '../../Components/Pages/Chat/chat-box.dart';
import '../../Components/Pages/Chat/chat-input.dart';
import '../../Components/Pages/Chat/header-chat.dart';
class ChatPage extends StatelessWidget {
  Order?order;
  ChatPage(this.order) ;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width:size.width ,
          height: size.height,
          color: additionalColor1Shade101,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ColumnScroll(
                padding: 0,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Loading(
                    loadingName: ['order-message'],
                    getLoadedComponent:()=>  Padding(
                      padding: EdgeInsets.only(left: 25,right: 25,bottom: 25,top: 150),
                      child: Obx( () {
                          return
                            OrderController.messages.value.length!=0?
                            ColumnScroll(
                              padding: 0,
                            children: [
                              for(MessageOrder message in OrderController.messages.value)
                              Row(
                                mainAxisAlignment: message.driverSent==true? MainAxisAlignment.start:MainAxisAlignment.end,
                                children: [
                                  ChatBox( message,),
                                ],
                              )
                            ],
                          ):Container();
                        }
                      ),
                    ),
                  ),

                ],
              ),
              Positioned(
                  bottom: 20,
                  left: 25,
                  right: 25,
                  child: Container(
                    width:size.width,
                    child: ChatInput(this.order,hintText: "${AppController.of(context)!.value('Write your message')}...",),
                  )),
              Positioned(
                  top: 0,
                  child: Container(
                    width:size.width,
                    child:   ChatHeader(this.order),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
