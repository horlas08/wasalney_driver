import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:driver/View/Components/Popups/bottom-modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../Logic/Controllers/user-controller.dart';

class GpsBtn extends StatelessWidget {
  Function?onClick;
  GpsBtn({this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()  {
        this.onClick!();
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: boxShadow,
            color: whiteColor
        ),
        child: Img(gps_icon,width: 25,height: 25,color: dominantColorShade400),
      ),
    );
  }
}
