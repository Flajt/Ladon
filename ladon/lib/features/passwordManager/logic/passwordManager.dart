import 'package:hive/hive.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';

class PasswordManager {
  static final PasswordManager _instance = PasswordManager._internal();
  factory PasswordManager() => _instance;
  PasswordManager._internal();

  late final LazyBox<ServiceBlueprint> _hiveBox;

  Future<void> setup(List<int> key) async {
    Hive.registerAdapter(ServiceBlueprintAdapter());
    //TODO: Add encryption
    _hiveBox = await Hive.openLazyBox<ServiceBlueprint>("passwords");
  }

  ///Returns all password entries in the db
  Future<List<ServiceBlueprint>> getPasswords() async {
    List<ServiceBlueprint> loginBlueprints = [];
    Iterable<dynamic> keys = _hiveBox.keys;
    for (String key in keys) {
      ServiceBlueprint? currentEntry = await _hiveBox.get(key);
      if (currentEntry != null) loginBlueprints.add(currentEntry);
    }
    return loginBlueprints;
  }

  ///Saves password in database
  Future<void> savePassword(ServiceBlueprint blueprint) async {
    await _hiveBox.put(blueprint.label, blueprint);
  }

  ///Deletes password in database
  Future<void> deletePassword(ServiceBlueprint blueprint) async {
    await _hiveBox.delete(blueprint.label);
  }

  Future<List<ServiceBlueprint>> searchPassword(
      String? domainName, String? appname) async {
    assert(domainName != null || appname != null);
    List<ServiceBlueprint> matchingBlueprints = [];
    List<ServiceBlueprint> passwords = await getPasswords();
    for (ServiceBlueprint blueprint in passwords) {
      if (blueprint.app == appname || blueprint.domain == domainName) {
        matchingBlueprints.add(blueprint);
      }
    }
    return matchingBlueprints;
  }

  Future<void> saveOtp(String secret, ServiceBlueprint blueprint) async {
    final updateBlueprint = ServiceBlueprint(
        blueprint.password,
        blueprint.email,
        blueprint.label,
        secret,
        blueprint.logoUrl,
        blueprint.domain,
        blueprint.app);
    await _hiveBox.put(blueprint.label, updateBlueprint);
  }
}
