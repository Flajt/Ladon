import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ladon/features/passwordManager/logic/handleAutofillRequests.dart';
import 'package:ladon/shared/notifications/uiblock/SuccessNotification.dart';

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
          backgroundColor: Colors.transparent,
          child: blueprint.logoUrl != null && blueprint.logoUrl!.isNotEmpty
              ? Image.network(blueprint.logoUrl!)
              : const Icon(
                  Icons.question_mark,
                  color: Colors.black,
                )),
      onTap: () => handleManuelRequest(blueprint),
      onLongPress: () => Navigator.of(context)
          .pushNamed("/editPasswordPage", arguments: {"blueprint": blueprint}),
      trailing: IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: blueprint.password));
            SuccessNotification(context: context, message: "Copied Password")
                .show(context);
          },
          icon: const Icon(Icons.copy)),
    );
  }
}
