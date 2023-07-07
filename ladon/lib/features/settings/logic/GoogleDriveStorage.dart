import 'dart:io';
import 'dart:typed_data';
import 'package:drive_helper/drive_helper.dart';
import 'package:ladon/features/settings/interfaces/CloudStorageInterface.dart';
import 'package:path_provider/path_provider.dart';

class GoogleDriveStorage implements CloudStorageInterface {
  DriveHelper? _driveHelper;

  @override
  Future<void> authenticate() async {}

  @override
  Future<Uint8List> download() async {
    List<String> fileIDs = await _driveHelper!.getFileID("passwords.hive");
    String data = await _driveHelper!.getData(fileIDs.first);
    Uint8List bytes = Uint8List.fromList(data.codeUnits);
    return bytes;
  }

  @override
  Future<void> init() async {
    _driveHelper = await DriveHelper.initialise([DriveScopes.app]);
  }

  @override
  Future<void> upload() async {
    List<String> fileIDs = [];
    try {
      fileIDs = await _driveHelper!.getFileID("passwords.hive");
    } catch (e) {
      String fileID = await _driveHelper!
          .createFile("passwords.hive", "application/octet-stream");
      fileIDs.add(fileID);
    }

    Directory? dir = (await getExternalStorageDirectory());
    File f = File("${dir!.path}/passwords.hive");
    Uint8List fileContent = await f.readAsBytes();
    await _driveHelper?.updateFile(fileIDs.first, fileContent.toString());
  }

  @override
  Future<void> disconnect() async {
    await _driveHelper?.disconnect();
  }
}
