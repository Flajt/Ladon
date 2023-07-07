import 'package:ladon/features/settings/interfaces/WhichBackupInterface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WhichBackupService implements WhichBackupServiceInterface {
  static const key = "backupService";
  final Map<String, BackupService> _mapper = {
    BackupService.googleDrive.name: BackupService.googleDrive,
    BackupService.webDav.name: BackupService.webDav,
    BackupService.iCloud.name: BackupService.iCloud,
    BackupService.dropbox.name: BackupService.dropbox,
    BackupService.oneDrive.name: BackupService.oneDrive,
    BackupService.none.name: BackupService.none
  };
  @override
  Future<BackupService> get backupService async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? service = prefs.getString(WhichBackupService.key);
    return _mapper[service] ?? BackupService.none;
  }

  @override
  setBackupService(BackupService service) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(WhichBackupService.key, service.name);
  }
}
