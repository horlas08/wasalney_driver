import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/Header/title-header.dart';
import 'package:driver/View/Components/Pages/Main/shape.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Components/Inputs/auth-input.dart';
import '../../Components/Popups/snackbar.dart';

class AddMoneyPage extends StatelessWidget {
  const AddMoneyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Shape(160,
            [
              SizedBox(height: 20),
              Obx( () {
                  return Container(
                    width: maxItemWidth,
                    child: Row(
                      children: [
                        Spacer(),
                        Directionality(
                            textDirection:TextDirection.ltr ,child: Text('${AppController.priceFormat(UserController.user.value.creditUser)}',style: AppController.fontStyle(fontTypes.header4, whiteColor),)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: 10),
                            Text('${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(fontTypes.bodyXL, additionalColor2Shade500)),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  );
                }
              ),
              ],
            [
              Container(
                width: maxItemWidth,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${AppController.of(context)!.value('inventory increase')}',style: AppController.fontStyle(fontTypes.header4, blackColor),),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        Img(money_recive_icon),
                        SizedBox(width: 5),
                        Text('${AppController.of(context)!.value('inter code')}',style: AppController.fontStyle(fontTypes.bodySM, blackColor),)
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                        height: 50,
                        width: maxItemWidth,
                        alignment: Alignment.center,
                        child: AuthInput(
                          hint: '${AppController.of(context)!.value('inter code')}',
                          onChange: (text){
                            print(text);
                            UserController.user.value.codeWallet=int.parse(text);
                            print(UserController.user.value.codeWallet);
                          },
                          initValue:UserController.user.value.codeWallet!=null?'${UserController.user.value.codeWallet}':'' ,
                        ),
                    ),
                    SizedBox(height: 40),
                    Btn(btnTypes.primary,text: '${AppController.of(context)!.value('payment')}',loadingTag: 'add-money',onClick: () async {
                      if(UserController.user.value.codeWallet!=null){
                        await UserController.addWallet(UserController.user.value.codeWallet!);
                      }
                      else{
                        showSnackbar(snackTypes.error,  '${AppController.of(context)!.value('inter code')}!');
                      }
                    },)
                  ],
                ),
              )
              ],
          header: [
            Column(
              children: [
                SizedBox(height: 30),
                TitleHeader(title: '${AppController.of(context)!.value('your credit')}',closeIcon: true,),
              ],
            ),
          ],
          headerHeight: 90,
        ),
      ),
    );
  }
}
