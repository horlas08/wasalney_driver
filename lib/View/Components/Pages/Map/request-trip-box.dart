import 'package:driver/Logic/Controllers/order-controller.dart';
import 'package:driver/Models/order.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:driver/View/Components/Buttons/btn.dart';
import 'package:driver/View/Components/General/column-scroll.dart';
import 'package:driver/View/Components/Pages/Map/adrress-icon-item.dart';
import 'package:driver/View/Components/Pages/Map/show-price-box.dart';
import 'package:driver/View/Components/Pages/Map/traveling-bottom-sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Logic/Controllers/app-controller.dart';
import '../../../../Public/images.dart';
import '../../General/img.dart';
import '../../General/my-divider.dart';
import '../../Popups/bottom-modal.dart';
import 'order-truck-detail.dart';

class TakingTripBox extends StatelessWidget {
  Order order;

  TakingTripBox(this.order);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size.width - 40,
          margin: EdgeInsets.only(right: 20, left: 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: maxItemWidth,
                // height: 350,
                margin: EdgeInsets.only(top: 20),
                padding:
                    EdgeInsets.only(top: 15, bottom: 20, right: 15, left: 15),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: boxShadow),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    order.economic == true
                        ? Container(
                            width: 80,
                            height: 25,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Text(
                                    '${AppController.of(context)!.value('economic')}',
                                    style: AppController.fontStyle(
                                        fontTypes.captionLG, whiteColor))),
                          )
                        : Container(),
                    Container(
                        margin: EdgeInsets.only(top: 25),
                        child: AddressIconItem(this.order)),
                    if (order.comeback == true || order.stopTime != null|| order.stopTime2 != null)
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (order.comeback == true)
                              bottun(
                                  programming_arrows_icon,
                                  '${AppController.of(context)!.value('back to the origin')}',
                                  () {}),
                            if (order.stopTime != null)
                              bottun(
                                  timer_icon,
                                  ' ${order.stopTime} ${AppController.of(context)!.value('stop')} ',
                                  () {}),
                            if (order.stopTime2 != null)
                              bottun(
                                  timer_icon,
                                  ' ${order.stopTime2} ${AppController.of(context)!.value('driverless stop')} ',
                                  () {}),
                          ],
                        ),
                      ),
                    if (order.reserve == true)
                      InkWell(
                        onTap: () {
                          showBottomModal(
                              context,
                              550,
                              Container(
                                  padding: EdgeInsets.only(
                                      right: 35, left: 35, bottom: 30),
                                  child: SingleChildScrollView(
                                      child: Column(children: [
                                    SizedBox(height: 10),
                                    Img(
                                      arrow_down_icon,
                                      width: 40,
                                      height: 25,
                                      color: additionalColor2Shade400,
                                      onClick: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          ' ${AppController.of(context)!.value('cost')}  ${AppController.priceFormat(order.price)}  ${AppController.of(context)!.value('rial')}',
                                          style: AppController.fontStyle(
                                              fontTypes.header5, blackColor),
                                        ),
                                      ],
                                    ),
                                    MyDivider(
                                        color: additionalColor2Shade200,
                                        margin: 20),
                                    AddressIconItem(order),
                                    MyDivider(
                                        color: additionalColor2Shade200,
                                        margin: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('${AppController.of(context)!.value('date and time reservation')}',
                                            style: AppController.fontStyle(
                                                fontTypes.captionLG,
                                                blackColor)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            ' ${AppController.of(context)!.value('date')} ${order.dateReserve!.preview}',
                                            style: AppController.fontStyle(
                                                fontTypes.captionLG,
                                                errorLightColor5)),
                                        Text(' ${AppController.of(context)!.value('clock')} ${order.timeReserve} ',
                                            style: AppController.fontStyle(
                                                fontTypes.captionLG,
                                                errorLightColor5)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Btn(
                                      btnTypes.primary,
                                      loadingTag: 'accept-order',
                                      text: '${AppController.of(context)!.value('accept the trip')}',
                                      onClick: () {
                                        OrderController.acceptOrder(order.id!);
                                        Navigator.pop(context);
                                      },
                                    )
                                  ]))));
                        },
                        child: Container(
                          width: 150,
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: errorLightColor5,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text('${AppController.of(context)!.value('order detail')}',
                                  style: AppController.fontStyle(
                                      fontTypes.captionLG, errorLightColor5))),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),

                    order.deliveryId > 3
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Btn(
                              btnTypes.withBorder,
                              width: 120,
                              height: 35,
                              text:
                                  '${AppController.of(context)!.value('order details')}',
                              onClick: () {
                                showBottomModal(
                                    context,
                                    670,
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: 35, left: 35, bottom: 30),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10),
                                            Img(
                                              arrow_down_icon,
                                              width: 40,
                                              height: 25,
                                              color: additionalColor2Shade400,
                                              onClick: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ' ${AppController.of(context)!.value('cost')}${AppController.priceFormat(order.price)} ${AppController.of(context)!.value('rial')}',
                                                  style:
                                                      AppController.fontStyle(
                                                          fontTypes.header5,
                                                          blackColor),
                                                ),
                                                // if(order.payType!.id!=1)
                                                // Spacer(),
                                              ],
                                            ),
                                            MyDivider(
                                                color: additionalColor2Shade200,
                                                margin: 20),
                                            AddressIconItem(order),
                                            MyDivider(
                                                color: additionalColor2Shade200,
                                                margin: 20),
                                            if (order.truckDetail != null)
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 30),
                                                child: OrderDetailTruck(order),
                                              ),
                                            if (order.deliveryId != 3 &&
                                                order.deliveryId != 1)
                                              Column(
                                                children: [
                                                  for (var info in order.info)
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width:
                                                              maxItemWidth - 20,
                                                          child: Wrap(
                                                            children: [
                                                              Text(
                                                                '${info.type} :',
                                                                style: AppController
                                                                    .fontStyle(
                                                                        fontTypes
                                                                            .bodySM,
                                                                        accentColor),
                                                              ),
                                                              info.name != null
                                                                  ? Text(
                                                                      ' في الاسم ${info.name} ،  ',
                                                                      style: AppController.fontStyle(
                                                                          fontTypes
                                                                              .bodySM,
                                                                          additionalColor2Shade800),
                                                                      maxLines:
                                                                          null,
                                                                    )
                                                                  : Container(),
                                                              info.unit != null
                                                                  ? Text(
                                                                      ' الوحده ${info.unit} ،  ',
                                                                      style: AppController.fontStyle(
                                                                          fontTypes
                                                                              .bodySM,
                                                                          additionalColor2Shade800),
                                                                      maxLines:
                                                                          null,
                                                                    )
                                                                  : Container(),
                                                              info.houseNumber !=
                                                                      null
                                                                  ? Text(
                                                                      ' رقم الدار${info.houseNumber} ، ',
                                                                      style: AppController.fontStyle(
                                                                          fontTypes
                                                                              .bodySM,
                                                                          additionalColor2Shade800),
                                                                      maxLines:
                                                                          null,
                                                                    )
                                                                  : Container(),
                                                              info.phone != null
                                                                  ? Text(
                                                                      ' رقم الهاتف  ${info.phone} ، ',
                                                                      style: AppController.fontStyle(
                                                                          fontTypes
                                                                              .bodySM,
                                                                          additionalColor2Shade800),
                                                                      maxLines:
                                                                          null,
                                                                    )
                                                                  : Container(),
                                                              info.description !=
                                                                      null
                                                                  ? Text(
                                                                      ' شرح إضافي:  ${info.description} .',
                                                                      style: AppController.fontStyle(
                                                                          fontTypes
                                                                              .bodySM,
                                                                          additionalColor2Shade800),
                                                                      maxLines:
                                                                          2,
                                                                    )
                                                                  : Container(),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  MyDivider(
                                                      color:
                                                          additionalColor2Shade200,
                                                      margin: 20),
                                                ],
                                              ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            // Spacer(),
                                            Btn(
                                              btnTypes.primary,
                                              width: maxItemWidth,
                                              loadingTag: 'accept-order',
                                              text:
                                                  '${AppController.of(context)!.value('accept the trip')}',
                                              onClick: () {
                                                OrderController.acceptOrder(
                                                    order.id!);
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          )
                        : order.deliveryId == 2
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Btn(
                                  btnTypes.withBorder,
                                  width: 120,
                                  height: 35,
                                  text:
                                      '${AppController.of(context)!.value('order details')}',
                                  onClick: () {
                                    showBottomModal(
                                        context,
                                        670,
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: 35, left: 35, bottom: 30),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10),
                                                Img(
                                                  arrow_down_icon,
                                                  width: 40,
                                                  height: 25,
                                                  color:
                                                      additionalColor2Shade400,
                                                  onClick: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      ' ${AppController.of(context)!.value('cost')}${AppController.priceFormat(order.price)} ${AppController.of(context)!.value('rial')}',
                                                      style: AppController
                                                          .fontStyle(
                                                              fontTypes.header5,
                                                              blackColor),
                                                    ),
                                                    // if(order.payType!.id!=1)
                                                    // Spacer(),
                                                  ],
                                                ),
                                                MyDivider(
                                                    color:
                                                        additionalColor2Shade200,
                                                    margin: 20),
                                                AddressIconItem(order),
                                                MyDivider(
                                                    color:
                                                        additionalColor2Shade200,
                                                    margin: 20),
                                                if (order.motorDetail != null)
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30),
                                                    child: Container(
                                                        child: Column(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            if (order.motorDetail
                                                                        ?.typeProduct !=
                                                                    null &&
                                                                order.motorDetail
                                                                        ?.priceProduct !=
                                                                    null)
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                      '${AppController.of(context)!.value('the type of shipment and the value of the shipment')}',
                                                                      style: AppController.fontStyle(
                                                                          fontTypes
                                                                              .bodySM,
                                                                          additionalColor2Shade800)),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                          '${order.motorDetail?.typeProduct}  ${order.motorDetail?.priceProduct}  ',
                                                                          style: AppController.fontStyle(
                                                                              fontTypes.bodySM,
                                                                              accentColor)),
                                                                    ],
                                                                  ),
                                                                  // MyDivider(margin: 25,color: complementaryColorShade200,),
                                                                ],
                                                              ),
                                                          ],
                                                        )
                                                      ],
                                                    )),
                                                  ),
                                                Spacer(),
                                                Btn(
                                                  btnTypes.primary,
                                                  width: maxItemWidth,
                                                  loadingTag: 'accept-order',
                                                  text:
                                                      '${AppController.of(context)!.value('accept the trip')}',
                                                  onClick: () {
                                                    OrderController.acceptOrder(
                                                        order.id!);
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                              )
                            : order.deliveryId == 3
                                ? order.cooler == true ||
                                        order.helper == true
                        // || order.gender != null
                                    ? Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Btn(
                                          btnTypes.withBorder,
                                          width: 120,
                                          height: 35,
                                          text: '${AppController.of(context)!.value('order details')}',
                                          onClick: () {
                                            showBottomModal(
                                                context,
                                                600,
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 35,
                                                      left: 35,
                                                      bottom: 30),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 10),
                                                        Img(
                                                          arrow_down_icon,
                                                          width: 40,
                                                          height: 25,
                                                          color:
                                                              additionalColor2Shade400,
                                                          onClick: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        SizedBox(height: 20),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              ' ${AppController.of(context)!.value('cost')}${AppController.priceFormat(order.price)} ${AppController.of(context)!.value('rial')}',
                                                              style: AppController
                                                                  .fontStyle(
                                                                      fontTypes
                                                                          .header5,
                                                                      blackColor),
                                                            ),
                                                            // if(order.payType!.id!=1)
                                                            // Spacer(),
                                                          ],
                                                        ),
                                                        MyDivider(
                                                            color:
                                                                additionalColor2Shade200,
                                                            margin: 20),
                                                        AddressIconItem(order),
                                                        MyDivider(
                                                            color:
                                                                additionalColor2Shade200,
                                                            margin: 20),

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            if (order.cooler !=
                                                                false)
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 30,
                                                                        bottom:
                                                                            10),
                                                                child: Container(
                                                                    child: Text(
                                                                        '${AppController.of(context)!.value('cooler')} : ${AppController.of(context)!.value('has')} ',
                                                                        style: AppController.fontStyle(
                                                                            fontTypes.bodySM,
                                                                            additionalColor2Shade800))),
                                                              ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            if (order.helper !=
                                                                false)
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 30,
                                                                        bottom:
                                                                            10),
                                                                child: Container(
                                                                    child: Text(
                                                                        '${AppController.of(context)!.value('assistant')} : ${AppController.of(context)!.value('has')} ',
                                                                        style: AppController.fontStyle(
                                                                            fontTypes.bodySM,
                                                                            additionalColor2Shade800))),
                                                              ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 50,
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Btn(
                                                                btnTypes
                                                                    .primary,
                                                                width:
                                                                    size.width /
                                                                        1.4,
                                                                loadingTag:
                                                                    'accept-order',
                                                                text:
                                                                    '${AppController.of(context)!.value('accept the trip')}',
                                                                onClick: () {
                                                                  OrderController
                                                                      .acceptOrder(
                                                                          order
                                                                              .id!);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                          },
                                        ),
                                      )
                                    : Container()
                                : Container(),
                    // Spacer(),
                    Btn(
                      btnTypes.primary,
                      width: maxItemWidth,
                      loadingTag: 'accept-order',
                      text:
                          '${AppController.of(context)!.value('accept the trip')}',
                      onClick: () {
                        OrderController.acceptOrder(order.id!);
                      },
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 0,
                  child: ShowPriceBox(
                      '${AppController.priceFormat(order.price)}')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget bottun(String icon, String title, Function? onClick) {
  return InkWell(
    onTap: () {
      onClick!();
    },
    child: Container(
      width: 180,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: complementaryColorShade100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Img(
            icon,
            width: 25,
            height: 25,
            color: Color(0xff353535),
          ),
          SizedBox(width: 5),
          Text(
            title,
            style: AppController.fontStyle(fontTypes.bodySM, Color(0xff353535)),
          )
        ],
      ),
    ),
  );
}
