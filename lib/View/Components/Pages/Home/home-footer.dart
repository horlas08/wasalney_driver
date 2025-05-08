import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/main-controller.dart';
import 'package:driver/Logic/Controllers/map-controller.dart';
import 'package:driver/Logic/Controllers/order-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Models/marker-name.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/switch-btn.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Pages/Main/message-page.dart';
import 'package:driver/View/Pages/Map/home-map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Public/config.dart';

class HomeFooter extends StatelessWidget {
  bool full;
  bool changePage=false;
  HomeFooter(this.changePage,{this.full=false}) : super();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: full?size.width:size.width>maxItemWidth?maxItemWidth:size.width,
      height: 90,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(offset: Offset(0,-5),blurRadius: 15,color: blackColor.withOpacity(0.1))],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
        color: whiteColor
      ),
      child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(

                onTap: (){
                  print(changePage);
                  if(changePage==true){
                    MainController.changePage();
                    changePage=false;
                  }

                  MainController.homePage.value='map';
                  print(changePage);

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Img(map_icon,width: 25,height: 25,color: MainController.homePage.value=='map'?
                    accentColor:additionalColor1Shade700),
                    Text('${AppController.of(context)!.value('map')}',style: AppController.fontStyle(fontTypes.captionSM, MainController.homePage.value=='map'?
                    accentColor:additionalColor1Shade700),
                    )
                  ],
                ),
              ),
              SwitchBtn('${AppController.of(context)!.value('on')}','${AppController.of(context)!.value('off')}',onChange: (val) async {
                if(val){

                  UserController.changeState(1);
                }

                else{

                  MapApiController.removeMarker(MarkerName.origin);
                  MapApiController.removeMarker(MarkerName.des);
                  MapApiController.removeMarker(MarkerName.secDes);
                  MapApiController.removeMarker(MarkerName.newDes);
                  UserController.changeState(0);
                  }},
              ),
              InkWell(
                onTap: () async {
                  // OrderController.progressOrder();

                  print(changePage);
                  if(changePage==true){
                    MainController.changePage();
                    changePage=false;
                  }
                  MainController.homePage.value='message';


                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Img(menu_board_icon,width: 25,height: 25,color: MainController.homePage.value=='message'?
                    accentColor:additionalColor1Shade700),
                    Text('${AppController.of(context)!.value('trips')}',style: AppController.fontStyle(fontTypes.captionSM,MainController.homePage.value=='message'?
                    accentColor:additionalColor1Shade700),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
