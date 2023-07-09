import 'package:equatable/equatable.dart';

abstract class PasswordGenerationState extends Equatable {}

class InitalPasswordGenerationState extends PasswordGenerationState {
  @override
  List<Object?> get props => [];
}

class HasGeneratedPassword extends PasswordGenerationState {
  HasGeneratedPassword(this.generatedPassword, this.passwordLength);

  final String generatedPassword;
  final int passwordLength;
  @override
  List<Object?> get props => [generatedPassword, passwordLength];
}

class HasChangedPWRequirement extends PasswordGenerationState {
  HasChangedPWRequirement(this.passwordLength, this.letters, this.uppercase,
      this.numbers, this.specialChar);

  final int passwordLength;
  final bool letters;
  final bool uppercase;
  final bool numbers;
  final bool specialChar;
  @override
  List<Object?> get props =>
      [passwordLength, letters, uppercase, numbers, specialChar];
}
