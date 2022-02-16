import 'package:dartz/dartz.dart';
import 'package:list_of_products/app/domain/entities/products.dart';

abstract class ProductRepository {
  Future<Either<String, bool>> saveProducts(Products products);

  Future<Either<String, List<Products>>> getListProducts();
  Future<Either<String, bool>> deleteProdcuts(String id);
}
