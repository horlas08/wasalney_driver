import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:flutter/cupertino.dart';

import '../../../../Models/wallet.dart';

class Transaction extends StatelessWidget {
  Wallet wallet;
  Transaction(this.wallet);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 3,right: 3),
                      height: 25,
                      decoration: BoxDecoration(
                          color: wallet.type!.id!=2?Color(0xffE7FFF8):errorExtraLightColor5,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text('${wallet.type!.title}',style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade700),)),
                    ),
                    SizedBox(width: 20),
                    Text('${AppController.priceFormat(wallet.price)} ${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(fontTypes.buttonSM, wallet.type!.id!=2?successColor:errorColor),),
                    SizedBox(width: 20),
                    Text('${wallet.date!.year}/${wallet.date!.month}/${wallet.date!.day}  ${wallet.date!.time}',style: AppController.fontStyle(fontTypes.buttonLG, blackColor),),
                  ],
                ),
                // Text('${wallet.type!.title} موجودی ',style: AppController.fontStyle(fontTypes.bodyLG, additionalColor2Shade600),),
                Row(
                  children: [
                    Text('${wallet.title}  ',style: AppController.fontStyle(fontTypes.bodyLG, additionalColor2Shade600),),
                    if(wallet.code!=null)
                      Text(' ${AppController.of(context)!.value('code')} : ${wallet.code}',style: AppController.fontStyle(fontTypes.captionMD, additionalColor2Shade700),),

                  ],
                ),
              ],
            ),
            Spacer(),
            Img(arrow_left2_icon,width: 25,height: 25,color: additionalColor2Shade600,)
          ],
        ),
        MyDivider(color: additionalColor2Shade300,margin: 15,width: size.width,)
      ],
    );
  }
}
