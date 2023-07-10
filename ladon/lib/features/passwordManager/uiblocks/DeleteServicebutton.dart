import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ladon/features/passwordManager/bloc/CreateServiceBloc.dart';
import 'package:ladon/features/passwordManager/bloc/ViewPasswordsBloc.dart';
import 'package:ladon/features/passwordManager/bloc/events/ViewPasswordEvents.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';

import '../bloc/events/CreateServiceEvents.dart';

class DeleteServiceButton extends StatelessWidget {
  const DeleteServiceButton({Key? key, required this.serviceBlueprint})
      : super(key: key);
  final ServiceBlueprint serviceBlueprint;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete),
        onPressed: () {
          context
              .read<CreateServiceBloc>()
              .add(DeleteService(serviceBlueprint));
          context.read<ViewPasswordBloc>().add(RefreshPasswords());
          Navigator.of(context).popAndPushNamed("/");
        });
  }
}
