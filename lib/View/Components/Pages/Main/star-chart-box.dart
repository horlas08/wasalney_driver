import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:flutter/cupertino.dart';

class StarChartBox extends StatelessWidget {
  const StarChartBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget row(int num,int score){
      return Container(
        width: 400,
        height: 40,
        child: Row(
          children: [
            // Text('$num',style: AppController.fontStyle(fontTypes.bodyLG, blackColor)),
            // SizedBox(width: 10),
            Img(star_icon,width: 25,height: 25,color: warningLightColor,),
            SizedBox(width: 20,),
            Container(
              width: 250,
              height: 10,
              decoration: BoxDecoration(
                color: additionalColor2Shade200,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                children: [
                  Container(
                    width: 250/100*score,
                    height: 10,
                    decoration: BoxDecoration(
                        color: warningLightColor,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            Text('$score ${AppController.of(context)!.value('person')}',style: AppController.fontStyle(fontTypes.bodyLG, blackColor),)
          ],
        ),
      );
    }
    return Container(
      width: 400,
      height: 200,
      child: Column(
        children: [
          if(UserController.rate.value.details!.length!=0)
          for(var i in UserController.rate.value.details!)
              row(UserController.rate.value.details!.length, i),
        ],
      ),
    );
  }
}
