import 'package:driver/Public/enums.dart';
import 'package:flutter/material.dart';
import '../../../Logic/Controllers/app-controller.dart';
import '../../../Public/config.dart';
import '../../../Public/images.dart';
import '../../../Public/styles.dart';
import '../../Components/General/img.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40),),color: whiteColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Img(connectionerrorIcon,width: 180,height: 170,color: appColor),
              SizedBox(height: 50),
              Text('${AppController.of(context)!.value('internet is not connected!')}',style: AppController.fontStyle(fontTypes.header4, appColor)),
              SizedBox(height: 5),
              Text('${AppController.of(context)!.value('Please check your internet connection.')}',
                  style: AppController.fontStyle(fontTypes.bodySM, appColor)),
              SizedBox(height: 45),
              InkWell(
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Container(
                  height: 45,width: 150,
                  decoration: BoxDecoration(
                    color: appColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text('${AppController.of(context)!.value('try again')}',
                        style: AppController.fontStyle(fontTypes.bodyMD,whiteColor)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
