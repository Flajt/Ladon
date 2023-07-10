import 'package:flutter/services.dart';
import 'package:flutter_autofill_service/flutter_autofill_service.dart';
import 'package:ladon/features/passwordManager/logic/PasswordManager.dart';

import '../../otp/logic/generateOtp.dart';
import '../blueprints/ServiceBlueprint.dart';

Future<void> handleAutoFillRequest() async {
  PasswordManager passwordManager = PasswordManager();
  bool fillauto = await AutofillService().fillRequestedAutomatic;

  if (fillauto) {
    AutofillMetadata? metadata = await AutofillService().autofillMetadata;
    String? webDomain = metadata!.webDomains.isNotEmpty
        ? "${metadata.webDomains.first.scheme!}://${metadata.webDomains.first.domain}"
        : null;
    String? appName =
        metadata.packageNames.isNotEmpty ? metadata.packageNames.first : null;
    List<ServiceBlueprint> matchingPasswords =
        await passwordManager.searchPassword(webDomain, appName);
    if (matchingPasswords.isNotEmpty) {
      List<PwDataset> matchingDatasets = [];
      for (ServiceBlueprint element in matchingPasswords) {
        matchingDatasets.add(PwDataset(
            label: element.label,
            username: element.email,
            password: element.password));
      }
      if (matchingDatasets.isNotEmpty) {
        if (matchingPasswords.length == 1) {
          if (matchingPasswords[0].twoFASecret.isNotEmpty) {
            String otp = generateTotp(matchingPasswords[0].twoFASecret);
            await Clipboard.setData(ClipboardData(text: otp.toString()));
          }
        }
        await AutofillService().resultWithDatasets(matchingDatasets);
      }
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

Future<void> handleManuelRequest(ServiceBlueprint blueprint) async {
  bool manuelFill = await AutofillService().fillRequestedInteractive;
  if (manuelFill) {
    await AutofillService().resultWithDataset(
        label: blueprint.label,
        username: blueprint.label,
        password: blueprint.password);
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
