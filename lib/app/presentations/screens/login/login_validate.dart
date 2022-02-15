import 'package:list_of_products/app/core/extensions/string_extensions.dart';
import 'package:list_of_products/app/domain/entities/validate.dart';

class LoginValidate {
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
    } else {
      return Validate(valid: true, description: '');
    }
  }
}
