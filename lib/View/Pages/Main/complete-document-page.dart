import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Models/user.dart';
import 'package:driver/Public/api-urls.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/column-scroll.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/Pages/Auth/document-box.dart';
import 'package:driver/View/Components/Pages/Auth/document-items.dart';
import 'package:driver/View/Components/Pages/Home/home-footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Logic/Controllers/user-controller.dart';

class ComleteDocumentPage extends StatefulWidget {
  const ComleteDocumentPage({Key? key}) : super(key: key);

  @override
  State<ComleteDocumentPage> createState() => _ComleteDocumentPageState();
}

class _ComleteDocumentPageState extends State<ComleteDocumentPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 20,),
          child: Column(
            children: [
              Expanded(
                child: ColumnScroll(
                  children: [
                    Container(
                      width: maxItemWidth,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Img(arrow_right_icon,width: 25,height: 25,color: additionalColor1Shade800,onClick: (){
                                    Navigator.pop(context);
                                  }),
                                  SizedBox(height: 10),
                                  Text('${AppController.of(context)!.value('Completion of documents')}',style: AppController.fontStyle(fontTypes.header4, blackColor),),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          DocumentItem()
                        ],
                      ),
                    )
                  ],
                ),
              ),
              HomeFooter(true)
            ],
          ),
        ),
      ),
    );
  }
}
