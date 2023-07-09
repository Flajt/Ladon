import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ladon/features/otp/bloc/OtpBloc.dart';
import 'package:ladon/features/otp/bloc/states/OtpStates.dart';
import 'package:ladon/features/otp/blueprints/OtpBlueprint.dart';
import 'package:ladon/features/otp/uiblocks/OtpTile.dart';
import 'package:ladon/features/passwordManager/bloc/ViewPasswordsBloc.dart';
import 'package:ladon/features/passwordManager/bloc/events/ViewPasswordEvents.dart';
import 'package:ladon/features/passwordManager/bloc/states/ViewPasswordStates.dart';
import 'package:ladon/shared/notifications/uiblock/SuccessNotification.dart';

class ViewOtpsPage extends StatelessWidget {
  const ViewOtpsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ViewPasswordBloc>().add(GetPasswords());
    return BlocListener<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is HasDeletedOtp) {
          context.read<ViewPasswordBloc>().add(RefreshPasswords());
          SuccessNotification(
                  message: "Deleted OTP successfully", context: context)
              .show(context);
        }
      },
      child: Scaffold(
        body: SafeArea(child: BlocBuilder<ViewPasswordBloc, ViewPasswordState>(
            builder: (context, state) {
          if (state is HasPasswords) {
            return ListView.builder(
                itemCount: state.passwords.length,
                itemBuilder: (context, index) {
                  if (state.passwords[index].twoFASecret.isNotEmpty) {
                    return OtpTile(
                        otpBlueprint: OtpBlueprint.fromServiceBlueprint(
                            state.passwords[index]));
                  } else {
                    return Container();
                  }
                });
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        })),
      ),
    );
  }
}
