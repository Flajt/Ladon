import 'package:flutter/material.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';

class OtpProvider extends ChangeNotifier {
  String? _otp;
  ServiceBlueprint? _serviceBlueprint;

  set otp(String otp) {
    _otp = otp;
    notifyListeners();
  }

  set serviceBlueprint(ServiceBlueprint? blueprint) {
    _serviceBlueprint = blueprint;
    notifyListeners();
  }

  ServiceBlueprint? get blueprint => _serviceBlueprint;

  String get otp => _otp ?? "";
}
