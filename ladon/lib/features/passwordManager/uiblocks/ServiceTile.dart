import 'package:flutter/material.dart';

import '../blueprints/ServiceBlueprint.dart';

class ServiceTile extends StatelessWidget {
  const ServiceTile({Key? key, required this.blueprint}) : super(key: key);
  final ServiceBlueprint blueprint;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(blueprint.email),
      title: Text(blueprint.label),
      leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: blueprint.logoUrl != null && blueprint.logoUrl!.isNotEmpty
              ? Image.network(blueprint.logoUrl!)
              : const Icon(
                  Icons.question_mark,
                  color: Colors.black,
                )),
      onTap: () => Navigator.of(context)
          .pushNamed("/editPasswordPage", arguments: {"blueprint": blueprint}),
    );
  }
}
