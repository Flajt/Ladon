abstract class MasterKeyStorageInterface {
  Future<void> setMasterKey(String key);
  Future<String?> getMasterKey();
}
