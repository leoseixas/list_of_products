import 'package:list_of_products/app/domain/entities/validate.dart';
import 'package:list_of_products/app/core/extensions/string_extensions.dart';

class RegisterValidate {
  Validate validatingName(String name) {
    if (name.isEmpty) {
      return Validate(valid: false, description: 'Campo obrigatório');
    } else if (name.length < 2) {
      return Validate(
          valid: false,
          description: 'O nome precisa ter o mínimo de 3 caracteres');
    } else {
      return Validate(valid: true, description: '');
    }
  }

  Validate validatingEmail(String email) {
    bool response = email.isEmail();
    if (email.isEmpty) {
      return Validate(valid: response, description: 'Campo obrigatório');
    } else if (!response) {
      return Validate(
          valid: response, description: 'Por favor, informe um email válido');
    } else {
      return Validate(valid: response, description: '');
    }
  }

  Validate validatingPassword(String password) {
    if (password.isEmpty) {
      return Validate(valid: false, description: 'Campo obrigatório');
    } else if (password.length < 8) {
      return Validate(
          valid: false,
          description: 'A senha precisa ter o mínimo de 8 caracteres');
    } else {
      return Validate(valid: true, description: '');
    }
  }

  Validate validatingConfirmPassword(String confirmPassword, String password) {
    if (password.isEmpty) {
      return Validate(valid: false, description: 'Campo obrigatório');
    } else if (confirmPassword != password) {
      return Validate(valid: false, description: 'Senha incorreta');
    } else {
      return Validate(valid: true, description: '');
    }
  }
}
