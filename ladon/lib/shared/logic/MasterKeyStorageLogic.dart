import 'package:biometric_storage/biometric_storage.dart';
import 'package:ladon/shared/interfaces/MasterKeyStorageInterface.dart';

class MasterKeyStorageLogic implements MasterKeyStorageInterface {
  @override
  Future<String?> getMasterKey() async {
    final store = await BiometricStorage().getStorage('ladonStorage');
    return await store.read();
  }

  @override
  Future<void> setMasterKey(String key) async {
    final store = await BiometricStorage().getStorage('ladonStorage');
    await store.write(key);
  }
}
