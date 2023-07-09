import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../passwordManager/blueprints/ServiceBlueprint.dart';

abstract class OtpState extends Equatable {}

class InitalOtpState extends OtpState {
  @override
  List<Object?> get props => [];
}

class HasServiceBlueprints extends OtpState {
  final List<ServiceBlueprint> serviceBlueprints;

  HasServiceBlueprints(this.serviceBlueprints);

  @override
  List<Object?> get props => [serviceBlueprints];
}

class HasSetOtpValues extends OtpState {
  final ServiceBlueprint? serviceBlueprint;
  final String? otpSecret;
  HasSetOtpValues(this.serviceBlueprint, this.otpSecret);
  @override
  List<Object?> get props => [serviceBlueprint];
}

class HasSavedOtpValues extends OtpState {
  @override
  List<Object?> get props => [];
}

class OtpError extends OtpState {
  final String message;

  OtpError(this.message);

  @override
  List<Object?> get props => [message];
}

class HasSavedOtp extends OtpState {
  @override
  List<Object?> get props => [];
}

class HasDeletedOtp extends OtpState {
  @override
  List<Object?> get props => [];
}
