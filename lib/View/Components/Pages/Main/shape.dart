import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Pages/Home/home-footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Shape extends StatelessWidget {
  List<Widget> header,topChildren,bottomChildren;
  double topHeight;
  double?headerHeight;
  Shape(this.topHeight,this.topChildren,this.bottomChildren,{this.header=  const[],this.headerHeight}) : super();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
      Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              padding: EdgeInsets.only(right: 20,left: 20),
              width: size.width,
              height:headerHeight?? 70,
              color: header.length>0?dominantColorShade700:Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                header,
              ),
            ),
          ),
          Positioned(
            top: header.length>0?50:0,
            child: Container(
              width: size.width,
              height: size.height,
              color: whiteColor,
              // child: ScrollConfiguration(
              //   behavior: ScrollConfiguration.of(context).copyWith(
              //     scrollbars: false,
              //     overscroll: false,
              //     // androidOverscrollIndicator: null
              //   ),
              //   child: SingleChildScrollView(
              //     physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: topHeight,
                    color: dominantColorShade700,
                    child: Stack(
                        children: [
                          Positioned(
                              top : 0,
                              child: Container(
                                width: size.width,
                                height: topHeight,
                                padding: EdgeInsets.only(top: 10,right: 20,left: 20),
                                child: Column(
                                  children: topChildren,
                                ),
                              )
                          ),
                          Positioned(
                            bottom: -1,
                            child: Container(
                              width: size.width,
                              height: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                  color: whiteColor
                              ),
                            ),
                          )
                        ]
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: size.height,
                    padding: EdgeInsets.only(right: 20,left: 20),
                    decoration: BoxDecoration(
                        color: whiteColor
                    ),
                    child:  ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        scrollbars: false,
                        overscroll: false,
                        // androidOverscrollIndicator: null
                      ),
                      child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Column(
                            children:
                            bottomChildren
                        ),
                      ),
                    ),
                  ),
                ],

              ),
              //   ),
              // ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: HomeFooter(true,full: true,)
          ),

        ],
      );
  }
}
