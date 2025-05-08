import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Public/api-urls.dart';
import '../../../../Public/images.dart';
import '../../../Pages/Auth/proflie-btn-details.dart';

class ProfileBtn extends StatelessWidget {
  const ProfileBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
       UserController.dailyReport();
       Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileBtnDetails()));
      },
      child: Container(
        width: 55,
        height: 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: 0,
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(child: Img(UserController.user.value.image.value!=''?basePathImgMain+UserController.user.value.image.value:user_icon,width: 50,height: 50,radius: 20,isNetwork: UserController.user.value.image.value!=''?true:false,)),
                )
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: 35,
                  height: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: whiteColor
                  ),
                  child: Obx( () {
                      return Center(
                        child: Text(UserController.rate.value.rate!=null?'${UserController.rate.value.rate}':'',style: TextStyle(color: blackColor,fontWeight: FontWeight.w700,fontSize: 10,),),
                      );
                    }
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
