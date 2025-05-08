import 'package:dotted_border/dotted_border.dart';
import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/loading.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Public/config.dart';
import '../../../../Public/images.dart';
import '../../Buttons/btn-with-icon.dart';
import '../../Popups/bottom-modal.dart';

class DocumentBox extends StatelessWidget {
  bool condition,isNetwork;
  String?pathImage;
  String?text;
  String?loadingName;
  Function?onChange;
  DocumentBox({this.loadingName,this.condition=false,this.isNetwork=false,this.pathImage='',this.text,this.onChange});
  UserController userController=Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 20,left: 20,right: 20),
      child: DottedBorder(
        strokeWidth: 3,
        borderType: BorderType.RRect,
        dashPattern: [8,4],
        radius: Radius.circular(20),
        color: dominantColor,
        child:  Container(
          height: 220,
          padding: EdgeInsets.only(right: 10,left: 10,top: 15,bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: whiteColor
          ),
          child:  Column(
                      children: [
                        Text('$text', style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade800),),
                        Expanded(child: Loading(loadingName: ['${loadingName}'],getLoadedComponent: ()=>
                            Img(this.pathImage!=null?'${this.pathImage}':folder_icon, width: 70, height: 70,isNetwork: this.isNetwork,isPv: true,))),
                        MyDivider(color: additionalColor2Shade200,),
                        SizedBox(height: 15),
                        condition == true ?
                        Btn(
                          btnTypes.secondary, text: '${AppController.of(context)!.value('reshoot')}', height: 40, width: 290,onClick: (){
                          showBottomModal(context,250, Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // SizedBox(height: 50,),
                              Container(
                                width: maxItemWidth,
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    BtnIcon(icon: Img(folder_icon,width:30 ,height: 30,color: appColor,),text: '${AppController.of(context)!.value('choose from the gallery')}',onclick: (){
                                      Navigator.pop(context);
                                      userController.chooseDoc(ImageSource.gallery,onChange: (img){
                                        this.onChange!(img);
                                      });
                                    },),
                                    BtnIcon(icon: Img(camera_icon,width:30 ,height: 30,color: appColor),text: '${AppController.of(context)!.value('open the camera')}',onclick: (){
                                      Navigator.pop(context);
                                      userController.chooseDoc(ImageSource.camera,onChange: (img){
                                        this.onChange!(img);
                                      });
                                    },),
                                  ],
                                ),
                              )
                            ],
                          ));
                        },):
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Btn(btnTypes.primary, width: 85, height: 40, text: '${AppController.of(context)!.value('upload')}',onClick: (){
                              userController.chooseDoc(ImageSource.gallery,onChange: (img){
                                this.onChange!(img);
                              });
                            },),
                            SizedBox(width: 10),
                            Btn(btnTypes.secondary, width: 175,
                              height: 40,
                              text: '${AppController.of(context)!.value('reshoot')}',
                              onClick: (){
                                userController.chooseDoc(ImageSource.camera,onChange: (img){
                                  this.onChange!(img);
                                });
                              },
                            ),
                          ],
                        )
                      ],

          )
        ),
      ),
    );
  }
}
