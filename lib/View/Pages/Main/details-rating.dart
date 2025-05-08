import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:driver/View/Components/General/star-rating.dart';
import 'package:driver/View/Components/Pages/Main/shape.dart';
import 'package:driver/View/Components/Pages/Main/star-chart-box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsRating extends StatelessWidget {
  const DetailsRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        UserController.rate.value.qty!<12?
        Shape(110,
          [],
          header: [
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: 50,
                        height: 50,
                        child: Img(arrow_right_icon,width: 25,height: 25,color: whiteColor,))),
                Spacer(),
                Text('${AppController.of(context)!.value('score details')}',style: AppController.fontStyle(fontTypes.header5, whiteColor),),
                Spacer(),
                SizedBox(width: 30)
              ],
            ),
            SizedBox(height: 20),
          ],
          [
            SizedBox(height: 30),
            Img(star_gif,width: 230,height: 230),
            SizedBox(height: 20),
            Container(
              width: 350,
              child: Text(
                '${AppController.of(context)!.value('To display the details of your points, you need at least 13 passengers to rate you.')}',
                style: AppController.fontStyle(fontTypes.bodyXL, blackColor),
                maxLines: 3,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              ),
            )
          ],

        ):
        Shape(110,
        [
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Container(
                      width: 50,
                      height: 50,
                      child: Img(arrow_right_icon,width: 25,height: 25,color: whiteColor,onClick: (){
                        Navigator.pop(context);
                      },))),
              Spacer(),
              Text('${AppController.of(context)!.value('score details')}\n',style: AppController.fontStyle(fontTypes.header5, whiteColor),),
              Spacer(),
              SizedBox(width: 25)
            ],
          ),
          SizedBox(height: 20),

        ],
        [
          Text('${UserController.rate.value.level}',style: AppController.fontStyle(fontTypes.header4, additionalColor2Shade800)),
          SizedBox(height: 20),
          Container(
            width: 280,
            height: 50,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: dominantColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                Text('${UserController.rate.value.rate} ${AppController.of(context)!.value('of 5')}',style: AppController.fontStyle(fontTypes.bodyMD, whiteColor),),
                SizedBox(width: 20),
                StarRating(width: 160,editable: false,rating: 4,)
              ],
            ),
          ),
          SizedBox(height: 15),
          Text('${UserController.rate.value.message}',style: AppController.fontStyle(fontTypes.bodyLG, additionalColor2Shade600),),
          MyDivider(color: additionalColor2Shade200,margin: 30,width: 400,),
          StarChartBox(),
          Text(
            '${AppController.of(context)!.value('based on the last 100 rated trips')}',
            style: AppController.fontStyle(fontTypes.bodySM, blackColor),
            maxLines: 2,
            overflow: TextOverflow.clip,
          ),
        ],
      ),
      ),
    );
  }
}
