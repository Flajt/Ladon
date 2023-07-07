abstract class MasterKeyInterface {
  Future<void> setMasterKey(String key);
  Future<String?> getMasterKey();
}
