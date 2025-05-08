import 'package:driver/Logic/Controllers/main-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/General/column-scroll.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/loading.dart';
import 'package:driver/View/Components/Inputs/edit-input.dart';
import 'package:driver/View/Components/Pages/Main/license-plak-motor.dart';
import 'package:driver/View/Components/Pages/Main/license-plate.dart';
import 'package:driver/View/Components/Pages/Main/list-selector.dart';
import 'package:driver/View/Components/Pages/Selectors/edit-select.dart';
import 'package:driver/View/Components/Popups/calender.dart';
import 'package:driver/View/Components/Popups/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Logic/Controllers/app-controller.dart';
import '../../../Logic/Controllers/user-controller.dart';
import '../../../Public/api-urls.dart';
import '../../../Public/config.dart';
import '../../Components/Buttons/btn-with-icon.dart';
import '../../Components/Popups/bottom-modal.dart';

class EditProfilePage extends StatefulWidget {
  bool?changePage;
  EditProfilePage({this.changePage = false}) ;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body:
        Obx( () {
            return Container(
              width: size.width,
              height: size.height,
              padding: EdgeInsets.only(top: 20,bottom: 20),
              child: Stack(
                children: [
                  ColumnScroll(
                    padding: 20,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Img(arrow_right_icon,width: 25,height: 25,color: additionalColor2Shade800,onClick: (){
                            Navigator.pop(context);
                          },),
                          Spacer(),
                          InkWell(

                              onTap: (){
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
                                            setState(() {

                                            });
                                            Navigator.pop(context);
                                            UserController.chooseProfile(ImageSource.gallery,false
                                            //     onChange: (selectedImage)  {
                                            //   UserController.updateAvatar(selectedImage);
                                            // }
                                            );
                                            // setState(() {
                                            //
                                            // });
                                          },),
                                          BtnIcon(icon: Img(camera_icon,width:30 ,height: 30,color: appColor),text: '${AppController.of(context)!.value('open the camera')}',onclick: (){
                                            setState(() {

                                            });
                                            Navigator.pop(context);
                                            UserController.chooseProfile(ImageSource.camera,true
                                            //     onChange: (selectedImage)  {
                                            //   UserController.updateAvatar(selectedImage);
                                            // }
                                            );

                                          },),
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                              },

                            child: Loading(loadingName: ['set-profile'],height: 120,width: 120,size: 20,getLoadedComponent: ()=>
                                   Container(
                                      width: 120,height: 120,
                                      child: Stack(
                                        children: [
                                         Container(
                                                  width: 120,height: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(100),
                                                      color: whiteColor,
                                                      boxShadow: boxShadow
                                                  ),
                                                  child:
                                                  UserController.user.value.image.value!=''?
                                                  Img(basePathImgMain+UserController.user.value.image.value,width: 120,height: 120,radius: 100,isNetwork: true,):
                                                  Img(user_icon,width: 120,height: 120,radius: 100,)
                                              ),

                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            child: Container(
                                              width: 37,height: 37,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  color: whiteColor,
                                                  boxShadow: boxShadow
                                              ),
                                              child: Img(camera_icon),
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                )

                          ),
                          Spacer(),
                          SizedBox(width: 25,)
                        ],
                      ),
                      SizedBox(height: 30),
                      ListSelector('${AppController.of(context)!.value('device specifications')}', '${AppController.of(context)!.value('individual profile')}',
                          [
                            EditSelect('${AppController.of(context)!.value('fuel type')} :',  MainController.document.fuelType!,
                              hint:UserController.user.value.carDetails?.length!=0&&UserController.user.value.carDetails?[0].fuelType != null?'${UserController.user.value.carDetails![0].fuelType!.title }':UserController.carDetails.fuelType?.title!=null?UserController.carDetails.fuelType!.title:'${AppController.of(context)!.value('choose')}' ,
                              onSelect: (val){
                                UserController.carDetails.fuelType=val;
                              },),
                            EditInput('${AppController.of(context)!.value('vehicle model')} :',
                              initValue:UserController.user.value.carDetails?.length!=0&&UserController.user.value.carDetails?[0].carModel != null?'${UserController.user.value.carDetails![0].carModel }':'' ,
                                onChange: (text){
                                  UserController.carDetails.carModel=text;
                                },),

                            EditInput('${AppController.of(context)!.value('vehicle color')} :',
                              initValue: UserController.user.value.carDetails?.length!=0&& UserController.user.value.carDetails?[0].color != null?'${UserController.user.value.carDetails![0].color }':'',
                              onChange: (text){
                              UserController.carDetails.color=text;
                            }, ),
                            EditInput('${AppController.of(context)!.value('year of manufacture')} :',
                                initValue: UserController.user.value.carDetails?.length!=0&& UserController.user.value.carDetails?[0].yearMade != null?'${UserController.user.value.carDetails![0].yearMade }':''
                                ,onChange: (text){
                              UserController.carDetails.yearMade=text;
                            },),


                            EditInput('${AppController.of(context)!.value('plaque')} :',
                            initValue: UserController.user.value.carDetails?.length!=0&& UserController.user.value.carDetails?[0].plak != null?'${UserController.user.value.carDetails![0].plak }':''
                                ,onChange: (text){
                              print('testttttttttt');
                              UserController.carDetails.plak=text;
                                  print('plaaakkk>>${UserController.user.value.plak}');
                                }
                            ),
                            SizedBox(height: 25),
                            Btn(btnTypes.primary,text: '${AppController.of(context)!.value('save changes')}',loadingTag: 'edit-car-detail',onClick: (){
                              print('check>>${UserController.carDetails.fuelType==null}-${UserController.carDetails.yearMade==null}-${UserController.carDetails.color==null}-${UserController.carDetails.carModel==null}-${UserController.user.value.image.value==''}-${UserController.carDetails.plak}');
                                if( UserController.carDetails.fuelType==null|| UserController.carDetails.yearMade==null|| UserController.carDetails.plak==null|| UserController.carDetails.color==null||UserController.carDetails.carModel==null || UserController.user.value.image.value=='') {
                                  showSnackbar(snackTypes.error, '${AppController.of(context)!.value('Complete all the items, including the profile picture')}');
                                }
                                else
                                UserController.editCarDetail(changePage: this.widget.changePage!);
                            },),
                          ],
                          [
                            EditInput('${AppController.of(context)!.value('name and family')} :',
                              initValue:  UserController.user.value.name != null?'${UserController.user.value.name}':'',
                              onChange: (text){
                                UserController.user.value.name=text;
                              },),
                            EditInput('${AppController.of(context)!.value('mobile number')} :',
                              initValue:  UserController.user.value.mobile != null?'${UserController.user.value.mobile}':'',
                              onChange: (text){
                                UserController.user.value.mobile=text;
                              }
                              ,isnum: true,
                            ),
                            EditInput('${AppController.of(context)!.value('national code')} :',  initValue:  UserController.user.value.codeMeli != null?'${UserController.user.value.codeMeli}':'',
                              onChange: (text){
                                UserController.user.value.codeMeli=text;
                              },isnum: true,),


                            EditInput('${AppController.of(context)!.value('Certificate validity period (years)')} :', initValue:  UserController.user.value.certificateValidity != null?'${UserController.user.value.certificateValidity}':'',
                              onChange: (text){
                                UserController.user.value.certificateValidity=text;
                              },isnum: true,),
                            EditSelect('${AppController.of(context)!.value('certificate type')} :',  MainController.document.certificatesTypes!,hint:UserController.user.value.certificateType?.title!=null?UserController.user.value.certificateType!.title:'${AppController.of(context)!.value('choose')}' ,onSelect: (val){
                              UserController.user.value.certificateType=val;
                            },),

                            Calender('${AppController.of(context)!.value('date of certification')}',
                              UserController.user.value.certificatDate?.main!=null?'${UserController.user.value.certificatDate!.year}/${UserController.user.value.certificatDate!.month}/${UserController.user.value.certificatDate!.day}':UserController.user.value.dateCertificate!=null?'${UserController.user.value.dateCertificate}':'${AppController.of(context)!.value('Select the date and time')}',
                              onClick: (val){
                              UserController.user.value.dateCertificate=val;
                              print(UserController.user.value.dateCertificate);
                            },),
                            SizedBox(height: 25),
                            Btn(btnTypes.primary,text: '${AppController.of(context)!.value('save changes')}',loadingTag: 'edit-profile',onClick: (){
                              print('profilee>>>${UserController.user.value.image.value==''} ${UserController.user.value.name==null}${UserController.user.value.codeMeli==null}${UserController.user.value.mobile==null}${UserController.user.value.certificateValidity==null}${UserController.user.value.certificateType==null}${UserController.user.value.certificatDate?.main==null}');
                              if(UserController.user.value.name == null ||UserController.user.value.codeMeli == null ||UserController.user.value.mobile == null ||UserController.user.value.certificateValidity == null ||UserController.user.value.certificateType == null ||( UserController.user.value.dateCertificate==null)|| UserController.user.value.image.value=='' ){
                                showSnackbar(snackTypes.error, '${AppController.of(context)!.value('Complete all the items, including the profile picture')}');
                              }
                              else
                              UserController.editProfile(this.widget.changePage!);
                            },)
                          ]
                      )
                    ],
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

