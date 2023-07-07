import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:ladon/shared/interfaces/MasterKeyStorageInterface.dart';

import '../../../shared/logic/MasterKeyStorageLogic.dart';
import '../../passwordManager/logic/passwordManager.dart';

Future<List<dynamic>> setup() async {
  MasterKeyInterface store = MasterKeyStorageLogic();
  String? key = await store.getMasterKey();
  bool firstTime = false;
  if (key == null) {
    key = base64Encode(Hive.generateSecureKey());
    firstTime = true;
    store.setMasterKey(key);
  }
  await PasswordManager().setup(key);
  return [key, firstTime];
}
