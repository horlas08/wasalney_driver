
import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/config.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Logic/Controllers/main-controller.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1),(){
      MainController.getInitData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
       body: Column(
         children: [
           Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Img(appLogo,width: 200)
                   ],
                 ),
                 SizedBox(height: 20,),
                 Text('${AppController.of(context)!.value('(driver)')}',style: AppController.fontStyle(fontTypes.header7, blackColor)),
               ],
             ),
           ),
           Img(splashBackground_icon,color: complementaryColorShade700,width: size.width,height: 230)
         ],
       ),
      ),
    );
  }
}




