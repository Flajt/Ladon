import 'package:flutter_autofill_service/flutter_autofill_service.dart';

class ServicePreferences {
  static Future<bool> hasSelectedAsAutoFillService() async {
    AutofillServiceStatus hasEnabledAutofill = await AutofillService().status;
    return hasEnabledAutofill == AutofillServiceStatus.enabled ? true : false;
  }

  static Future<void> setAsAutoFillService() async {
    await AutofillService().requestSetAutofillService();
  }

  static Future<void> setupAutoFillServiceIfNotSelected() async {
    bool selected = await ServicePreferences.hasSelectedAsAutoFillService();
    if (!selected) ServicePreferences.setAsAutoFillService();
  }
}
