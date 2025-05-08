import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Pages/Main/add-money-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Logic/Controllers/user-controller.dart';

class AddBtn extends StatelessWidget {
  const AddBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        UserController.user.value.codeWallet=null;
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMoneyPage()));
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: complementaryColor
        ),
        child: Img(add_icon,width: 25,height: 25,color: whiteColor,),
      ),
    );
  }
}
