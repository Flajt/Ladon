import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:biometric_storage/biometric_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/logic/passwordManager.dart';
import 'package:path_provider/path_provider.dart';

class ImportExportLogic {
  static Future<void> importHiveFile(String pw) async {
    String path = (await getExternalStorageDirectory())!.path;
    await PasswordManager().tearDown();
    await Hive.deleteBoxFromDisk("passwords", path: path);
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false, type: FileType.any, withReadStream: true);
    if (result != null) {
      File hiveFile = File("$path/${result.files.first.name}");
      hiveFile = await hiveFile.create();
      IOSink sink = hiveFile.openWrite();
      result.files.first.readStream!
          .listen(sink.add, onDone: () => sink.close());
      final store = await BiometricStorage().getStorage('ladonStorage');
      await store.write(pw);
    } else {
      throw "No file selected";
    }
  }

  static Future<List<dynamic>> exportHiveFile() async {
    await PasswordManager().tearDown();
    Directory? dir = (await getExternalStorageDirectory());
    File f = File("${dir!.path}/passwords.hive");
    Uint8List bytes = await f.readAsBytes();
    return [bytes, f];
  }

  static Future<String> exportPlainText() async {
    LazyBox box = Hive.lazyBox<ServiceBlueprint>("passwords");
    Iterable keys = box.keys;
    if (keys.isEmpty) {
      throw "No Passwords found!";
    }
    List<ServiceBlueprint> passwordBlueprints = [];
    for (String key in keys) {
      ServiceBlueprint? currentEntry = await box.get(key);
      if (currentEntry != null) passwordBlueprints.add(currentEntry);
    }
    Directory? dir = await getExternalStorageDirectory();
    File exportFile = await File("${dir!.path}/exports.json").create();
    IOSink sink = exportFile.openWrite();
    sink.writeln("[");
    passwordBlueprints.forEach((element) {
      sink.writeln("${element.toJson()},");
    });
    sink.writeln("]");
    await sink.close();
    return exportFile.path;
  }
}
