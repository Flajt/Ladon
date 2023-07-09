import 'package:random_password_generator/random_password_generator.dart';

class PasswordGenerator {
  static String generatePassword(
      {bool letters = true,
      bool uppercase = true,
      bool numbers = true,
      bool specialChar = true,
      int passwordLength = 16}) {
    RandomPasswordGenerator generator = RandomPasswordGenerator();
    return generator.randomPassword(
        letters: letters,
        uppercase: uppercase,
        numbers: numbers,
        specialChar: specialChar,
        passwordLength: passwordLength.toDouble());
  }

  static getPwStrength(String password) {
    return RandomPasswordGenerator().checkPassword(password: password);
  }
}
