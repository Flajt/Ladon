import 'package:ladon/features/importExportMangment/logic/ImportExportLogic.dart';
import 'package:ladon/features/settings/interfaces/WhichBackupInterface.dart';
import 'package:ladon/features/settings/logic/GoogleDriveStorage.dart';
import 'package:ladon/features/settings/logic/WhichBackuplogic.dart';
import 'package:workmanager/workmanager.dart';

import '../../passwordManager/logic/passwordManager.dart';

class BackupLogic {
  BackupLogic(WhichBackupService whichBackupService)
      : _whichBackupService = whichBackupService;
  final WhichBackupService _whichBackupService;

  Future<bool> backup() async {
    BackupService backupService = await _whichBackupService.backupService;

    switch (backupService) {
      case BackupService.googleDrive:
        GoogleDriveStorage googleDriveStorage = GoogleDriveStorage();
        await googleDriveStorage.upload();
        break;
      case BackupService.dropbox:
        break;
      case BackupService.iCloud:
        break;

      case BackupService.oneDrive:
        break;
      case BackupService.webDav:
        break;
      case BackupService.none:
      default:
        break;
    }
    return Future.value(true);
  }

  Future<void> enableBackup() async {
    await Workmanager().registerPeriodicTask("1", "backup",
        frequency: const Duration(days: 7),
        constraints: Constraints(networkType: NetworkType.connected),
        backoffPolicy: BackoffPolicy.linear,
        existingWorkPolicy: ExistingWorkPolicy.replace);
  }

  Future<void> restoreBackup(String key) async {
    await PasswordManager().tearDown();
    BackupService backupService = await _whichBackupService.backupService;
    switch (backupService) {
      case BackupService.googleDrive:
        GoogleDriveStorage googleDriveStorage = GoogleDriveStorage();
        await ImportExportLogic.importHiveFile(
            key, () async => await googleDriveStorage.download());
        break;
      case BackupService.dropbox:
        break;
      case BackupService.iCloud:
        break;

      case BackupService.oneDrive:
        break;
      case BackupService.webDav:
        break;
      case BackupService.none:
      default:
        break;
    }
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    BackupLogic backupLogic = BackupLogic(WhichBackupService());
    return await backupLogic.backup();
  });
}
