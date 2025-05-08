import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:flutter/cupertino.dart';

class AddressDestinationItem extends StatelessWidget {
  String address;
  AddressDestinationItem(this.address,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            MyDivider(color: additionalColor2Shade200,width :size.width>maxItemWidth?maxItemWidth-40:size.width-40),
            Container(
              height: 95,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 13),
                          Img(line_icon,width: 2,height: 35,),
                        ],
                      ),
                      Row(
                        children: [
                          Img(destination_icon,width: 28,height: 40,),
                          SizedBox(width: 10),
                          Text('${AppController.of(context)!.value('destination')}',style: AppController.fontStyle(fontTypes.bodySM, blackColor))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 25),
                  Column(
                    children: [
                      SizedBox(height: 20),
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
                            style: AppController.fontStyle(fontTypes.captionMD, blackColor),maxLines: 2,overflow: TextOverflow.clip,),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
