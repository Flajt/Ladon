import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:ladon/shared/interfaces/MasterKeyStorageInterface.dart';
import 'package:path_provider/path_provider.dart';

import '../../../shared/logic/MasterKeyStorageLogic.dart';
import '../../passwordManager/logic/PasswordManager.dart';

Future<List<dynamic>> setup() async {
  MasterKeyStorageInterface store = MasterKeyStorageLogic();
  String? key = await store.getMasterKey();
  bool firstTime = false;
  if (key == null) {
    key = base64Encode(Hive.generateSecureKey());
    firstTime = true;
    store.setMasterKey(key);
  }
  Directory? path = await getExternalStorageDirectory();

  await PasswordManager().setup(path!.path, key);
  return [key, firstTime];
}
