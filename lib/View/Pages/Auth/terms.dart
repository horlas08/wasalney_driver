import 'package:driver/Logic/Controllers/main-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/General/column-scroll.dart';
import 'package:driver/View/Components/Popups/snackbar.dart';
import 'package:flutter/material.dart';
import '../../../Logic/Controllers/app-controller.dart';
import '../../../Logic/Controllers/user-controller.dart';
import '../../Components/Buttons/check-box.dart';
import '../../Components/General/loading.dart';
import '../../Components/Header/icon-header.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(child:
        Scaffold(
          body: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [

                Loading(loadingName: ['get-terms'],getLoadedComponent: ()=>
                   Container(
                    width: maxItemWidth,
                    height: size.height,
                    padding: EdgeInsets.all(20),
                    child:  Column(
                      children: [
                        Expanded(
                          child: ColumnScroll(
                            // mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 120,),
                                Text('${MainController.terms}',style: AppController.fontStyle(fontTypes.captionMD, additionalColor2Shade700),overflow:TextOverflow.clip,maxLines: null, ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Checked(),
                                    Text('${AppController.of(context)!.value('I agree with the rules and regulations.')}',style: AppController.fontStyle(fontTypes.captionSM, additionalColor2Shade700),overflow:TextOverflow.clip,maxLines: null, ),

                                  ],
                                )
                              ],

                            ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,

                    child: Padding(
                      padding:  EdgeInsets.all(20),
                      child: Btn(btnTypes.black,width: 400,loadingTag: 'set-state',text: '${AppController.of(context)!.value('login to the application')}',onClick: () async {
                        if(MainController.isChecked.value==false){
                          showSnackbar(snackTypes.error, '${AppController.of(context)!.value('confirm')}');
                        }
                        else
                        await UserController.setStateDriver();
                      },),
                    )),
                Positioned(
                  top: 0,
                  child: Container(
                    width: size.width,
                    height: 119,
                    color: dominantColorShade700,
                    child: Stack(
                        children: [
                          Positioned(
                              top : 0,
                              child: Container(
                                width: size.width,
                                height: 100,
                                padding: EdgeInsets.only(top: 10,right: 20,left: 20),
                                child: Column(
                                  children:  [
                                    SizedBox(height: 15),
                                    Text('${AppController.of(context)!.value('rules and regulations')}',style: AppController.fontStyle(fontTypes.header4, whiteColor),),
                                  ],
                                ),
                              )
                          ),
                          Positioned(
                            bottom: -1,
                            child: Container(
                              width: size.width,
                              height: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                  color: whiteColor
                              ),
                            ),
                          )
                        ]
                    ),
                  ),),
              ],
            ),

          ),
        )
    );
  }
}
