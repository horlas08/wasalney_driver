import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:driver/View/Components/Header/icon-header.dart';
import 'package:driver/View/Components/Pages/Main/key-value.dart';
import 'package:driver/View/Components/Pages/Main/score-item.dart';
import 'package:driver/View/Components/Pages/Main/shape.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/Buttons/no-color-btn.dart';
import '../../Components/Pages/Auth/pelak-item.dart';
import 'package:driver/View/Components/General/loading.dart';

import '../../Components/Popups/bottom-modal.dart';
import 'edit-information-page.dart';

class UserInformationPage extends StatelessWidget {
  const UserInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Widget row(Widget right,Widget left){
      return Row(
        children: [
          Expanded(child: right),
          Expanded(child: left),
        ],
      );
    }
    return SafeArea(
      child: Scaffold(
        body:
             Loading(loadingName: ['get-user'],getLoadedComponent: ()=>
               Obx( () {
                   return Shape(250,
                    [
                      ScoreItem()
                    ],
                    [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${AppController.of(context)!.value('individual profile')}',style: AppController.fontStyle(fontTypes.header4, blackColor),)],
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          row(KeyValue('${AppController.of(context)!.value('national code')}', '${UserController.user.value.codeMeli}'),KeyValue('${AppController.of(context)!.value('mobile number')}', '${UserController.user.value.mobile}')),
                          row(KeyValue('${AppController.of(context)!.value('certificate type')}',   UserController.user.value.certificateType?.title!=null?'${UserController.user.value.certificateType!.title}':''),
                              KeyValue('${AppController.of(context)!.value('date of certification')}',  UserController.user.value.certificatDate?.year!=null?'${UserController.user.value.certificatDate!.year}/${UserController.user.value.certificatDate!.month}/${UserController.user.value.certificatDate!.day}':'')),
                          UserController.user.value.typeActivity!.service!=null?
                          row(
                              KeyValue('${AppController.of(context)!.value('area of activity')}', '${UserController.user.value.typeActivity!.service!.title}'),
                              KeyValue('${AppController.of(context)!.value('Type of car')}', '${UserController.user.value.typeActivity!.title}')):
                          row(
                              KeyValue('${AppController.of(context)!.value('area of activity')}', '${UserController.user.value.typeActivity!.title}'),
                              KeyValue('', '')),
                        ],
                      ),
                      MyDivider(color: additionalColor2Shade300,margin: 20,width: size.width,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${AppController.of(context)!.value('vehicle specifications')}',style: AppController.fontStyle(fontTypes.header4, blackColor),)],
                      ),
                      UserController.user.value.carDetails?.length!=0?
                      Column(children: [

                        SizedBox(height: 20),
                        Column(
                          children: [
                            row(
                              KeyValue('${AppController.of(context)!.value('model and color')}', UserController.user.value.carDetails?.length!=0 && UserController.user.value.carDetails?[0].carModel!=null&& UserController.user.value.carDetails?[0].color!=null?'${UserController.user.value.carDetails![0].carModel} ${UserController.user.value.carDetails![0].color}':''),
                              Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${AppController.of(context)!.value('plaque')}',style: AppController.fontStyle(fontTypes.bodyLG, additionalColor2Shade600),),
                                Pelak(),
                                // Img(plak,width: 125,height: 40,)
                              ],
                            ),),
                            row(KeyValue('${AppController.of(context)!.value('year of manufacture of the vehicle')}', UserController.user.value.carDetails?.length!=0 && UserController.user.value.carDetails?[0].yearMade!=null?'${UserController.user.value.carDetails![0].yearMade}':''),
                                KeyValue('${AppController.of(context)!.value('fuel type')}',UserController.user.value.carDetails?.length!=0 && UserController.user.value.carDetails?[0].fuelType?.title!=null? '${UserController.user.value.carDetails![0].fuelType!.title}':'')),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     KeyValue('${AppController.of(context)!.value('vehicle Identification Number (VIN)')}',  UserController.user.value.carDetails?.length!=0 && UserController.user.value.carDetails?[0].vin!=null?'${UserController.user.value.carDetails![0].vin??""}':''),
                        //   ],
                        // ),
                        MyDivider(color: additionalColor2Shade300,margin: 20,width: size.width,),
                      ],):
                      Column(children: [

                        SizedBox(height: 20),
                        Column(
                          children: [
                            row(KeyValue('${AppController.of(context)!.value('model and color')}', ''),
                              Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${AppController.of(context)!.value('plaque')}',style: AppController.fontStyle(fontTypes.bodyLG, additionalColor2Shade600),),
                                //
                                // Pelak()
                                // Img(plak,width: 125,height: 40,)
                              ],
                            ),),
                            row(KeyValue('${AppController.of(context)!.value('year of manufacture of the vehicle')}', ''),KeyValue('${AppController.of(context)!.value('fuel type')}','')),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     KeyValue('${AppController.of(context)!.value('vehicle Identification Number (VIN)')}', ''),
                        //   ],
                        // ),
                        MyDivider(color: additionalColor2Shade300,margin: 20,width: size.width,),
                      ],),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${AppController.of(context)!.value('financial information')}',style: AppController.fontStyle(fontTypes.header4, blackColor),)],
                      ),
                      SizedBox(height: 20),
                      UserController.user.value.infoBank.length!=0?
                      Column(children: [
                        Row(
                          children: [
                            KeyValue('${AppController.of(context)!.value('shaba number')}',UserController.user.value.infoBank[0].shaba!=null? '${UserController.user.value.infoBank[0].shaba}':''),
                          ],
                        ),
                        row(KeyValue('${AppController.of(context)!.value('sheba account owner')}',UserController.user.value.infoBank[0].name!=null?'${UserController.user.value.infoBank[0].name}':''),
                            KeyValue('${AppController.of(context)!.value('card number')}',UserController.user.value.infoBank[0].cartNumber!=null?'${UserController.user.value.infoBank[0].cartNumber}':'',ltr: true,))


                      ],):  Column(children: [
                        Row(
                          children: [
                            KeyValue('${AppController.of(context)!.value('shaba number')}', ''),
                          ],
                        ),
                        row(KeyValue('${AppController.of(context)!.value('sheba account owner')}',''), Container()),
                        row(KeyValue('${AppController.of(context)!.value('card number')}',''),  Container()),

                      ],),
                      InkWell(
                        onTap: (){
                          showBottomModal(context, 325, Container(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('${AppController.of(context)!.value('logout')}',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade800),),
                                    Spacer(),
                                    Container(
                                        width: 35,
                                        height: 35,
                                        child: Img(cancle_icon,width: 13,height: 13,color: blackColor,onClick: ()=>Navigator.pop(context),))
                                  ],
                                ),
                                SizedBox(height: 20),
                                Img(logout2_icon,width: 100,height: 100,),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    NoColorBtn('${AppController.of(context)!.value('dissuasion')}',width: size.width>maxItemWidth?maxItemWidth/2-40:size.width/2-40,onClick: (){
                                      Navigator.pop(context);
                                    },),
                                    SizedBox(width: 20),
                                    InkWell(
                                      onTap: (){
                                        UserController.logout();
                                      },
                                      child: Container(
                                        width: size.width>maxItemWidth?maxItemWidth/2-40:size.width/2-40,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: errorExtraLightColor5,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(width: 1,color: errorColor)
                                        ),
                                        child: Center(
                                          child: Text('${AppController.of(context)!.value('get out')}',style: AppController.fontStyle(fontTypes.buttonSM, errorColor),),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ));
                        },
                        child: Container(
                          width: size.width>maxItemWidth?maxItemWidth:size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1,color: errorLightColor5)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Img(logout_icon,width: 25,height: 25,color: errorLightColor5,),
                              SizedBox(width: 10),
                              Text('${AppController.of(context)!.value('logout')}',style: AppController.fontStyle(fontTypes.buttonSM, errorLightColor5),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 450,)
                    ],
                    header: [
                      IconHeader( '',icon: null,)
                    ],);
                 }
               ),
            )

      ),
    );
  }
}
