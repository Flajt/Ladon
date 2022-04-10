import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';

class OtpBlueprint {
  final String imageUrl;
  final String secret;
  final String serviceLable;

  OtpBlueprint(this.imageUrl, this.secret, this.serviceLable);

  OtpBlueprint.fromServiceBlueprint(ServiceBlueprint serviceBlueprint)
      : imageUrl = serviceBlueprint.logoUrl ?? "",
        secret = serviceBlueprint.twoFASecret,
        serviceLable = serviceBlueprint.label;
}
