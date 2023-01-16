import 'package:flutter_autofill_service/flutter_autofill_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicePreferences {
  static Future<bool> hasSelectedAsAutoFillService() async {
    return await AutofillService().hasAutofillServicesSupport;
  }

  static Future<void> setAsAutoFillService() async {
    await AutofillService().requestSetAutofillService();
  }

  static Future<void> setupAutoFillServiceIfNotSelected() async {
    bool selected = await ServicePreferences.hasSelectedAsAutoFillService();
    if (!selected) ServicePreferences.setAsAutoFillService();
  }
}
