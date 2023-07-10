import 'package:ladon/features/otp/blueprints/OtpBlueprint.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';

abstract class OtpEvent {}

class SaveOtp extends OtpEvent {}

class SetOtpSecret extends OtpEvent {
  final String otpSecret;

  SetOtpSecret(this.otpSecret);
}

class SetOtpService extends OtpEvent {
  final ServiceBlueprint serviceBlueprint;

  SetOtpService(this.serviceBlueprint);
}

class DeleteOtp extends OtpEvent {
  final OtpBlueprint otpBlueprint;

  DeleteOtp(this.otpBlueprint);
}
