
import 'package:flutter/material.dart';

import '../../../../Logic/Controllers/order-controller.dart';
import '../../../../Models/order.dart';
import '../../../../Public/images.dart';
import '../../../../Public/styles.dart';
import '../../General/img.dart';
import '../../General/loading.dart';

typedef void SearchChangeCallback(String value);

class ChatInput extends StatefulWidget {
  Order?order;
  Function? onChange;
  var initValue;
  String?hintText;

  ChatInput(this.order,{this.onChange,this.initValue,this.hintText});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  Function? onChangeSend;

  final controller = TextEditingController();
 TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      // width:size.width,
      height: 55,
      padding: EdgeInsets.only(left: 24,right: 30),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: whiteColor,
          // color:backgroundColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: boxShadow
          // border: Border.all(color: itemColor7)
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: 5,
              minLines: 1,
              controller: _textController,
              style: TextStyle(color: blackColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: this.widget.hintText,
                  hintStyle: TextStyle(color: additionalColor2Shade400,fontSize:15 ,fontWeight: FontWeight.w700)
              ),
              onChanged: (text){
                OrderController.message.value=text;

                // this.onChange!(text);
              },

            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Loading(loadingName: ['send-message'],
                height:25,
                width: 25,
                size: 15,
                getLoadedComponent:()=> Img( sendIcon,width:25,height:25 ,color: complementaryColorShade600,onClick: () async {
                  print('OrderController.message.value>>>${OrderController.message.value}');
                  String trimmedMessage = OrderController.message.value.trim();
                  if(trimmedMessage.isNotEmpty){
                    await OrderController.sendMessage(widget.order!.id);
                    _textController.clear();
                  }

                },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}





