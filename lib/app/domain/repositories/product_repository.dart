import 'package:dartz/dartz.dart';
import 'package:list_of_products/app/core/erros.dart';
import 'package:list_of_products/app/domain/entities/products.dart';

abstract class ProductRepository {
  Future<Either<FailureProduct, bool>> saveProducts(Products products);

  Future<Either<FailureProduct, List<Products>>> getListProducts();
}
