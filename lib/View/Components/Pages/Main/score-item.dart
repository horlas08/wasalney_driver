import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Pages/Main/details-rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../Public/api-urls.dart';
import '../../Popups/snackbar.dart';

class ScoreItem extends StatelessWidget {
  const ScoreItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx( () {
            return Row(
              children: [
                UserController.user.value.image.value!=''?
                Img(basePathImgMain+UserController.user.value.image.value,width: 85,height: 85,radius: 100,isNetwork: true,):
                Img(user_icon,width: 85,height: 85,radius: 100,),
                SizedBox(width: 10,),
                Column(
                  children: [
                    Text('${UserController.user.value.name}',style: AppController.fontStyle(fontTypes.header4, whiteColor),),
                    Row(
                      children: [
                        Container(
                          // width: 135,
                            height: 45,
                            decoration: BoxDecoration(
                                color: dominantColorShade200,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                )
                            ),
                            child: Center(child: Wrap(
                              spacing: 2,
                              children: [
                                Text('${AppController.of(context)!.value('identification code')} :  ',style: AppController.fontStyle(fontTypes.bodySM,additionalColor1Shade800),),
                                if(UserController.user.value.code!=null)
                                  Text('${UserController.user.value.code} ',style: AppController.fontStyle(fontTypes.bodySM,additionalColor1Shade800),),
                              ],
                            ))),
                        Container(
                          width: 35,height: 35,
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Img(copy_icon,width: 25,height: 25,color: whiteColor,onClick: ()async{
                            await Clipboard.setData(ClipboardData(text: "${UserController.user.value.code}"));
                            showSnackbar(snackTypes.success, '${AppController.of(context)!.value('Your code has been successfully copied')}');

                          },),
                        )
                      ],
                    ),
                  ],
                ),

              ],
            );
          }
        ),
        SizedBox(height: 5),
        Row(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsRating()));
              },
              child: Container(
                // width: 135,
                height: 45,
                padding: EdgeInsets.only(right: 10,left: 10),
                decoration: BoxDecoration(
                    color: dominantColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Img(medal_star_icon,width: 25,height: 25,color: warningColor),
                    SizedBox(width: 5),
                    Text('${AppController.of(context)!.value('score')}: ${UserController.rate.value.rate}',style: AppController.fontStyle(fontTypes.bodyMD, whiteColor),),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsRating()));
              },
              child: Container(
                // width: 135,
                height: 45,
                padding: EdgeInsets.only(right: 10,left: 10),
                decoration: BoxDecoration(
                    color: dominantColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Img(medal_star_icon,width: 25,height: 25,color: warningColor),
                    SizedBox(width: 5),
                    Text('${AppController.of(context)!.value('customer club points')}: ${UserController.user.value.rate.value}',style: AppController.fontStyle(fontTypes.bodyMD, whiteColor),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
