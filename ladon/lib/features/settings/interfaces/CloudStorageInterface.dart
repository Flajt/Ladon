abstract class CloudStorageInterface {
  Future<void> init();
  Future<void> authenticate();
  Future<void> upload();
  Future<void> download();
  Future<void> disconnect();
}
