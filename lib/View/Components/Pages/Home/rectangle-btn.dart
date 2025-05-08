import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/order-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/Buttons/error-btn.dart';
import 'package:driver/View/Components/Buttons/no-color-btn.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/General/my-divider.dart';
import 'package:driver/View/Components/Popups/alert-dialog.dart';
import 'package:driver/View/Components/Popups/bottom-modal.dart';
import 'package:driver/View/Pages/Main/financial-page.dart';
import 'package:driver/View/Pages/Auth/user-information-page.dart';
import 'package:driver/View/Pages/Main/orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Logic/Controllers/main-controller.dart';
import '../../../../Logic/Controllers/user-controller.dart';
import '../../../../Public/config.dart';
import '../../../Pages/Main/message-page.dart';
import '../../../Pages/Main/report-page.dart';
import '../../Popups/snackbar.dart';

class RectangleBtn extends StatelessWidget {
  bool close;
  int? id;
  RectangleBtn({this.close=false,this.id});

  @override
  Widget build(BuildContext context) {
    Widget CustomRow(String icon,String title,Function onChange,{Color? color}){
      return InkWell(
        onTap: (){
          onChange();
        },
        child: Row(
          children: [
            Img(icon,width: 25,height: 25,color:color?? additionalColor2Shade800),
            SizedBox(width: 20),
            Text(title,style: AppController.fontStyle(fontTypes.bodySM, color??blackColor))
          ],
        ),
      );
    }
    Widget box(String icon,String title,Function onclick){
      return InkWell(
        onTap: (){
          onclick();
        },
        child: Container(
          width: 130,
          height: 65,
          padding: EdgeInsets.only(top: 6,bottom: 6),
          decoration: BoxDecoration(
            color: complementaryColorShade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Img(icon,width: 25,height: 25,color: additionalColor2Shade800),
              SizedBox(height: 3),
              Text(title,style: AppController.fontStyle(fontTypes.overlineSM,additionalColor2Shade800))
            ],
          ),
        ),
      );
    }
    return InkWell(
      onTap: (){
        close?showAlertDialog(context,title:'${AppController.of(context)!.value('cancel the trip')}',
          child: Container(
          width: 360,
          height: 140,
          child: Column(
            children: [
              Text('${AppController.of(context)!.value('Are you sure to cancel your trip?')}',style: AppController.fontStyle(fontTypes.bodyLG, blackColor),),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NoColorBtn('${AppController.of(context)!.value('dissuasion')}',onClick: (){
                    Navigator.pop(context);
                  },),
                  SizedBox(width: 20),
                  ErrorBtn('${AppController.of(context)!.value('cancel the trip')}',loadingTag: 'cancel',onClick: ()async{
                   await OrderController.cancelOrder(this.id.toString());
                  },),
                ],
              )
            ],
          ),
        )):
        showBottomModal(context, 470, Container(
          padding: EdgeInsets.only(right: 20,left: 20),
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  Text('${AppController.of(context)!.value('options')}',style: AppController.fontStyle(fontTypes.header5, additionalColor2Shade800)),
                  Spacer(),
                  Img(close_circle_icon,width: 25,height: 25,color: additionalColor2Shade800,onClick: (){
                    Navigator.pop(context);
                  },)
                ],
              ),
              SizedBox(height: 25),
              Wrap(
                spacing: 18,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  box(history_icon,'${AppController.of(context)!.value('history of travels')}',(){
                    // OrderController.progressOrder();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OrdersHistory()));
                  }),
                  box(user_icon,'${AppController.of(context)!.value('user information')}',(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UserInformationPage()));
                  }),
                  box(wallet_icon,'${AppController.of(context)!.value('finance')}',(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FinancialPage()));
                  }),
                ],
              ),
              SizedBox(height: 40),
              CustomRow(notif_icon, '${AppController.of(context)!.value('messages')}',(){
                UserController.getMessage();
                Navigator.push(context,MaterialPageRoute(builder: (context) => MessagePage()));

              }),
              SizedBox(height: 40),
              CustomRow(support24_icon, '${AppController.of(context)!.value('support')}',(){

                  launch("tel:${ MainController.support}");

              }),
              MyDivider(color: additionalColor2Shade200,margin: 20),
              CustomRow(info_circle_icon, '${AppController.of(context)!.value('about us')}',()async{
              final Uri url = Uri.parse('${baseUrl}');
              if (!await launchUrl(url)) {
              showSnackbar(snackTypes.error, '${AppController.of(context)!.value('It is not possible to open the site')}');
              }
              }),
              MyDivider(color: additionalColor2Shade200,margin: 20),
              CustomRow(delete_icon, '${AppController.of(context)!.value('request delete account')}',()async{
                final Uri url = Uri.parse('${baseUrl}/delete-account');
                if (!await launchUrl(url)) {
                  showSnackbar(snackTypes.error, '${AppController.of(context)!.value('It is not possible to open the site')}');
                }
              },color: errorColor)
            ],
          ),
        ));
      },
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: boxShadow,
          color: whiteColor
        ),
        child: Img(close?cancle_icon:menu_icon,width: close?20:30,height: close?20:30,color: dominantColorShade400,),
      ),
    );
  }
}
