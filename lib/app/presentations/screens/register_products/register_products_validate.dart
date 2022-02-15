import 'package:list_of_products/app/domain/entities/validate.dart';

class RegisterProductsValidate {
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

  Validate validatingDescription(String description) {
    if (description.isEmpty) {
      return Validate(valid: false, description: 'Campo obrigatório');
    } else if (description.length < 5) {
      return Validate(
          valid: false,
          description: 'O descrição precisa ter o mínimo de 5 caracteres');
    } else {
      return Validate(valid: true, description: '');
    }
  }

  Validate validatingPrice(String price) {
    if (price.isEmpty) {
      return Validate(valid: false, description: 'Campo obrigatório');
    } else {
      return Validate(valid: true, description: '');
    }
  }

  Validate validatingFabricator(String fabricator) {
    if (fabricator.isEmpty) {
      return Validate(valid: false, description: 'Campo obrigatório');
    } else {
      return Validate(valid: true, description: '');
    }
  }
}
