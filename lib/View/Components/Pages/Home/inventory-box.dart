import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InventoryBox extends StatelessWidget {
  const InventoryBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 65,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          Text('${AppController.of(context)!.value('inventory')}:',style: AppController.fontStyle(fontTypes.captionLG,complementaryColorShade800.withOpacity(0.7)),),
          Obx(() {
              return Directionality(
                textDirection: TextDirection.ltr,
                  child: Text(UserController.user.value.creditUser!=null?' ${AppController.priceFormat(UserController.user.value.creditUser)} ${AppController.of(context)!.value('rial')}':'0 ${AppController.of(context)!.value('rial')}',style: AppController.fontStyle(fontTypes.captionLG,complementaryColorShade800),));
            }
          ),
        ],
      ),
    );
  }
}
