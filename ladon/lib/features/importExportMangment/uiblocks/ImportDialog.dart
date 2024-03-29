import 'package:flutter/material.dart';
import 'package:ladon/features/importExportMangment/logic/ImportExportLogic.dart';
import 'package:ladon/shared/notifications/uiblock/SuccessNotification.dart';
import '../../../shared/notifications/uiblock/FailureNotification.dart';

class ImportDialog extends StatelessWidget {
  const ImportDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Dialog(
        child: SizedBox(
      width: 200,
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Please enter your Masterkey",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 160,
            child: TextField(
              controller: controller,
              obscureText: true,
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  await ImportExportLogic.importHiveFile(controller.text);
                  // ignore: use_build_context_synchronously
                  SuccessNotification(
                          message: "Please restart the app now",
                          context: context)
                      .show(context);
                } catch (e, stack) {
                  print(stack);
                  // ignore: use_build_context_synchronously
                  FailureNotification(
                    message: e.toString(),
                    context: context,
                  ).show(context);
                }
              },
              child: const Text("Import"))
        ],
      ),
    ));
  }
}
