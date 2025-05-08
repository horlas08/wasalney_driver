import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/main-controller.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/no-color-btn.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/loading.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:driver/View/Components/Header/title-header.dart';
import 'package:driver/View/Components/Pages/Main/score-item.dart';
import 'package:driver/View/Components/Pages/Main/shape.dart';
import 'package:driver/View/Components/Popups/bottom-modal.dart';
import 'package:driver/View/Pages/Main/complete-document-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'edit-profile-page.dart';

class EditInformationPage extends StatelessWidget {
  const EditInformationPage({Key? key}) : super(key: key);
  Widget row(String title,Function onclick){
    return InkWell(
      onTap: (){
        onclick();
      },
      child: Container(
        child: Row(
          children: [
            Text(title,style: AppController.fontStyle(fontTypes.header5, blackColor),),
            Spacer(),
            Img(arrow_left2_icon,height: 25,width: 25,color: blackColor,)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Shape(235,
              [
                SizedBox(height: 40),
                ScoreItem()
                ],
              [
                Container(
                  height: size.height-420,
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      row('${AppController.of(context)!.value('edit personal information')}',()async{
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage(changePage: false,)));

                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage()));

                      }),
                      MyDivider(width: size.width,color: complementaryColorShade300,margin: 25),
                      row('${AppController.of(context)!.value('edit vehicle specifications')}',() async {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage(changePage: false,)));
                      }),
                      MyDivider(width: size.width,color: complementaryColorShade300,margin: 25),
                      row('${AppController.of(context)!.value('completion of documents')}',(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ComleteDocumentPage()));
                      }),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          showBottomModal(context, 325, Container(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('${AppController.of(context)!.value('logout')}',style: AppController.fontStyle(fontTypes.header6, additionalColor2Shade800),),
                                    Spacer(),
                                    Container(
                                        width: 35,
                                        height: 35,
                                        child: Img(cancle_icon,width: 13,height: 13,color: blackColor,onClick: ()=>Navigator.pop(context),))
                                  ],
                                ),
                                SizedBox(height: 20),
                                Img(logout2_icon,width: 100,height: 100,),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    NoColorBtn('${AppController.of(context)!.value('dissuasion')}',width: size.width>maxItemWidth?maxItemWidth/2-40:size.width/2-40,onClick: (){
                                      Navigator.pop(context);
                                    },),
                                    SizedBox(width: 20),
                                    InkWell(
                                      onTap: (){
                                        UserController.logout();
                                      },
                                      child: Container(
                                        width: size.width>maxItemWidth?maxItemWidth/2-40:size.width/2-40,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: errorExtraLightColor5,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(width: 1,color: errorColor)
                                        ),
                                        child: Center(
                                          child: Text('${AppController.of(context)!.value('get out')}',style: AppController.fontStyle(fontTypes.buttonSM, errorColor),),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ));
                        },
                        child: Container(
                          width: size.width>maxItemWidth?maxItemWidth:size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1,color: errorLightColor5)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Img(logout_icon,width: 25,height: 25,color: errorLightColor5,),
                              SizedBox(width: 10),
                              Text('${AppController.of(context)!.value('logout')}',style: AppController.fontStyle(fontTypes.buttonSM, errorLightColor5),),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ],
              header: [
                TitleHeader()
              ],
            ),
            Loading(loadingName: ['info-documents'],)
          ],
        ),
      ),
    );
  }
}
