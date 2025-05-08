import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/images.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/General/img.dart';
import 'package:driver/View/Components/Pages/Selectors/select-box.dart';
import 'package:flutter/cupertino.dart';

class EditSelect extends StatelessWidget {
  String title;
  String? hint;
  List<dynamic> options=[];
  Function? onSelect;
  EditSelect(this.title,this.options,{this.onSelect,this.hint}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: maxItemWidth,
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(title,style: AppController.fontStyle(fontTypes.captionLG, additionalColor1Shade800),)
            ],
          ),
          Spacer(),
          Stack(
            children: [
              SelectBox(this.options,text: this.hint??"${AppController.of(context)!.value('choice')}",onSelect: (val){
                if(this.onSelect!=null)
                  this.onSelect!(val);
              },)
            ],
          )
        ],
      ),
    );
  }
}
