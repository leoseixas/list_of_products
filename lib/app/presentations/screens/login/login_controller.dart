import 'package:flutter/material.dart';
import 'package:list_of_products/app/core/erros.dart';
import 'package:list_of_products/app/domain/entities/user.dart';
import 'package:list_of_products/app/domain/entities/validate.dart';
import 'package:list_of_products/app/domain/services/user_service.dart';
import 'package:list_of_products/app/presentations/screens/login/login_validate.dart';
import 'package:list_of_products/app/presentations/screens/register_user/register_controller.dart';

class LoginController with ChangeNotifier {
  final UserServiceImpl userServiceImpl;
  LoginController({this.userServiceImpl});

  Validate validate = Validate(valid: false, description: '');
  LoginValidate loginValidate = LoginValidate();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String _emailError = '';
  String _passwordError = '';

  bool _emailIsValid = true;
  bool _passwordIsValid = true;

  String get emailError => _emailError;
  String get passwordError => _passwordError;

  bool get emailIsValid => _emailIsValid;
  bool get passwordIsValid => _passwordIsValid;

  bool isLoading = false;
  bool success = false;
  bool showError = false;
  String errorLogin;

  bool isFormValid() => _emailIsValid && _passwordIsValid;

  void emailValid(String email) {
    validate = loginValidate.validatingEmail(email);
    _emailError = validate.description;
    _emailIsValid = validate.valid;
    notifyListeners();
  }

  void passwordValid(String password) {
    validate = loginValidate.validatingPassword(password);
    _passwordError = validate.description;
    _passwordIsValid = validate.valid;
    notifyListeners();
  }

  String errorText(bool valid, String error) {
    if (valid == null || valid) {
      return null;
    } else {
      return error;
    }
  }

  void validatingFields() {
    emailValid(emailController.text);
    passwordValid(passwordController.text);
  }

  Future<bool> onPressed() async {
    showError = false;
    isLoading = true;
    notifyListeners();
    User user = User(
      name: '',
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: '',
    );
    validatingFields();
    if (isFormValid()) {
      try {
        final result = await userServiceImpl.loginWithEmail(user);
        result.fold(
          (l) => {
            errorLogin = l,
            showError = true,
            success = false,
          },
          (r) => {
            success = r,
            if (success) {showError = false} else {showError = true}
          },
        );
      } catch (e) {
        errorLogin = e;
      }
    }

    isLoading = false;
    notifyListeners();
    return success;
  }

  void clearControllersRegister() {
    RegisterController registerController =
        RegisterController(userServiceImpl: userServiceImpl);

    registerController.nameController.text = '';
    registerController.emailController.text = '';
    registerController.passwordController.text = '';
    registerController.confirmPasswordController.text = '';
    registerController.showError = false;
    registerController.success = false;
  }
}
