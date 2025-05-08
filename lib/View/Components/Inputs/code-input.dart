import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Public/config.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/Public/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:pin_code_fields/pin_code_fields.dart";

class CodeInput extends StatelessWidget {
  Function? onComplete;
  Function? onChange;
  int length;
   CodeInput({Key? key,this.onComplete,this.onChange,this.length=6}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          width: maxItemWidth,
          child: PinCodeTextField(
            autoFocus: true,
            enableActiveFill: true,
            textInputAction:
            TextInputAction.next,
            keyboardType: TextInputType.number,
            textStyle: AppController.fontStyle(fontTypes.header4, additionalColor2Shade700),
            appContext: context,
            pastedTextStyle: TextStyle(
              color: accentColorShade300,
            ),
            length: length,
            animationType: AnimationType.fade,
            validator: (v) {
              if (v!.length < 5) {
              } else {}
            },
            pinTheme: PinTheme (
                inactiveFillColor: Colors.white,
                shape:
                PinCodeFieldShape.box,
                borderWidth: 1,
                activeBorderWidth: 1,
                inactiveBorderWidth: 1,
                selectedBorderWidth: 1,
                disabledBorderWidth: 1,
                borderRadius:
                BorderRadius.circular(10),
                fieldHeight: 45,
                fieldWidth: 42,
                inactiveColor: additionalColor2Shade500,
                activeFillColor:dominantColorShade100,
                activeColor: dominantColorShade300,
                selectedColor: dominantColorShade100,
                selectedFillColor: dominantColorShade100,
            ),
            animationDuration:
            Duration(milliseconds: 300),
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            obscureText: false,
            cursorColor: appColor,
            enablePinAutofill: true,
            useExternalAutoFillGroup: true,

            onCompleted: (value) {
              if(onComplete!=null)
                onComplete!(value);
            },
            onChanged: (value) {
              if(onChange!=null)
                onChange!(value);
            },
            beforeTextPaste: (text) {
              return true;
            },
            useHapticFeedback: true,
          ),
        ));
  }
}
