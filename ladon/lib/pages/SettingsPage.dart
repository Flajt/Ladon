import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ladon/features/settings/interfaces/WhichBackupInterface.dart';
import 'package:ladon/features/settings/logic/BackupLogic.dart';
import 'package:ladon/features/settings/logic/WhichBackuplogic.dart';
import 'package:ladon/features/settings/uiblocks/SupportDialog.dart';
import 'package:ladon/shared/logic/MasterKeyStorageLogic.dart';
import 'package:ladon/shared/notifications/uiblock/SuccessNotification.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../features/serviceSettings/logic/servicePreferences.dart';
import '../features/settings/uiblocks/ImportExportDialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back))),
        const Divider(),
        ListTile(
            title: const Text("Support"),
            subtitle: const Text("Support the developer"),
            onTap: () => showDialog(
                context: context, builder: (context) => const SupportDialog())),
        const Divider(),
        ListTile(
          title: const Text("Github"),
          subtitle: const Text("Check the code out"),
          onTap: () => launchUrlString("https://github.com/Flajt/ladon"),
        ),
        const Divider(),
        ListTile(
            title: const Text("Import/Export"),
            subtitle: const Text("Import/Export your passwords"),
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) => const ImportExportDialog());
            }),
        const Divider(),
        ListTile(
          title: const Text("Enable Autofill"),
          onTap: () async =>
              await ServicePreferences.setupAutoFillServiceIfNotSelected(),
        ),
        const Divider(),
        ListTile(
            title: const Text("Google Drive"),
            subtitle: const Text("Backup/Restore to/from Google Drive"),
            onTap: () async {
              WhichBackupService whichBackupService = WhichBackupService();
              final BackupLogic logic = BackupLogic(whichBackupService);
              await whichBackupService
                  .setBackupService(BackupService.googleDrive);
              await logic.enableBackup();
            }),
        const Divider(),
        ListTile(
          title: const Text("Copy Master Key"),
          subtitle: const Text("Copies the Master Key to the clipboard"),
          onTap: () async {
            String? pw = await MasterKeyStorageLogic().getMasterKey();
            Clipboard.setData(ClipboardData(text: pw));
            // ignore: use_build_context_synchronously
            SuccessNotification(
                    message: "Master Key copied to clipboard", context: context)
                .show(context);
          },
        ),
        const Divider(),
        const AboutListTile(
          applicationName: "Ladon",
          applicationLegalese: "Copyright 2023 Tjalf Bartel",
        ),
        const Divider()
      ],
    )));
  }
}
