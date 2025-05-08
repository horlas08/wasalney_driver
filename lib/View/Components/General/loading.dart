import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../Public/styles.dart';

class Loading extends StatelessWidget {
  Function? getLoadedComponent;
  List<String>?loadingName;
  double?height,width,size;
  double?strokeWidth;
  Color?color;
  Loading({this.height,this.color,this.width,this.size,this.getLoadedComponent,this.strokeWidth,this.loadingName});
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return
      Obx(() {
        return
          AppController.hasLoading(this.loadingName!) ?
          Container(
              width: this.width ?? size.width,
              height: this.height??size.height,
              color: this.color??whiteColor.withOpacity(0.9),
              child:  Center(
                child: SpinKitThreeBounce(
                  color: dominantColor,
                  size: this.size??30.0,
                ),
              )
          ) : this.getLoadedComponent != null ? getLoadedComponent!() : Container();
      }
      );
  }
}
