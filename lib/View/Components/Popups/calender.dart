import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:flutter/material.dart';

import '../../../Logic/Controllers/app-controller.dart';
import '../../../Logic/Controllers/user-controller.dart';

/// Flutter code sample for [showDatePicker].


// class Calender extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       restorationScopeId: 'app',
//       home: DatePickerExample(restorationId: 'main'),
//     );
//   }
// }

class Calender extends StatefulWidget {
  String title,lable;
  Function?onClick;
  final String? restorationId;

  Calender(this.title,this.lable,{this.onClick, this.restorationId});


  @override
  State<Calender> createState() => _CalenderState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _CalenderState extends State<Calender>
    with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  String? selectDate;
  final RestorableDateTime _selectedDate =
  RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(1924),
          lastDate: DateTime.now(),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {

        _selectedDate.value = newSelectedDate;
        selectDate='${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
        UserController.user.value.dateCertificate='${_selectedDate.value.year}-${_selectedDate.value.month}-${_selectedDate.value.day}';

      });
    }
  }
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppController.of(context)!.value('date of certification')} : ',style: AppController.fontStyle(fontTypes.captionLG, additionalColor1Shade800)),
        SizedBox(height: 5),
        Stack(
          children: [
            GestureDetector(
                onTap: (){
                  _restorableDatePickerRouteFuture.present();

                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                    color:dominantColorShade100.withOpacity(0.7) ,
                  ),
                  height: 55,)),
            selectDate!=null?

            Positioned(
                right: 15,
                top: 15,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    selectDate!,
                    style: AppController.fontStyle(fontTypes.bodySM, additionalColor1Shade500),
                  ),
                )):  Positioned(
                right: 15,
                top: 15,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    UserController.user.value.certificatDate?.main!=null?'${UserController.user.value.certificatDate!.year}/${UserController.user.value.certificatDate!.month}/${UserController.user.value.certificatDate!.day}':UserController.user.value.dateCertificate!=null?'${UserController.user.value.dateCertificate}':'${AppController.of(context)!.value('select date and time')}',
                    style: AppController.fontStyle(fontTypes.bodySM, additionalColor1Shade500),
                  ),
                )),
          ],
        ),
        SizedBox(height: 15)
      ],
    );
  }
}
