import 'package:flutter/material.dart';
import 'package:list_of_products/app/domain/entities/products.dart';
import 'package:list_of_products/app/domain/services/product_service.dart';
import 'package:list_of_products/app/domain/services/user_service.dart';

class HomeController with ChangeNotifier {
  final ProductServiceImpl productServiceImpl;
  final UserServiceImpl userServiceImpl;

  HomeController({this.productServiceImpl, this.userServiceImpl});
  List<Products> list = [];
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> initializeListProducts() async {
    _isLoading = true;
    notifyListeners();
    String errorMessage;
    final result = await productServiceImpl.getListProdutcs();
    result.fold(
      (l) => {
        errorMessage = l,
      },
      (r) => {
        list = r,
      },
    );
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> logout() async {
    _isLoading = true;
    notifyListeners();
    String errorMessage;
    bool success = false;
    final result = await userServiceImpl.logout();
    result.fold(
      (l) => {
        errorMessage = l,
      },
      (r) => {
        success = r,
      },
    );
    _isLoading = false;
    notifyListeners();
    return success;
  }
}
