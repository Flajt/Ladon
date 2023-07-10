import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ladon/features/otp/bloc/OtpBloc.dart';
import 'package:ladon/features/otp/bloc/events/OtpEvents.dart';
import 'package:ladon/shared/notifications/uiblock/FailureNotification.dart';
import 'package:ladon/shared/notifications/uiblock/SuccessNotification.dart';

import '../features/otp/bloc/states/OtpStates.dart';
import '../features/otp/uiblocks/OtpSaveWidget.dart';
import '../features/otp/uiblocks/ServiceOptionProvider.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<OtpBloc, OtpState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) async {
        if (state is HasSavedOtp) {
          SuccessNotification(
                  message: "OTP saved successfully", context: context)
              .show(context);
          await Future.delayed(const Duration(seconds: 2));
          Navigator.of(context).pop();
        } else if (state is OtpError) {
          FailureNotification(message: state.message, context: context)
              .show(context);
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                Positioned(
                    top: size.height * .05,
                    left: size.width * 0.2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Save OTP",
                          style: Theme.of(context).textTheme.headline3),
                    )),
                Center(
                  child: SizedBox(
                    height: size.height * .6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OtpSaveWidget(size: size),
                        const ServiceOptionProvider(),
                        ElevatedButton(
                            onPressed: () {
                              context.read<OtpBloc>().add(SaveOtp());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                minimumSize: const Size(150, 50)),
                            child: const Text(
                              "Save 2FA",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ))),
    );
  }
}
