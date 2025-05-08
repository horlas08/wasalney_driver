import 'package:driver/Public/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Logic/Controllers/app-controller.dart';
import '../../../Logic/Controllers/main-controller.dart';
import '../../../Logic/Controllers/user-controller.dart';
import '../../../Public/config.dart';
import '../../../Public/images.dart';
import '../../../Public/styles.dart';
import '../../Components/Buttons/btn.dart';
import '../../Components/General/column-scroll.dart';
import '../../Components/General/img.dart';
import '../../Components/Pages/Selectors/select-box-sub-service.dart';
import '../../Components/Pages/Selectors/select-box.dart';
import '../../Components/Popups/snackbar.dart';
class ActivityTypeUser extends StatefulWidget {

  @override
  State<ActivityTypeUser> createState() => _ActivityTypeUserState();
}

class _ActivityTypeUserState extends State<ActivityTypeUser> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: dominantColorShade100,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  child: Column(
                    children: [

                      Padding(
                        padding:  EdgeInsets.only(top: 20),
                        child: Img(appLogo,width: 150),
                      ),
                      Img(splashBackground_icon,color: complementaryColorShade700,width: size.width,height: 240)
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height/2-MediaQuery.of(context).viewInsets.bottom,
                  color: whiteColor,
                )
              ],
            ),
            Obx( () {
              return ColumnScroll(
                padding:0 ,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 20,left: 20,bottom: 10,top: 10),
                          margin: EdgeInsets.only(right: 45,left: 45,top: 40),
                          width: maxItemWidth,

                          decoration: BoxDecoration(
                              boxShadow: boxShadow,
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child:UserController.user.value.parentType!=null && UserController.user.value.typeActivity!=null?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Img(arrow_right_icon,height: 25,width: 25,color: additionalColor2Shade700,
                                onClick: (){
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(height: 15),
                              Text('${AppController.of(context)!.value('Choose your field of activity')} ',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  Img(personal_call_icon,height: 25,width: 25,color: additionalColor2Shade700),
                                  SizedBox(width: 10),
                                  Text(' ${AppController.of(context)!.value('area of activity')} :',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                                ],
                              ),
                              SizedBox(height: 15),
                              SelectBox(
                                MainController.servicesShow,width: maxItemWidth,text: UserController.user.value.parentType!=null ?'${UserController.user.value.parentType!.title}':'${AppController.of(context)!.value('choice')}',
                                onSelect: (val){
                                  print(val);
                                  UserController.user.value.parentType=val;
                                  setState(() {

                                  });
                                },
                                backColor: whiteColor,
                                borderColor: additionalColor2Shade800  ,
                              ),
                              if(UserController.user.value.parentType!=null)
                                if(MainController.subServices.any((element) => element.service!.id==UserController.user.value.parentType!.id))
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Img(car_icon2,height: 25,width: 25,color: additionalColor2Shade700),
                                          SizedBox(width: 10),
                                          Text(' ${AppController.of(context)!.value('Type of car')} :',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      SelectBoxSubService(
                                        MainController.services,width: maxItemWidth,text: UserController.user.value.typeActivity!=null ?'${UserController.user.value.typeActivity!.title}':'${AppController.of(context)!.value('choice')}',
                                        onSelect: (val){
                                          print(val);
                                          UserController.user.value.typeActivity=val;
                                          setState(() {

                                          });
                                        },
                                        backColor: whiteColor,
                                        borderColor: additionalColor2Shade800,
                                      ),

                                    ],
                                  ),
                              SizedBox(height: 25),
                              Btn(btnTypes.black,text: '${AppController.of(context)!.value('continue')}',loadingTag: 'edit-user',onClick: ()async{
                                if(UserController.user.value.typeActivity==null ){
                                  showSnackbar(snackTypes.error, '${AppController.of(context)!.value('Choose your field of activity')}');
                                }
                                else
                                  await UserController.setActivityUser();
                              },
                              ),
                              SizedBox(height: 20),
                            ],
                          ):
                          UserController.user.value.parentType!=null || UserController.user.value.typeActivity!=null?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Img(arrow_right_icon,height: 25,width: 25,color: additionalColor2Shade700,
                                onClick: (){
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(height: 15),
                              Text('${AppController.of(context)!.value('Choose your field of activity')}  ',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  Img(personal_call_icon,height: 25,width: 25,color: additionalColor2Shade700),
                                  SizedBox(width: 10),
                                  Text(' ${AppController.of(context)!.value('area of activity')} :',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                                ],
                              ),
                              SizedBox(height: 15),
                              SelectBox(
                                MainController.servicesShow,width: maxItemWidth,text: UserController.user.value.parentType!=null ?'${UserController.user.value.parentType!.title}':'${AppController.of(context)!.value('choice')}',
                                onSelect: (val){
                                  print(val);
                                  UserController.user.value.parentType=val;
                                  if(!MainController.subServices.any((element) => element.service!.id==UserController.user.value.parentType!.id)){
                                    UserController.user.value.typeActivity=val;
                                    // UserController.user.value.parentType=null;
                                  }
                                  setState(() {

                                  });
                                },
                                backColor: whiteColor,
                                borderColor: additionalColor2Shade800  ,
                              ),
                              if(UserController.user.value.parentType!=null)
                                if(MainController.subServices.any((element) => element.service!.id==UserController.user.value.parentType!.id))
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Img(car_icon2,height: 25,width: 25,color: additionalColor2Shade700),
                                          SizedBox(width: 10),
                                          Text(' ${AppController.of(context)!.value('Type of car')} :',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      SelectBoxSubService(
                                        MainController.services,width: maxItemWidth,text: UserController.user.value.typeActivity!=null ?'${UserController.user.value.typeActivity!.title}':'${AppController.of(context)!.value('continue')}',
                                        onSelect: (val){
                                          print(val);
                                          UserController.user.value.typeActivity=val;
                                          setState(() {

                                          });
                                        },
                                        backColor: whiteColor,
                                        borderColor: additionalColor2Shade800              ,
                                      ),

                                    ],
                                  ),
                              SizedBox(height: 25),
                              Btn(btnTypes.black,text: '${AppController.of(context)!.value('continue')}',loadingTag: 'edit-user',onClick: ()async{
                                if(UserController.user.value.typeActivity==null ){
                                  showSnackbar(snackTypes.error, '${AppController.of(context)!.value('Choose your field of activity')}');
                                }
                                else
                                  await UserController.setActivityUser();
                              },
                              ),
                              SizedBox(height: 20),
                            ],
                          ):Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Img(arrow_right_icon,height: 25,width: 25,color: additionalColor2Shade700,
                                onClick: (){
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(height: 15),
                              Text('${AppController.of(context)!.value('Choose your field of activity')} ',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  Img(personal_call_icon,height: 25,width: 25,color: additionalColor2Shade700),
                                  SizedBox(width: 10),
                                  Text(' ${AppController.of(context)!.value('area of activity')} :',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                                ],
                              ),
                              SizedBox(height: 15),
                              SelectBox(
                                MainController.servicesShow,width: maxItemWidth,text: UserController.user.value.parentType!=null ?'${UserController.user.value.parentType!.title}':'${AppController.of(context)!.value('choice')}',
                                onSelect: (val){
                                  print(val);
                                  UserController.user.value.parentType=val;
                                  if(!MainController.subServices.any((element) => element.service!.id==UserController.user.value.parentType!.id)){
                                    UserController.user.value.typeActivity=val;
                                    UserController.user.value.parentType=null;
                                  }
                                  setState(() {

                                  });
                                },

                                backColor: whiteColor,
                                borderColor: additionalColor2Shade800  ,
                              ),
                              if(UserController.user.value.parentType!=null)
                                if(MainController.subServices.any((element) => element.service!.id==UserController.user.value.parentType!.id))
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Img(car_icon2,height: 25,width: 25,color: additionalColor2Shade700),
                                          SizedBox(width: 10),
                                          Text(' ${AppController.of(context)!.value('Type of car')} :',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      SelectBoxSubService(
                                        MainController.services,width: maxItemWidth,text: UserController.user.value.typeActivity!=null ?'${UserController.user.value.typeActivity!.title}':'${AppController.of(context)!.value('choice')}',
                                        onSelect: (val){
                                          print(val);
                                          UserController.user.value.typeActivity=val;
                                          setState(() {

                                          });
                                        },
                                        backColor: whiteColor,
                                        borderColor: additionalColor2Shade800              ,
                                      ),

                                    ],
                                  ),
                              SizedBox(height: 25),
                              Btn(btnTypes.black,text: '${AppController.of(context)!.value('continue')}',loadingTag: 'edit-user',onClick: ()async{
                                if(UserController.user.value.typeActivity==null ){
                                  showSnackbar(snackTypes.error, '${AppController.of(context)!.value('Choose your field of activity')}');
                                }
                                else
                                  await UserController.setActivityUser();
                              },
                              ),
                              SizedBox(height: 20),
                            ],
                          )
                      ),
                    ],
                  )
                ],
              );
            }
            )
          ],
        ),
      ),
    );
  }
}
