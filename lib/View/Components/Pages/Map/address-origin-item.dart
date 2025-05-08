import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressOriginItem extends StatelessWidget {
  String title,address;
  AddressOriginItem(this.address,this.title) ;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              height: 95,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Img(origin_icon,width: 28,height: 40,),
                          SizedBox(width: 10),
                          Text('${title}',style: AppController.fontStyle(fontTypes.bodySM, blackColor),maxLines: 2,overflow: TextOverflow.ellipsis,)
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 13),
                          Img(line_icon,width: 2,height: 35,),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 25),
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        width: 270,
                        height: 65,
                        padding: EdgeInsets.only(right: 10,left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1,color: complementaryColorShade300)
                        ),
                        child: Center(
                          child: Text(address,
                            style: AppController.fontStyle(fontTypes.captionMD, blackColor),maxLines: 2,overflow: TextOverflow.fade,),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            MyDivider(color: additionalColor2Shade200,width :size.width>maxItemWidth?maxItemWidth-40:size.width-40)
          ],
        ),
      ],
    );
  }
}
