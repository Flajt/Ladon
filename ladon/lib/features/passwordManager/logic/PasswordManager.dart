import 'dart:convert';
import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:ladon/features/otp/blueprints/OtpBlueprint.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';

import '../interfaces/PasswordManagerInterface.dart';

class PasswordManager implements PasswordManagerInterface {
  static final PasswordManager _instance = PasswordManager._internal();
  factory PasswordManager() => _instance;
  PasswordManager._internal();

  late final LazyBox<ServiceBlueprint> _hiveBox;

  @override
  Future<void> setup(String path, String key) async {
    Hive.init(path);
    if (!Hive.isAdapterRegistered(ServiceBlueprintAdapter().typeId)) {
      Hive.registerAdapter(ServiceBlueprintAdapter());
      _hiveBox = await Hive.openLazyBox<ServiceBlueprint>("passwords",
          encryptionCipher: HiveAesCipher(base64Decode(key)));
    }
  }

  ///Returns all password entries in the db
  @override
  Future<List<ServiceBlueprint>> getPasswords() async {
    try {
      List<ServiceBlueprint> loginBlueprints = [];
      Iterable<dynamic> keys = _hiveBox.keys;
      for (String key in keys) {
        ServiceBlueprint? currentEntry = await _hiveBox.get(key);
        if (currentEntry != null) loginBlueprints.add(currentEntry);
      }
      return loginBlueprints;
    } catch (e) {
      return [];
    }
  }

  ///Saves password in database
  @override
  Future<void> savePassword(ServiceBlueprint blueprint) async {
    await _hiveBox.put(blueprint.label, blueprint);
  }

  ///Deletes password in database
  @override
  Future<void> deletePassword(ServiceBlueprint blueprint) async {
    await _hiveBox.delete(blueprint.label);
  }

  @override
  Future<List<ServiceBlueprint>> searchPassword(
      String? domainName, String? appname) async {
    assert(domainName != null || appname != null);
    List<ServiceBlueprint> matchingBlueprints = [];
    List<ServiceBlueprint> passwords = await getPasswords();
    //TODO: Implement faster search algorithm
    for (ServiceBlueprint blueprint in passwords) {
      if (blueprint.app == appname || blueprint.domain == domainName) {
        matchingBlueprints.add(blueprint);
      }
    }
    return matchingBlueprints;
  }

  @override
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

  @override
  Future<void> delete() async => await _hiveBox.deleteFromDisk();
  @override
  Future<void> tearDown() async => await _hiveBox.close();

  @override
  Future<void> deleteOtp(OtpBlueprint blueprint) async {
    ServiceBlueprint? serviceBlueprint =
        await _hiveBox.get(blueprint.serviceLable);
    _hiveBox.put(
        blueprint.serviceLable, serviceBlueprint!.copyWith(twoFASecret: ""));
  }
}
