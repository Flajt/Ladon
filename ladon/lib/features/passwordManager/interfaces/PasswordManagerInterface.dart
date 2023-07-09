import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';

import '../../otp/blueprints/OtpBlueprint.dart';

abstract class PasswordManagerInterface {
  Future<void> setup(String path, String key);
  Future<List<ServiceBlueprint>> getPasswords();
  Future<void> savePassword(ServiceBlueprint blueprint);
  Future<void> deletePassword(ServiceBlueprint blueprint);
  Future<List<ServiceBlueprint>> searchPassword(
      String? domainName, String? appname);
  Future<void> saveOtp(String secret, ServiceBlueprint blueprint);
  Future<void> delete();
  Future<void> tearDown();
  Future<void> deleteOtp(OtpBlueprint blueprint);
}
