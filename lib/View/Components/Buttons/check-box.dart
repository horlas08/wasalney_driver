import 'package:driver/Logic/Controllers/main-controller.dart';
import 'package:flutter/material.dart';
class Checked extends StatefulWidget {
  const Checked({Key? key}) : super(key: key);
  @override
  State<Checked> createState() => _CheckedState();
}
class _CheckedState extends State<Checked> {

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: MainController.isChecked.value,
      onChanged: (bool? value) { // This is where we update the state when the checkbox is tapped
        setState(() {
          MainController.isChecked.value = value!;
        });
      },
    );
  }
}