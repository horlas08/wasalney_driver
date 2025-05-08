import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:flutter/cupertino.dart';

class ShowPriceBox extends StatelessWidget {
  bool small;
  bool smallText;
  String price;
  double? width;
  double? height;
  ShowPriceBox(this.price,{this.width,this.height,this.small=false,this.smallText=false}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width??180,
      height: height??50,
      decoration: BoxDecoration(
        color: dominantColorShade700,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(price,style: AppController.fontStyle(smallText||small?fontTypes.buttonSM:fontTypes.header5, whiteColor)),
          small?Container():Container(child: Text('${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade300),textAlign: TextAlign.center,)),
        ],
      ),
    );
  }
}
