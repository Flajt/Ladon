import 'package:flutter_autofill_service/flutter_autofill_service.dart';
import '../../passwordManager/blueprints/ServiceBlueprint.dart';
import '../../passwordManager/logic/passwordManager.dart';

Future<void> savePasswordOnRequest() async {
  AutofillMetadata? metadata = await AutofillService().getAutofillMetadata();
  bool shouldSave = metadata?.saveInfo != null;
  if (shouldSave) {
    String? webdomain;
    String? schema;
    String? appName;
    if (metadata!.webDomains.isNotEmpty) {
      webdomain = metadata.webDomains.first.domain;
      schema = metadata.webDomains.first.scheme;
    }
    if (metadata.packageNames.isNotEmpty) {
      appName = metadata.packageNames.first;
    }
    SaveInfoMetadata? saveInfo = metadata.saveInfo;
    print(saveInfo);
    await PasswordManager().savePassword(ServiceBlueprint(
        saveInfo!.password!,
        saveInfo.username!,
        appName ?? webdomain ?? "Unkown service",
        "",
        webdomain != null ? schema! + "://" + webdomain + "/favicon.ico" : null,
        webdomain,
        appName));
    await AutofillService().onSaveComplete();
  }
}
