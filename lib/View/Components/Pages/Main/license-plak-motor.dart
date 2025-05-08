// import 'package:dotted_border/dotted_border.dart';
// import 'package:driver/Logic/Controllers/app-controller.dart';
// import 'package:driver/Public/enums.dart';
// import 'package:driver/Public/images.dart';
// import 'package:driver/Public/styles.dart';
// import 'package:driver/View/Components/General/img.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../../../../Logic/Controllers/user-controller.dart';
// import '../../Inputs/plak-input.dart';
//
// class LicensePlakMotor extends StatefulWidget {
//
//   const LicensePlakMotor({Key? key}) : super(key: key);
//
//   @override
//   State<LicensePlakMotor> createState() => _LicensePlakMotorState();
// }
//
// class _LicensePlakMotorState extends State<LicensePlakMotor> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 120,
//       width: maxItemWidth,
//       margin: EdgeInsets.only(bottom: 15),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Text('${AppController.of(context)!.value('plaque')} :',style: AppController.fontStyle(fontTypes.captionLG, additionalColor1Shade800),)
//             ],
//           ),
//           SizedBox(height: 5),
//           Container(
//             height: 85,
//             width: maxItemWidth,
//             decoration: BoxDecoration(
//                 color: whiteColor,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [BoxShadow(offset: Offset(0,2),blurRadius: 4,spreadRadius: 0,color: blackColor.withOpacity(0.1))]
//             ),
//             child: Container(
//               height: 85,
//               width: maxItemWidth,
//               decoration: BoxDecoration(
//                 color: dominantColorShade100.withOpacity(0.3),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child:
//                   UserController.user.value.plak!=null?
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//
//
//                   PlakInput(5,(text){
//                     UserController.carDetails.plakMotor2=text;
//                   },initValue: UserController.user.value.plak[1],width: 40,
//                   ),
//                   PlakInput(3,(text){
//
//                     UserController.carDetails.plakMotor1=text;
//                   },initValue: UserController.user.value.plak[0]),
//                 ],
//               ):Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//
//
//
//                   PlakInput(5,(text){
//
//                     UserController.carDetails.plakMotor2=text;
//                     print(text);
//                     print(UserController.carDetails.plakMotor2);
//                   },initValue:  UserController.carDetails.plakMotor2!=null?UserController.carDetails.plakMotor2:''),
//                   PlakInput(3,(text){
//
//                     UserController.carDetails.plakMotor1=text;
//                   },initValue:  UserController.carDetails.plakMotor1!=null?UserController.carDetails.plakMotor1:''),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
