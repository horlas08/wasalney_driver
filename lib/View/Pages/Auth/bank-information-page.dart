import 'package:dotted_border/dotted_border.dart';
import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Controllers/main-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/General/column-scroll.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/Inputs/edit-input.dart';
import 'package:driver/View/Components/Pages/Home/home-footer.dart';
import 'package:driver/View/Components/Pages/Main/list-selector.dart';
import 'package:driver/View/Components/Pages/Selectors/edit-select.dart';
import 'package:driver/View/Components/Pages/Selectors/select-box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Logic/Controllers/user-controller.dart';
import '../../Components/Inputs/bank-input.dart';



class BankInformationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(top: 20,),
          child: Column(
            children: [
              Expanded(
                child: ColumnScroll(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          child: Img(cancle_icon,width: 13,height: 13,color: blackColor,onClick: (){
                            Navigator.pop(context);
                          },),
                        ),
                        Spacer(),
                        Text('${AppController.of(context)!.value('bank information')}',style: AppController.fontStyle(fontTypes.header6, blackColor),),
                        Spacer(),
                        Container(width: 13,),
                      ],
                    ),
                    SizedBox(height: 50),
                    UserController.user.value.infoBank.length!=0?
                    ListSelector('${AppController.of(context)!.value('shaba card number')}', '${AppController.of(context)!.value('bank card number')}',
                        [
                          Container(
                            width: maxItemWidth,
                            child: Text('${AppController.of(context)!.value('Dear driver, please note that the bank account information must be your first and last name and your national code')}',
                            style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade700),maxLines: 2,overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(height: 30),
                          EditInput('${AppController.of(context)!.value('shaba card number')} :',leftPadding: 60,align: TextAlign.left,isnum: true,iconSpace: 16,
                            initValue:  UserController.user.value.infoBank[0].shaba != null?'${UserController.user.value.infoBank[0].shaba }':'',
                            onChange: (text){
                              UserController.infoBank.shaba=text;
                            }, ),
                          EditInput('${AppController.of(context)!.value('name of the account holder')} :',
                            initValue:  UserController.user.value.infoBank[0].name != null?'${UserController.user.value.infoBank[0].name }':'',
                            onChange: (text){
                              UserController.infoBank.name=text;
                            }, ),
                          // EditSelect('${AppController.of(context)!.value('name of the bank')} :',  MainController.document.banks!,
                          //   hint:UserController.user.value.infoBank[0].bank?.title != null?'${UserController.user.value.infoBank[0].bank!.title }':'${AppController.of(context)!.value('choice')}' ,
                          //   onSelect: (val){
                          //     UserController.infoBank.bank=val;
                          //   },),
                          ],
                        [
                          Container(
                            width: maxItemWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${AppController.of(context)!.value('Dear driver, please note that the bank account information must be your first and last name and your national code')}',
                                  style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade700),maxLines: 2,overflow: TextOverflow.clip,
                                ),
                                SizedBox(height: 30),
                                Text('${AppController.of(context)!.value('card number')} :',style: AppController.fontStyle(fontTypes.captionLG, blackColor)),
                                SizedBox(height: 5),
                                UserController.user.value.infoBank[0].number.length!=0?

                                Container(
                                  width: maxItemWidth,
                                  height: 130,
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  decoration: BoxDecoration(
                                    color: dominantColorShade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BankInput( initValue:UserController.user.value.infoBank[0].number[0],onChange: (val){
                                        UserController.infoBank.number1=val;

                                      },),
                                      BankInput( initValue:UserController.user.value.infoBank[0].number[1],onChange: (val){
                                        UserController.infoBank.number2=val;

                                      },),
                                      BankInput( initValue:UserController.user.value.infoBank[0].number[2],onChange: (val){
                                        UserController.infoBank.number3=val;

                                      },),
                                      BankInput( initValue:UserController.user.value.infoBank[0].number[3],onChange: (val){
                                        UserController.infoBank.number4=val;

                                      },),
                                    ],
                                  ),
                                ):
                                Container(
                                  width: maxItemWidth,
                                  height: 130,
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  decoration: BoxDecoration(
                                    color: dominantColorShade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BankInput(initValue: '',
                                            onChange: (val){
                                            UserController.infoBank.number1=val;
                                          }, ),

                                          BankInput(initValue: '', onChange: (val){
                                            UserController.infoBank.number2=val;

                                          },),
                                          BankInput(initValue: '', onChange: (val){
                                            UserController.infoBank.number3=val;

                                          },),
                                          BankInput(initValue: '', onChange: (val){
                                            UserController.infoBank.number4=val;

                                          },),
                                        ],
                                      ),
                                    )

                              ],
                            ),
                          ),
                          ]
                    ):
                    ListSelector('${AppController.of(context)!.value('shaba card number')}', '${AppController.of(context)!.value('bank card number')}',
                        [
                          Container(
                            width: maxItemWidth,
                            child: Text('${AppController.of(context)!.value('Dear driver, please note that the bank account information must be your first and last name and your national code')}',
                            style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade700),maxLines: 2,overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(height: 30),
                          EditInput('${AppController.of(context)!.value('shaba card number')} :',leftPadding: 60,align: TextAlign.left,isnum: true,iconSpace: 16,
                            initValue:  '',
                            onChange: (text){
                              UserController.infoBank.shaba=text;
                            }, ),
                          EditInput('${AppController.of(context)!.value('name of the account holder')} :',
                            initValue: '',
                            onChange: (text){
                              UserController.infoBank.name=text;
                            }, ),
                          // EditSelect('${AppController.of(context)!.value('name of the bank')} :',  MainController.document.banks!,
                          //   hint:'' ,
                          //   onSelect: (val){
                          //     UserController.infoBank.bank=val;
                          //   },),
                          ],
                        [
                          Container(
                            width: maxItemWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${AppController.of(context)!.value('Dear driver, please note that the bank account information must be your first and last name and your national code')}',
                                  style: AppController.fontStyle(fontTypes.bodySM, additionalColor2Shade700),maxLines: 2,overflow: TextOverflow.clip,
                                ),
                                SizedBox(height: 30),
                                Text('${AppController.of(context)!.value('card number')} :',style: AppController.fontStyle(fontTypes.captionLG, blackColor)),
                                SizedBox(height: 5),
                                Container(
                                  width: maxItemWidth,
                                  height: 130,
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  decoration: BoxDecoration(
                                    color: dominantColorShade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BankInput(initValue: '',
                                        onChange: (val){
                                          UserController.infoBank.number1=val;
                                        }, ),
                                      BankInput(initValue: '', onChange: (val){
                                        UserController.infoBank.number2=val;

                                      },),
                                      BankInput(initValue: '', onChange: (val){
                                        UserController.infoBank.number3=val;

                                      },),
                                      BankInput(initValue: '', onChange: (val){
                                        UserController.infoBank.number4=val;

                                      },),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          ]
                    ),
                    SizedBox(height: 20),

                  ],
                ),
              ),
             Btn(btnTypes.primary,text: '${AppController.of(context)!.value('save changes')}',loadingTag: 'edit-bank-info',margin: 20,onClick: (){
               UserController.editBankInfo();
             },),
              SizedBox(height: 35,),
              HomeFooter(true,full: true,)
            ],
          ),
        ),
      ),
    );
  }
}
