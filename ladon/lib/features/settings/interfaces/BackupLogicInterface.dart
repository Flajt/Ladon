abstract class BackupLogicInterface {
  Future<void> backup();
  Future<void> restoreBackup(String key);
  Future<void> enableBackup();
}
