import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
//TODO: Remove BuildContext
class FailureNotification extends Flushbar {
  FailureNotification({Key? key, required this.message, required this.context})
      : super(
            key: key,
            message: message,
            icon: const Icon(Icons.error_outline, color: Colors.redAccent),
            duration: const Duration(seconds: 2),
            borderColor: Colors.redAccent,
            shouldIconPulse: true,
            isDismissible: true);
  final String message;
  final BuildContext context;
}
