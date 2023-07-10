import 'package:equatable/equatable.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';

abstract class ViewPasswordState extends Equatable {}

class InitialViewPasswordState extends ViewPasswordState {
  @override
  List<Object?> get props => [];
}

class HasPasswords extends ViewPasswordState {
  final List<ServiceBlueprint> passwords;

  HasPasswords(this.passwords);

  @override
  List<Object?> get props => [passwords];
}

class HasError extends ViewPasswordState {
  final String message;

  HasError(this.message);

  @override
  List<Object?> get props => [message];
}

class RedirectToWelcome extends ViewPasswordState {
  final String key;

  RedirectToWelcome(this.key);
  @override
  List<Object?> get props => [];
}
