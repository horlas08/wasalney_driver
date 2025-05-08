import 'package:driver/Public/enums.dart';
import 'package:driver/View/Pages/Auth/user-information-page.dart';
import 'package:driver/View/Pages/Main/financial-page.dart';
import 'package:driver/View/Pages/Main/orders.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Logic/Controllers/app-controller.dart';
import '../../../../Logic/Controllers/main-controller.dart';
import '../../../../Logic/Controllers/user-controller.dart';
import '../../../../Public/config.dart';
import '../../../../Public/images.dart';
import '../../../../Public/styles.dart';
import '../../../Pages/Main/message-page.dart';
import '../../../Pages/Main/report-page.dart';
import '../../General/img.dart';
import '../../General/my-divider.dart';
import '../../Popups/snackbar.dart';

class PopupMainPage extends StatefulWidget {
  Function?onChangeClose;
  double?heigth;
  PopupMainPage({this.onChangeClose,this.heigth});

  @override
  State<PopupMainPage> createState() => _PopupMainPageState();
}

class _PopupMainPageState extends State<PopupMainPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: size.width>maxItemWidth?maxItemWidth:size.width,
          height: widget.heigth,
          decoration: BoxDecoration(
              color:whiteColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40))
          ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(right: 20,left: 20,bottom: 130),
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    Text('${AppController.of(context)!.value('options')}',style: AppController.fontStyle(fontTypes.header5, additionalColor2Shade800)),
                    Spacer(),
                    Img(close_circle_icon,width: 25,height: 25,color: additionalColor2Shade800,onClick: (){
                      if(widget.onChangeClose!=null){
                        widget.onChangeClose!();
                      }
                      // setState(() {
                      //   i==1?i=2:i=1;
                      // });
                    },)
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box2(history_icon,'${AppController.of(context)!.value('history of travels')}',(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OrdersHistory()));
                    }),
                    box2(user_icon,'${AppController.of(context)!.value('user information')}',(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UserInformationPage()));
                    }),
                    box2(wallet_icon,'${AppController.of(context)!.value('finance')}',(){
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
          ),
        ),
      ),
    );
  }
  Widget CustomRow(String icon,String title,Function onClick,{Color? color}){
    return InkWell(
      onTap: (){
        onClick();
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
  Widget box2(String icon,String title,Function onclick){
    return InkWell(
      onTap: (){
        onclick();
      },
      child: Container(
        width: 110,
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
            Text(title,style: AppController.fontStyle(fontTypes.captionSM,additionalColor2Shade800))
          ],
        ),
      ),
    );
  }
}
