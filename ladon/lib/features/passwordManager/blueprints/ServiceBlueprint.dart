import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'ServiceBlueprint.g.dart';

@HiveType(typeId: 0)
class ServiceBlueprint extends Equatable {
  @HiveField(0)
  final String password;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String label;
  @HiveField(3)
  final String twoFASecret;
  @HiveField(4)
  final String? logoUrl;
  @HiveField(5)
  final String? domain;
  @HiveField(6)
  final String? app;
  ServiceBlueprint(this.password, this.email, this.label, this.twoFASecret,
      this.logoUrl, this.domain, this.app);
  Map<String, dynamic> toJson() {
    return {
      "password": password,
      "lable": label,
      "email": email,
      "twoFASecret": twoFASecret,
      "logoUrl": logoUrl,
      "domain": domain,
      "app": app
    };
  }

  //Create copyWith method
  ServiceBlueprint copyWith(
      {String? password,
      String? email,
      String? label,
      String? twoFASecret,
      String? logoUrl,
      String? domain,
      String? app}) {
    return ServiceBlueprint(
        password ?? this.password,
        email ?? this.email,
        label ?? this.label,
        twoFASecret ?? this.twoFASecret,
        logoUrl ?? this.logoUrl,
        domain ?? this.domain,
        app ?? this.app);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        password,
        email,
        label,
        twoFASecret,
        logoUrl,
        domain,
        app,
      ];
}
