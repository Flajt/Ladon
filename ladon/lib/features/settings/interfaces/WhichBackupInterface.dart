abstract class WhichBackupServiceInterface {
  Future<BackupService> get backupService;
  Future<void> setBackupService(BackupService service);
}

enum BackupService { googleDrive, dropbox, oneDrive, iCloud, webDav, none }
