import 'package:driver/Public/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Logic/Controllers/app-controller.dart';
import '../../../Logic/Controllers/main-controller.dart';
import '../../../Logic/Controllers/user-controller.dart';
import '../../../Public/images.dart';
import '../../../Public/styles.dart';
import '../../Components/Buttons/btn.dart';
import '../../Components/General/img.dart';
import '../../Components/Pages/Main/shape.dart';
import '../Auth/edit-profile-page.dart';
class MessageAdmin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: ()async {
        SystemNavigator.pop();
        return true;
      },child: SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body:
        Stack(
          children: [
            Positioned(
              top:0,
              child: Container(
                width: size.width,
                height: size.height,
                color: whiteColor,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                    overscroll: false,
                    // androidOverscrollIndicator: null
                  ),
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          width: size.width,
                          height: 119,
                          color: dominantColorShade700,
                          child: Stack(
                              children: [
                                Positioned(
                                    top : 0,
                                    child: Container(
                                      width: size.width,
                                      height: 100,
                                      padding: EdgeInsets.only(top: 10,right: 20,left: 20),
                                      child: Column(
                                        children:  [
                                              SizedBox(height: 15),
                                              Text('${AppController.of(context)!.value('admin message')}',style: AppController.fontStyle(fontTypes.header4, whiteColor),),
                                            ],
                                      ),
                                    )
                                ),
                                Positioned(
                                  bottom: -1,
                                  child: Container(
                                    width: size.width,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                        color: whiteColor
                                    ),
                                  ),
                                )
                              ]
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              width: size.width,

                              padding: EdgeInsets.only(right: 20,left: 20),
                              decoration: BoxDecoration(
                                  color: whiteColor
                              ),
                              child: Column(
                                  children:
                                    [
                                      SizedBox(height: 50),
                                      // Img(no_data_icon,width: 280,height: 185,),
                                      SizedBox(height: 20),
                                      Text('${AppController.of(context)!.value('your status')}:  ${UserController.user.value.statusDriver!.title}',style: AppController.fontStyle(fontTypes.header6, blackColor),),
                                      SizedBox(height: 10),
                                      if(UserController.user.value.description!=null)
                                      Row(
                                        children: [
                                          Text('${AppController.of(context)!.value('admin notice')}:',style: AppController.fontStyle(fontTypes.captionMD, blackColor),),
                                          if(UserController.user.value.description!=null)
                                          Text('${UserController.user.value.description} ',style: AppController.fontStyle(fontTypes.captionMD, blackColor),),
                                        ],
                                      ),
                                        SizedBox(height: 20,),
                                        if(UserController.user.value.statusDriver!.id!=1)
                                        Btn(btnTypes.primary,width: 200,text: '${AppController.of(context)!.value('re-register information')}',onClick: ()async{
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage(changePage: true,)));

                                          // Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => P()), (route) => false);
                                        })

                                    ]
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Positioned(
            //   top: 0,
            //   child: Container(
            //     padding: EdgeInsets.only(right: 20,left: 20),
            //     width: size.width,
            //     height: 70,
            //     color: header.length>0?dominantColorShade700:Colors.transparent,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children:
            //       header
            //       ,
            //     ),
            //   ),
            // ),
          ],
        )
        // Shape(100,
        //     [
        //       SizedBox(height: 15),
        //       Text('${AppController.of(context)!.value('admin message')}',style: AppController.fontStyle(fontTypes.header4, whiteColor),),
        //     ],
        //     [
        //       SizedBox(height: 50),
        //       // Img(no_data_icon,width: 280,height: 185,),
        //       SizedBox(height: 20),
        //       Text('شما تا کنون پیامی ندارید!',style: AppController.fontStyle(fontTypes.header6, blackColor),),
        //       SizedBox(height: 10),
        //       Text('(اینجا می توانید پیام های خود را ببینید)',style: AppController.fontStyle(fontTypes.captionMD, blackColor),),
        //
        //     ]),
      ),
    ),
    );
  }
}
