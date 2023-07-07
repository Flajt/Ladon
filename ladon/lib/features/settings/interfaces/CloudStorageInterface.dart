import 'dart:typed_data';

abstract class CloudStorageInterface {
  Future<void> init();
  Future<void> authenticate();
  Future<void> upload();
  Future<Uint8List> download();
  Future<void> disconnect();
}
