import 'package:flutter/material.dart';
import 'package:ladon/shared/provider/OtpProvider.dart';
import 'package:provider/provider.dart';

import '../../passwordManager/blueprints/ServiceBlueprint.dart';

class ServiceOptionProvider extends StatefulWidget {
  const ServiceOptionProvider({
    Key? key,
    required this.passwordFuture,
  }) : super(key: key);

  final Future<List<ServiceBlueprint>> passwordFuture;
  @override
  State<ServiceOptionProvider> createState() => _ServiceOptionProviderState();
}

class _ServiceOptionProviderState extends State<ServiceOptionProvider> {
  ServiceBlueprint? serviceBlueprint;
  late final OtpProvider otpProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    otpProvider = context.read<OtpProvider>();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<ServiceBlueprint>> tiles = [];

    return FutureBuilder<List<ServiceBlueprint>>(
        future: widget.passwordFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ServiceBlueprint> blueprints = snapshot.data!;
            for (ServiceBlueprint element in blueprints) {
              tiles.add(DropdownMenuItem(
                  value: element,
                  child: SizedBox(
                    child: Text(element.label),
                  )));
            }
            return DropdownButton<ServiceBlueprint>(
                hint: const Text("Service for 2FA/OTP"),
                value: serviceBlueprint,
                borderRadius: BorderRadius.circular(8.0),
                items: tiles,
                onChanged: (item) {
                  setState(() {
                    serviceBlueprint = item;
                    otpProvider.serviceBlueprint = item;
                  });
                });
          }
          return const CircularProgressIndicator();
        });
  }
}
