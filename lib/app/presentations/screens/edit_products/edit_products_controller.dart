import 'package:flutter/material.dart';
import 'package:list_of_products/app/domain/entities/products.dart';
import 'package:list_of_products/app/domain/entities/validate.dart';
import 'package:list_of_products/app/domain/services/product_service.dart';
import 'package:list_of_products/app/presentations/screens/edit_products/edit_products_validate.dart';

class EditProductsController with ChangeNotifier {
  final ProductServiceImpl productServiceImpl;
  Products productsEdit;
  Validate validate = Validate();
  EditProductsValidate editProductsValidate = EditProductsValidate();

  EditProductsController({this.productServiceImpl, this.productsEdit});

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final fabricatorController = TextEditingController();

  void initialize(Products products) {
    nameController.text = products.name;
    descriptionController.text = products.description;
    priceController.text = products.price.toString();
    fabricatorController.text = products.fabricator;
    productsEdit = products;
  }

  String messageError = '';

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
    validate = editProductsValidate.validatingName(name);
    _nameError = validate.description;
    _nameIsValid = validate.valid;
    notifyListeners();
  }

  void descriptionValid(String description) {
    validate = editProductsValidate.validatingDescription(description);
    _descriptionError = validate.description;
    _descriptionIsValid = validate.valid;
    notifyListeners();
  }

  void priceValid(String price) {
    validate = editProductsValidate.validatingPrice(price);
    _priceError = validate.description;
    _priceIsValid = validate.valid;
    notifyListeners();
  }

  void fabricatoValid(String fabricato) {
    validate = editProductsValidate.validatingFabricator(fabricato);
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
      id: productsEdit.id,
      name: nameController.text,
      description: descriptionController.text,
      price: price,
      fabricator: fabricatorController.text,
      user: productsEdit.user,
    );
    validatingFields();
    if (isFormValid()) {
      isLoading = true;
      notifyListeners();
      final result = await productServiceImpl.saveProduct(products);
      result.fold(
        (l) => {
          messageError = l,
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
    print(success);
    notifyListeners();
    return success;
  }

  Future<bool> onPressedDeleteProduct() async {
    isLoading = true;
    notifyListeners();
    final result = await productServiceImpl.deleteProduct(productsEdit.id);
    result.fold(
      (l) => {
        messageError = l,
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
    isLoading = false;
    print(success);
    notifyListeners();
    return success;
  }
}
