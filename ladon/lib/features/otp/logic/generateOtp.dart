import 'package:otp/otp.dart';

generateHOtp(String secret) {
  return OTP.generateTOTPCode(secret, DateTime.now().millisecondsSinceEpoch);
}
