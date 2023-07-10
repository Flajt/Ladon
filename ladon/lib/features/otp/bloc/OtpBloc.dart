import 'package:bloc/bloc.dart';
import 'package:ladon/features/otp/bloc/events/OtpEvents.dart';
import 'package:ladon/features/otp/bloc/states/OtpStates.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/interfaces/PasswordManagerInterface.dart';

import '../../passwordManager/logic/PasswordManager.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final PasswordManagerInterface _passwordManagerInterface = PasswordManager();
  OtpBloc() : super(InitalOtpState()) {
    String? otpSecret;
    ServiceBlueprint? serviceBlueprint;
    on((event, emit) async {
      try {
        if (event is DeleteOtp) {
          await _passwordManagerInterface.deleteOtp(event.otpBlueprint);
          emit(HasDeletedOtp());
        } else if (event is SaveOtp) {
          if (otpSecret != null && serviceBlueprint != null) {
            await _passwordManagerInterface.saveOtp(
                otpSecret!, serviceBlueprint!);
            otpSecret = null;
            serviceBlueprint = null;
            emit(HasSavedOtp());
          }
        } else if (event is SetOtpSecret) {
          otpSecret = event.otpSecret;
          emit(HasSetOtpValues(serviceBlueprint, otpSecret));
        } else if (event is SetOtpService) {
          serviceBlueprint = event.serviceBlueprint;
          emit(HasSetOtpValues(serviceBlueprint, otpSecret));
        }
      } catch (e) {
        emit(OtpError(e.toString()));
      }
    });
  }
}
