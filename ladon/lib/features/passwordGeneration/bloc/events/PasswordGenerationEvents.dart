import 'package:equatable/equatable.dart';

abstract class PasswordGenerationEvent extends Equatable {}

class GeneratePassword extends PasswordGenerationEvent {
  @override
  List<Object?> get props => [null];
}

class ChangePasswordLength extends PasswordGenerationEvent {
  ChangePasswordLength(this.passwordLength);

  final int passwordLength;
  @override
  List<Object?> get props => [passwordLength];
}

class EnableSpecialCharacters extends PasswordGenerationEvent {
  EnableSpecialCharacters(this.specialChar);

  final bool specialChar;
  @override
  List<Object?> get props => [specialChar];
}

class EnableNumbers extends PasswordGenerationEvent {
  EnableNumbers(this.numbers);

  final bool numbers;
  @override
  List<Object?> get props => [numbers];
}

class EnableUppercase extends PasswordGenerationEvent {
  EnableUppercase(this.uppercase);

  final bool uppercase;
  @override
  List<Object?> get props => [uppercase];
}
