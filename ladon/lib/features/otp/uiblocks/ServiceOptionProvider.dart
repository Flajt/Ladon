import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ladon/features/otp/bloc/OtpBloc.dart';
import 'package:ladon/features/otp/bloc/events/OtpEvents.dart';
import 'package:ladon/features/otp/bloc/states/OtpStates.dart';
import 'package:ladon/features/passwordManager/bloc/ViewPasswordsBloc.dart';
import 'package:ladon/features/passwordManager/bloc/events/ViewPasswordEvents.dart';
import 'package:ladon/features/passwordManager/bloc/states/ViewPasswordStates.dart';

import '../../passwordManager/blueprints/ServiceBlueprint.dart';

class ServiceOptionProvider extends StatefulWidget {
  const ServiceOptionProvider({
    Key? key,
  }) : super(key: key);

  @override
  State<ServiceOptionProvider> createState() => _ServiceOptionProviderState();
}

class _ServiceOptionProviderState extends State<ServiceOptionProvider> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ViewPasswordBloc pwBloc = context.read<ViewPasswordBloc>();
    if (pwBloc.state is! HasPasswords) {
      pwBloc.add(GetPasswords());
    }
  }

  List<DropdownMenuItem<ServiceBlueprint>> tiles = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewPasswordBloc, ViewPasswordState>(
        builder: (context, state) {
      if (state is HasPasswords) {
        List<ServiceBlueprint> blueprints = state.passwords;
        for (ServiceBlueprint element in blueprints) {
          if (element.twoFASecret.isEmpty) {
            tiles.add(DropdownMenuItem(
                value: element,
                child: SizedBox(
                  child: Text(element.label),
                )));
          }
        }
      }
      return BlocBuilder<OtpBloc, OtpState>(
        builder: (context, state) {
          return DropdownButton<ServiceBlueprint>(
              hint: const Text("Service for 2FA/OTP"),
              value: state is HasSetOtpValues ? state.serviceBlueprint : null,
              borderRadius: BorderRadius.circular(8.0),
              items: tiles,
              onChanged: (item) {
                if (item != null) {
                  context.read<OtpBloc>().add(SetOtpService(item));
                }
              });
        },
      );
    });
  }
}
