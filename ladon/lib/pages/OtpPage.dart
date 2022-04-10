import 'package:flutter/material.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/logic/passwordManager.dart';
import 'package:ladon/shared/notifications/uiblock/FailureNotification.dart';
import 'package:ladon/shared/notifications/uiblock/SuccessNotification.dart';
import 'package:ladon/shared/provider/OtpProvider.dart';
import 'package:provider/provider.dart';

import '../features/otp/uiblocks/OtpSaveWidget.dart';
import '../features/otp/uiblocks/ServiceOptionProvider.dart';

class OtpPage extends StatelessWidget {
  OtpPage({Key? key}) : super(key: key);
  final passwordFuture = PasswordManager().getPasswords();
  @override
  Widget build(BuildContext context) {
    OtpProvider otpProvider = context.read<OtpProvider>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                  top: size.height * .05,
                  left: size.width * 0.05,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Save OTP",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor)),
                  )),
              Center(
                child: SizedBox(
                  height: size.height * .6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OtpSaveWidget(size: size),
                      ServiceOptionProvider(passwordFuture: passwordFuture),
                      ElevatedButton(
                          onPressed: () {
                            String otp = otpProvider.otp;
                            if (otp.isNotEmpty &&
                                otp.length > 3 &&
                                otpProvider.blueprint != null) {
                              PasswordManager()
                                  .saveOtp(otp, otpProvider.blueprint!);
                              SuccessNotification(
                                      context: context,
                                      message: "Added 2FA Secret")
                                  .show(context);
                            } else {
                              print(otp.isNotEmpty);
                              print(otp.length);
                              print(otpProvider.blueprint?.label);
                              FailureNotification(
                                context: context,
                                message: "No secret and/or service provided",
                              ).show(context);
                            }
                          },
                          child: const Text(
                            "Save 2FA",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              minimumSize: const Size(150, 50)))
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
