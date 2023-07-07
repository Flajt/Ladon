import 'package:flutter/material.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/logic/PasswordManager.dart';

class DeleteServiceButton extends StatelessWidget {
  const DeleteServiceButton(
      {Key? key, required this.serviceBlueprint, required this.passwordManager})
      : super(key: key);
  final ServiceBlueprint serviceBlueprint;
  final PasswordManager passwordManager;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete),
        onPressed: () {
          passwordManager.deletePassword(serviceBlueprint);
          Navigator.of(context).popAndPushNamed("/");
        });
  }
}
