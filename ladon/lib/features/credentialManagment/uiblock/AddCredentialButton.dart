import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';

class AddCredentialButton extends StatelessWidget {
  const AddCredentialButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HawkFabMenu(
        blur: 0.0,
        backgroundColor: Colors.transparent,
        body: const Icon(Icons.add),
        items: [
          HawkFabMenuItem(
              label: "Password",
              ontap: () => Navigator.of(context).pushNamed("/addPasswordPage"),
              icon: const Icon(Icons.key)),
          HawkFabMenuItem(
              label: "2FA",
              ontap: () => Navigator.of(context).pushNamed("/addOtpPage"),
              icon: const Icon(Icons.sms)),
          HawkFabMenuItem(
              label: "Generate Password",
              ontap: () =>
                  Navigator.of(context).pushNamed("/passwordGenerationPage"),
              icon: const Icon(Icons.text_fields_rounded))
        ]);
  }
}
