import 'package:flutter/material.dart';
import 'package:list_of_products/app/core/erros.dart';
import 'package:list_of_products/app/domain/entities/user.dart';
import 'package:list_of_products/app/domain/entities/validate.dart';
import 'package:list_of_products/app/domain/services/user_service.dart';
import 'package:list_of_products/app/presentations/screens/register_user/register_validate.dart';

class RegisterController with ChangeNotifier {
  final UserServiceImpl userServiceImpl;

  RegisterController({this.userServiceImpl});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Validate validate = Validate(valid: false, description: '');
  RegisterValidate registerValidate = RegisterValidate();

  bool isLoading = false;
  bool success = false;
  bool showError = false;
  FailureUser errorSignUp = UserErrorSignUp(message: '');

  String _nameError = '';
  String _emailError = '';
  String _passwordError = '';
  String _confirmPasswordError = '';

  bool _nameIsValid = true;
  bool _emailIsValid = true;
  bool _passwordIsValid = true;
  bool _confirmPasswordIsValid = true;

  String get nameError => _nameError;
  String get emailError => _emailError;
  String get passwordError => _passwordError;
  String get confirmPasswordError => _confirmPasswordError;

  bool get nameIsValid => _nameIsValid;
  bool get emailIsValid => _emailIsValid;
  bool get passwordIsValid => _passwordIsValid;
  bool get confirmPasswordIsValid => _confirmPasswordIsValid;

  bool isFormValid() =>
      _nameIsValid &&
      _emailIsValid &&
      _passwordIsValid &&
      _confirmPasswordIsValid;

  void nameValid(String name) {
    validate = registerValidate.validatingName(name);
    _nameError = validate.description;
    _nameIsValid = validate.valid;
    notifyListeners();
  }

  void emailValid(String email) {
    validate = registerValidate.validatingEmail(email);
    _emailError = validate.description;
    _emailIsValid = validate.valid;
    notifyListeners();
  }

  void passwordValid(String password) {
    validate = registerValidate.validatingPassword(password);
    _passwordError = validate.description;
    _passwordIsValid = validate.valid;
    notifyListeners();
  }

  void confirmPasswordValid(String confirmPassword) {
    validate = registerValidate.validatingConfirmPassword(
        confirmPassword, passwordController.text);
    _confirmPasswordError = validate.description;
    _confirmPasswordIsValid = validate.valid;
    notifyListeners();
  }

  String errorText(bool valid, String error) {
    if (valid) {
      return null;
    } else {
      return error;
    }
  }

  void validatingFields() {
    nameValid(nameController.text);
    emailValid(emailController.text);
    passwordValid(passwordController.text);
    confirmPasswordValid(confirmPasswordController.text);
  }

  Future<bool> onPressed() async {
    validatingFields();

    if (isFormValid()) {
      isLoading = true;
      notifyListeners();
      User user = User(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text);
      final result = await userServiceImpl.signUpUser(user);
      result.fold(
        (l) => {
          errorSignUp = l,
          showError = true,
          success = false,
          notifyListeners(),
        },
        (r) => {
          success = r,
          if (success) {showError = false} else {showError = true},
          notifyListeners(),
        },
      );
    }
    isLoading = false;
    notifyListeners();
    return success;
  }

  void clearController() {
    nameController.text = '';
    emailController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }
}
