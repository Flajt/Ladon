//Create PasswordGeneratorBloc with bloc library

import 'package:bloc/bloc.dart';
import 'package:ladon/features/passwordGeneration/bloc/events/PasswordGenerationEvents.dart';
import 'package:ladon/features/passwordGeneration/bloc/states/PasswordGeneratorState.dart';
import 'package:ladon/features/passwordGeneration/logic/PasswordGeneratorLogic.dart';

class PasswordGeneratorBloc
    extends Bloc<PasswordGenerationEvent, PasswordGenerationState> {
  int passwordLength = 8;
  bool letters = true;
  bool uppercase = true;
  bool numbers = true;
  bool specialChar = true;
  PasswordGeneratorBloc() : super(InitalPasswordGenerationState()) {
    on<GeneratePassword>((event, emit) {
      String password = PasswordGenerator.generatePassword(
          passwordLength: passwordLength,
          letters: letters,
          uppercase: uppercase,
          numbers: numbers,
          specialChar: specialChar);
      emit(HasGeneratedPassword(password, passwordLength));
    });
    on<ChangePasswordLength>((event, emit) {
      passwordLength = event.passwordLength;
      emit(HasChangedPWRequirement(
          passwordLength, letters, uppercase, numbers, specialChar));
    });
    on<EnableSpecialCharacters>((event, emit) {
      specialChar = event.specialChar;
      emit(HasChangedPWRequirement(
          passwordLength, letters, uppercase, numbers, specialChar));
    });
    on<EnableNumbers>((event, emit) {
      numbers = event.numbers;
      emit(HasChangedPWRequirement(
          passwordLength, letters, uppercase, numbers, specialChar));
    });
    on<EnableUppercase>((event, emit) {
      uppercase = event.uppercase;
      emit(HasChangedPWRequirement(
          passwordLength, letters, uppercase, numbers, specialChar));
    });
  }
}
