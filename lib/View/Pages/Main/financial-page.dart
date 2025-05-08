import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/add-btn.dart';
import 'package:driver/View/Components/Buttons/switch-btn.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/Header/icon-header.dart';
import 'package:driver/View/Components/Pages/Main/checkout-box.dart';
import 'package:driver/View/Components/Pages/Main/shape.dart';
import 'package:driver/View/Components/Pages/Main/transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Models/wallet.dart';
import '../Auth/bank-information-page.dart';

class FinancialPage extends StatelessWidget {
  const FinancialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
            return Shape(300,
                [
                  SizedBox(height: 20),
                  Container(
                    width: 70,
                    height: 25,
                    decoration: BoxDecoration(
                        color: complementaryColorShade700,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child: Text('${AppController.of(context)!.value('your credit')}',style: AppController.fontStyle(fontTypes.bodySM, whiteColor),)),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: maxItemWidth,
                    child: Row(
                      children: [
                        AddBtn(),
                        Spacer(),
                        Directionality(
                            textDirection:TextDirection.ltr ,child: Text('${AppController.priceFormat(UserController.user.value.creditUser)}',style: AppController.fontStyle(fontTypes.header3, whiteColor),)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: 10),
                            Text('${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(fontTypes.bodyXL, additionalColor2Shade700)),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  CheckoutBox()
                ],
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${AppController.of(context)!.value('list of transactions')}',style: AppController.fontStyle(fontTypes.header4, blackColor),),
                    ],
                  ),
                  SizedBox(height: 40),
                  // empty page
                  UserController.user.value.wallet.isEmpty?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Img(no_data_icon,width: 275,height: 185),
                      SizedBox(height: 20),
                      Text('${AppController.of(context)!.value('No transaction has been made yet.')}',style: AppController.fontStyle(fontTypes.header6, blackColor),),
                      SizedBox(height: 60)
                    ],
                  ):
                  Column(
                    children: [
                      for(Wallet wallet in UserController.user.value.wallet.reversed)
                      Transaction(wallet),
                      SizedBox(height: 150,)
                    ],
                  ),
                  SizedBox(height: 400)
                ],
              header: [
                IconHeader(  '${AppController.of(Get.context!)!.value('edit bank information')}'
          ,onclick: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BankInformationPage()));
                }),
              ],
            );
          }
        ),
      ),
    );
  }
}
