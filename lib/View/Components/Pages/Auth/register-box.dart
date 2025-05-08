import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:driver/View/Components/Inputs/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../Public/config.dart';
import '../../Inputs/auth-input.dart';

class RegisterBox extends StatelessWidget {
  const RegisterBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 45,left: 45,top: 80),
          width: maxItemWidth,
          decoration: BoxDecoration(
            boxShadow: boxShadow,
            color: whiteColor,
            borderRadius: BorderRadius.circular(20)
          ),
          // because of divider that doesnt have padding put the other parts in container with padding
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(20),
                      child: Text('${AppController.of(context)!.value('welcome!')}',style: AppController.fontStyle(fontTypes.header3, blackColor),)
                  ),
                ],
              ),
              MyDivider(width: maxItemWidth,),
              Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Img(call_icon,width: 25,height: 25,color: additionalColor2Shade700),
                          SizedBox(width: 10),
                          Text('${AppController.of(context)!.value('mobile number')}',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),)
                        ],
                      ),
                      SizedBox(height: 20),
                      AuthInput(hint: '${AppController.of(context)!.value('enter your mobile number')}',isNumber: true,onChange: (text){
                        UserController.mobile=text;
                      },),
                      SizedBox(height: 15,),
                      RichText(
                        text: TextSpan(
                          text: '${AppController.of(context)!.value('with register by okay')} ',
                          style:TextStyle(color: additionalColor2Shade700,fontWeight: FontWeight.w700,fontSize: 12,),

                          children:  <TextSpan>[
                            TextSpan(text:'${AppController.of(context)!.value('agree with')} ', style: TextStyle(color: additionalColor2Shade700,fontWeight: FontWeight.w700,fontSize: 12,)),

                            TextSpan(text: '${AppController.of(context)!.value('terms and conditions')} ', style: TextStyle(color: dominantColorShade400,fontWeight: FontWeight.w700,fontSize: 12,),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                launchUrlString(baseUrl+'/terms-and-conditions');
                              },
                            ),
                            TextSpan(text: 'و ',style: TextStyle(color: additionalColor2Shade700,fontWeight: FontWeight.w700,fontSize: 12,)),

                            TextSpan(text: '${AppController.of(context)!.value('privicy and policy')}',style: TextStyle(color: dominantColorShade400,fontWeight: FontWeight.w700,fontSize: 12,),recognizer: TapGestureRecognizer()..onTap = () {
                              launchUrlString(baseUrl+'/privacy-policy');
                            },),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      Btn(btnTypes.black,text: '${AppController.of(context)!.value('send code')}',loadingTag: 'login',onClick: (){
                        UserController.login(true);
                      },)
                    ],
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }
}
