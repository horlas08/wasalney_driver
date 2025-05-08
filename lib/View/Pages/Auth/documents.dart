import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/main-controller.dart';
import 'package:driver/Public/config.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/General/column-scroll.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/Pages/Auth/document-box.dart';
import 'package:driver/View/Components/Pages/Auth/document-items.dart';
import 'package:driver/View/Components/Popups/snackbar.dart';
import 'package:driver/View/Pages/Auth/terms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Logic/Controllers/user-controller.dart';
import '../../../Public/api-urls.dart';
import '../Main/message-admin.dart';
import '../Map/home-map.dart';

class Documents extends StatefulWidget {
  const Documents({Key? key}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body:  Container(
              width: size.width,
              height: size.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      height: 425,
                      width: size.width,
                      color: dominantColorShade100,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text(appTitle,style: AppController.fontStyle(fontTypes.header3, dominantColorShade400)),
                                // SizedBox(width: 10),
                                Img(appLogo,width: 150)
                              ],
                            ),
                          ),
                          Img(splashBackground_icon,color: complementaryColorShade700,width: size.width,height: 240)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 160,
                      child: Container(
                        width: 450,
                        height: size.height-200,
                        padding: EdgeInsets.only(top: 10,bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(offset: Offset(0,5),color: blackColor.withOpacity(0.1),blurRadius: 20)],
                          color: whiteColor,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ColumnScroll(
                                padding: 20,
                                children: [
                                  Row(
                                    children: [
                                      Img(arrow_right_icon,width: 25,height: 25,color: additionalColor2Shade700,
                                      onClick: (){
                                        Navigator.pop(context);
                                      },),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Text('${AppController.of(context)!.value('Upload your documents')}',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade700),),
                                    ],
                                  ),
                                  SizedBox(height: 25),

                                  DocumentItem()

                                ],
                              ),
                            ),
                            Btn(btnTypes.black,width: 300,text: '${'${AppController.of(context)!.value('registration')}'}',onClick: ()async{

                              if(UserController.user.value.document.value.onCarCard==null || UserController.user.value.document.value.backCarCard==null || UserController.user.value.document.value.onCertificate==null){
                                showSnackbar(snackTypes.error, '${AppController.of(context)!.value('upload document')}');
                              }
                              else if(UserController.user.value.document.value.onCarCard!=null && UserController.user.value.document.value.backCarCard!=null && UserController.user.value.document.value.onCertificate!=null ){
                                MainController.getTerms();
                                Navigator.push(Get.context!,MaterialPageRoute(builder: (context) => Terms()));


                              }
                            },)
                          ],
                        ),
                      )
                  )
                ],
              ),
            )

      ),
    );
  }
}
