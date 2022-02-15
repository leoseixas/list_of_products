import 'package:flutter/material.dart';
import 'package:list_of_products/app/core/erros.dart';
import 'package:list_of_products/app/domain/entities/products.dart';
import 'package:list_of_products/app/domain/services/product_service.dart';

class HomeController with ChangeNotifier {
  final ProductServiceImpl productServiceImpl;

  HomeController({this.productServiceImpl});
  List<Products> list = [];

  Future<void> initializeListProducts() async {
    FailureProduct errorMessage;
    final result = await productServiceImpl.getListProdutcs();
    result.fold((l) => {errorMessage = l}, (r) => {list = r});
    notifyListeners();
  }
}
