import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/config.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/Pages/Auth/information-box.dart';
import 'package:flutter/material.dart';

import '../../Components/General/column-scroll.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: dominantColorShade100,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Img(appLogo,width: 150),
                      Img(splashBackground_icon,color: complementaryColorShade700,width: size.width,height: 240)
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height/2-MediaQuery.of(context).viewInsets.bottom,
                  color: whiteColor,
                )
              ],
            ),
            ColumnScroll(
              padding:0 ,
              children: [
                InformationBox(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
