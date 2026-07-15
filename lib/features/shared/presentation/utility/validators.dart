import 'package:email_validator/email_validator.dart';

class Validators {
  static String? validateInput(String? input, String massage) {
    if (input == null ||input.isEmpty ) {
      return massage;
    }
    return null;
  }

  static String? validateEmail(String? input) {
    if (EmailValidator.validate(input ?? '') == false) {
      return "Enter a valid email";
    }
    return null;
  }

  static String? validatePassword(String? input) {
    if ((input ?? '').length < 6) {
      return "Enter a password more than 5 latters";
    }
    return null;
  }

  static String? validateConformPasswrod(String? input, String password) {
    if (input == password) {
      return "Confirm password doesn't match";
    }
    return null;
  }
}
