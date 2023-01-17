import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ladon/features/importExportMangment/logic/ImportExportLogic.dart';
import 'package:ladon/features/importExportMangment/uiblocks/ImportDialog.dart';
import 'package:share_plus/share_plus.dart';

import '../features/serviceSettings/logic/servicePreferences.dart';

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
          title: const Text("Export Passwords"),
          subtitle: const Text("Exports passwords in plaintext"),
          onTap: () async {
            String path = await ImportExportLogic.exportPlainText();
            XFile file = XFile(path);
            await _shareFile(context, file);
          },
        ),
        const Divider(),
        ListTile(
          title: const Text("Export Storage"),
          subtitle: const Text("Use if you want to migrate devices"),
          onTap: () async {
            List<dynamic> data = await ImportExportLogic.exportHiveFile();
            // ignore: use_build_context_synchronously
            _shareFile(
                context,
                XFile.fromData(data[0],
                    name: "passwords.hive", path: data[1].path));
          },
        ),
        const Divider(),
        ListTile(
          title: const Text("Import Storage"),
          onTap: () => showDialog(
              context: context, builder: (context) => const ImportDialog()),
          subtitle: const Text("Import hive file"),
        ),
        const Divider(),
        ListTile(
          title: const Text("Enable Autofill"),
          onTap: () async =>
              await ServicePreferences.setupAutoFillServiceIfNotSelected(),
        ),
        const Divider(),
        const AboutListTile(
          applicationLegalese: "Copyright 2023 Tjalf Bartel",
        ),
        const Divider()
      ],
    )));
  }

  Future<void> _shareFile(BuildContext context, XFile file) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.shareXFiles(
      [file],
      subject: "Ladon password storage",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
