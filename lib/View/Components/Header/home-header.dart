import 'package:driver/Public/styles.dart';
import 'package:flutter/cupertino.dart';

class HomeHeader extends StatelessWidget {
  Widget right,center,left;
  HomeHeader(this.right,this.center,this.left) : super();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width>maxItemWidth?maxItemWidth:size.width-40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          right,
          center,
          left,
        ],
      ),
    );
  }
}
