import 'dart:io';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:share_plus/share_plus.dart';

import '../../importExportMangment/logic/ImportExportLogic.dart';
import '../../importExportMangment/uiblocks/ImportDialog.dart';
import '../logic/BackupLogic.dart';
import '../logic/WhichBackuplogic.dart';

class ImportExportDialog extends StatelessWidget {
  const ImportExportDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: SizedBox(
        width: size.width * .4,
        height: size.height * .38,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(LineAwesome.file_export_solid),
              title: const Text("Export Passwords"),
              subtitle: const Text("Exports passwords in plaintext"),
              onTap: () async {
                final box = context.findRenderObject() as RenderBox?;
                String path = await ImportExportLogic.exportPlainText();
                XFile file = XFile(path);
                await _shareFile(box, file);
                await File(path).delete();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(LineAwesome.file_export_solid),
              title: const Text("Export Storage"),
              subtitle: const Text("Use if you want to migrate devices"),
              onTap: () async {
                List<dynamic> data = await ImportExportLogic.exportHiveFile();
                // ignore: use_build_context_synchronously
                final box = context.findRenderObject() as RenderBox?;
                _shareFile(
                    box,
                    XFile.fromData(data[0],
                        name: "passwords.hive", path: data[1].path));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(LineAwesome.file_import_solid),
              title: const Text("Import Storage"),
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => ImportDialog(
                      importFunction: (pw) =>
                          ImportExportLogic.importHiveFile(pw))),
              subtitle: const Text("Import hive file"),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Bootstrap.cloud_download),
              title: const Text("Restore Backup"),
              subtitle: const Text("Restore backup from Google Drive"),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => ImportDialog(importFunction: ((pw) {
                          WhichBackupService whichBackupService =
                              WhichBackupService();
                          final BackupLogic logic =
                              BackupLogic(whichBackupService);
                          logic.restoreBackup(pw);
                        })));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _shareFile(RenderBox? box, XFile file) async {
    await Share.shareXFiles(
      [file],
      subject: "Ladon password storage",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
