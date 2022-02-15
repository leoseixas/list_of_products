// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:list_of_products/app/domain/entities/products.dart';
import 'package:list_of_products/app/domain/entities/storage_user.dart';
import 'package:list_of_products/app/domain/entities/validate.dart';
import 'package:list_of_products/app/domain/services/product_service.dart';
import 'package:list_of_products/app/presentations/screens/register_products/register_products_validate.dart';

class RegisterProductsController with ChangeNotifier {
  final ProductServiceImpl productServiceImpl;
  RegisterProductsController({this.productServiceImpl});

  // List<File> images = [];

  // void onImageSelected(File image) async {
  //   images.add(image);
  //   print(images);
  // }

  Validate validate = Validate(valid: false, description: '');
  RegisterProductsValidate registerProductsValidate =
      RegisterProductsValidate();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final fabricatorController = TextEditingController();

  String _nameError = '';
  String _descriptionError = '';
  String _priceError = '';
  String _fabricatorError = '';

  String get nameError => _nameError;
  String get descriptionError => _descriptionError;
  String get priceError => _priceError;
  String get fabricatorError => _fabricatorError;

  bool _nameIsValid = true;
  bool _descriptionIsValid = true;
  bool _priceIsValid = true;
  bool _fabricatorIsValid = true;

  bool get nameIsValid => _nameIsValid;
  bool get descriptionIsValid => _descriptionIsValid;
  bool get priceIsValid => _priceIsValid;
  bool get fabricatorIsValid => _fabricatorIsValid;

  bool isLoading = false;
  bool success = false;
  bool showError = false;

  bool isFormValid() =>
      _nameIsValid && _descriptionIsValid && priceIsValid && _fabricatorIsValid;

  void nameValid(String name) {
    validate = registerProductsValidate.validatingName(name);
    _nameError = validate.description;
    _nameIsValid = validate.valid;
    notifyListeners();
  }

  void descriptionValid(String description) {
    validate = registerProductsValidate.validatingDescription(description);
    _descriptionError = validate.description;
    _descriptionIsValid = validate.valid;
    notifyListeners();
  }

  void priceValid(String price) {
    validate = registerProductsValidate.validatingPrice(price);
    _priceError = validate.description;
    _priceIsValid = validate.valid;
    notifyListeners();
  }

  void fabricatoValid(String fabricato) {
    validate = registerProductsValidate.validatingFabricator(fabricato);
    _fabricatorError = validate.description;
    _fabricatorIsValid = validate.valid;
    notifyListeners();
  }

  void validatingFields() {
    nameValid(nameController.text);
    descriptionValid(descriptionController.text);
    priceValid(priceController.text);
    fabricatoValid(fabricatorController.text);
  }

  String errorText(bool valid, String error) {
    if (valid) {
      return null;
    } else {
      return error;
    }
  }

  num get price {
    if (priceController.text.contains(',')) {
      return num.tryParse(
              priceController.text.replaceAll(RegExp('[^0-9]'), '')) /
          100;
    } else {
      return num.tryParse(priceController.text);
    }
  }

  Future<bool> onPressed() async {
    Products products = Products(
      name: nameController.text,
      description: descriptionController.text,
      price: price,
      fabricator: fabricatorController.text,
      user: StorageUser.user,
    );
    validatingFields();
    if (isFormValid()) {
      isLoading = true;
      notifyListeners();
      final result = await productServiceImpl.saveProduct(products);
      result.fold(
        (l) => {
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
}
