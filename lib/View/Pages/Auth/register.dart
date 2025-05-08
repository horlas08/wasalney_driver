import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/config.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/loading.dart';
import 'package:driver/View/Components/Pages/Auth/register-box.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Img(appLogo,width: 200)
                            ],
                          ),
                        ),
                        Img(splashBackground_icon,color: complementaryColorShade700,width: size.width,height: 240)
                      ],
                    ),
                ),
                Container(
                  width: size.width,
                  height:size.height/2-MediaQuery.of(context).viewInsets.bottom,
                  color: whiteColor,
                )
              ],
            ),
            RegisterBox(),
          ],
        ),
      ),
    );
  }
}
