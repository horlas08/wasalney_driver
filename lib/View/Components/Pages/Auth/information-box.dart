import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/Inputs/input.dart';
import 'package:driver/View/Components/Popups/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../Logic/Controllers/main-controller.dart';
import '../../Inputs/auth-input.dart';
import '../Selectors/select-box.dart';

class InformationBox extends StatelessWidget {
  const InformationBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Img(arrow_right_icon,height: 25,width: 25,color: additionalColor2Shade700,
                onClick: (){
                Navigator.pop(context);
                },
              ),
              SizedBox(height: 15),
              Text('${AppController.of(context)!.value('Enter your details')}',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
              SizedBox(height: 30),
              Row(
                children: [
                  Img(user_icon,height: 25,width: 25,color: additionalColor2Shade700),
                  SizedBox(width: 10),
                  Text('${AppController.of(context)!.value('name and family')} *',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                ],
              ),
              SizedBox(height: 15),
              AuthInput(
                initValue: UserController.user.value.name!=null?'${UserController.user.value.name}':'',
                hint: '${AppController.of(context)!.value('enter your first and last name')}',
                onChange: (text){
                UserController.user.value.name=text;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Img(personal_call_icon,height: 25,width: 25,color: additionalColor2Shade700),
                  SizedBox(width: 10),
                  Text(' ${AppController.of(context)!.value('national code')} *',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                ],
              ),
              SizedBox(height: 15),
              AuthInput(
                initValue: UserController.user.value.codeMeli!=null?'${UserController.user.value.codeMeli}':'',

                hint: '${AppController.of(context)!.value('enter your national code.')}',isNumber: true,
                onChange: (text){
                  UserController.user.value.codeMeli=text;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Img(personal_call_icon,height: 25,width: 25,color: additionalColor2Shade700),
                  SizedBox(width: 10),
                  Text('${AppController.of(context)!.value('gender')} *',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                ],
              ),
              SizedBox(height: 15),
              SelectBox(
                UserController.genders,width: maxItemWidth,text: UserController.user.value.gender!=null ?'${UserController.user.value.gender!.title}':'${AppController.of(context)!.value('choose')}',
                onSelect: (val){
                  print(val);
                  UserController.user.value.gender=val;
                },
                backColor: whiteColor,
                borderColor: additionalColor2Shade800              ,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Img(calling2_icon,height: 25,width: 25,color: additionalColor2Shade700),
                  SizedBox(width: 10),
                  Text(' ${AppController.of(context)!.value('the number of a close relative')} *',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                ],
              ),
              SizedBox(height: 15),
              AuthInput(
                initValue: UserController.user.value.familyNumber!=null?'${UserController.user.value.familyNumber}':'',

                hint: '${AppController.of(context)!.value('enter the number of one of your close relatives.')}',isNumber: true,
                onChange: (text){
                  UserController.user.value.familyNumber=text;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Img(personal_call_icon,height: 25,width: 25,color: additionalColor2Shade700),
                  SizedBox(width: 10),
                  Text('${AppController.of(context)!.value('identification code (optional)')}',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                ],
              ),
              SizedBox(height: 15),
              AuthInput(hint: '${AppController.of(context)!.value('Enter your identification code...')}',isNumber: true,
                onChange: (text){
                  UserController.user.value.introCode=text;
                },
              ),
              SizedBox(height: 25),
              Btn(btnTypes.black,text: '${AppController.of(context)!.value('continue')}',loadingTag: 'edit-user',onClick: ()async{
                if( UserController.user.value.codeMeli==null || UserController.user.value.name==null || UserController.user.value.familyNumber==null|| UserController.user.value.gender==null){
                  showSnackbar(snackTypes.error, '${AppController.of(context)!.value('All fields with an asterisk are mandatory.')}');
                }
                else
                await UserController.editUser('info');
              },
              ),
              SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text('حساب کاربری دارید ؟',style: AppController.fontStyle(fontTypes.captionMD, additionalColor2Shade700),),
              //     Text('ورود',style: AppController.fontStyle(fontTypes.captionLG, dominantColorShade400),),
              //   ],
              // )
            ],
          ),
        ),
      ],
    );
  }
}
