import 'package:driver/Logic/Controllers/order-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:flutter/material.dart';
import '../../../Logic/Controllers/app-controller.dart';
import '../../../Public/styles.dart';

class TabOrders extends StatefulWidget {
  List<Widget> pages;
  TabOrders({Key? key,this.pages=const []}) : super(key: key);
  @override
  State<TabOrders> createState() => _TabOrdersState();
}

class _TabOrdersState extends State<TabOrders> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    AppController.tabControllerOrders = new TabController(vsync: this, length: 3);
    AppController.tabControllerOrders!.addListener(() {
      setState(() {
      });
      print('index is>>${AppController.tabControllerOrders!.index}');
    });
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 60,
                 width: maxItemWidth,
                decoration: BoxDecoration(
                  color: dominantColorShade700,
                  // borderRadius: BorderRadius.circular(10)
                ),
                child: TabBar(
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  indicatorColor: accentColor2,
                  labelColor:accentColor2,
                  unselectedLabelColor: Colors.transparent,
                  controller: AppController.tabControllerOrders,
                  onTap: (index) {
                    print('index>>${index}');
                    if(index==0){
                      OrderController.myOrder();
                    } else if(index==1){
                      OrderController.futureOrder();
                    }
                    else if(index==2){
                      OrderController.lastOrder();
                    }
                  },
                  tabs: [
                    Text('${AppController.of(context)!.value('Current Trips')}',style: AppController.fontStyle(fontTypes.bodySM,AppController.tabControllerOrders?.index==0?accentColor2:whiteColor),),
                    Text('${AppController.of(context)!.value('Upcoming Trips')}',style: AppController.fontStyle(fontTypes.bodySM,AppController.tabControllerOrders?.index==1?accentColor2:whiteColor),),
                    Text('${AppController.of(context)!.value('history of travels')}',style: AppController.fontStyle(fontTypes.bodySM,AppController.tabControllerOrders?.index==3?accentColor2:whiteColor),),
                  ],

                )
            ),
            Expanded(
              child: TabBarView(
                controller: AppController.tabControllerOrders,
                children:
                widget.pages,

              ),
            ),
          ],
        ),
      );
  }
}
