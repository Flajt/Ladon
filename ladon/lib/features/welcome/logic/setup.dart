import 'dart:convert';

import 'package:biometric_storage/biometric_storage.dart';
import 'package:hive/hive.dart';

import '../../passwordManager/logic/passwordManager.dart';

Future<List<dynamic>> setup() async {
  final store = await BiometricStorage().getStorage('ladonStorage');
  String? key = await store.read();
  bool firstTime = false;
  if (key == null) {
    key = base64Encode(Hive.generateSecureKey());
    firstTime = true;
    store.write(key);
  }
  await PasswordManager().setup(key);
  return [key, firstTime];
}
