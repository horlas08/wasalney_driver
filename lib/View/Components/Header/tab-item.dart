import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/View/Components/General/column-scroll.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Logic/Controllers/app-controller.dart';
import '../../../Public/styles.dart';
import '../Pages/Selectors/day-month-selector.dart';

class Tabs extends StatefulWidget {
  List<Widget> pages;
  Tabs({Key? key,this.pages=const []}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin{



  @override
  void initState() {
    super.initState();
    AppController.tabController = new TabController(vsync: this, length: 2);
    AppController.tabController!.addListener(() {
      setState(() {
      });
      if(AppController.tabController!.index==1)
        UserController.monthlyReport();
    });
  }



  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                // height: 60,
                 width: size.width,
                decoration: BoxDecoration(
                  color: additionalColor2Shade200,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TabBar(
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.transparent,
                  unselectedLabelColor: Colors.transparent,
                  controller: AppController.tabController,
                  onTap: (index) {},
                  tabs: [
                    DayMonthSelector( '${AppController.of(context)!.value('day')}', AppController.tabController?.index==0),
                    DayMonthSelector( '${AppController.of(context)!.value('month')}', AppController.tabController?.index==1),
                  ],

                )
            ),
            SizedBox(
              height: size.height,
              child: TabBarView(
                controller: AppController.tabController,
                children:
                widget.pages,

              ),
            ),
          ],
        ),
      );
  }
}
