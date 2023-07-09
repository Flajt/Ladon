import 'package:flutter/material.dart';

class PasswordPartSelector extends StatelessWidget {
  const PasswordPartSelector(
      {Key? key,
      required this.text,
      required this.initalValue,
      required this.onChanged})
      : super(key: key);
  final dynamic initalValue;
  final String text;
  final Function(bool? option) onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(
          value: initalValue, onChanged: (newValue) => onChanged(newValue)),
      Text(text)
    ]);
  }
}
