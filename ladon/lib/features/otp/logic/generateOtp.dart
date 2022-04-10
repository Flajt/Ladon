import 'package:otp/otp.dart';

String generateTotp(String secret) {
  //Important: Apperantly nobody cares for the standard, this is why we need to use SHA-1 and isGoogle true ....
  return OTP.generateTOTPCodeString(
      secret.toUpperCase(),
      DateTime.now()
          .toUtc()
          .millisecondsSinceEpoch, //The to uppercase is to resolve issues with wrongly provided secrets
      algorithm: Algorithm.SHA1,
      isGoogle: true);
}
