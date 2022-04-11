import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SuccessNotification extends Flushbar {
  SuccessNotification({Key? key, required this.message, required this.context})
      : super(
            key: key,
            message: message,
            duration: const Duration(seconds: 2),
            icon: Icon(Icons.check_circle_outline,
                color: Theme.of(context).primaryColor),
            borderColor: Colors.greenAccent,
            shouldIconPulse: true,
            isDismissible: true);
  final String message;
  final BuildContext context;
}
