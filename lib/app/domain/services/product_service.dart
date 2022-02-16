import 'package:dartz/dartz.dart';
import 'package:list_of_products/app/domain/entities/products.dart';
import 'package:list_of_products/app/domain/repositories/product_repository.dart';

abstract class ProductService {
  Future<Either<String, bool>> saveProduct(Products products);
  Future<Either<String, bool>> deleteProduct(String id);

  Future<Either<String, List<Products>>> getListProdutcs();
}

class ProductServiceImpl implements ProductService {
  final ProductRepository productRepository;

  ProductServiceImpl({this.productRepository});

  @override
  Future<Either<String, bool>> saveProduct(Products products) async {
    final result = await productRepository.saveProducts(products);
    bool success = false;
    String messageError;
    result.fold((l) => messageError = l, (r) => success = r);
    if (result.isRight()) {
      return Right(success);
    } else {
      return Left(messageError);
    }
  }

  @override
  Future<Either<String, List<Products>>> getListProdutcs() async {
    List<Products> newProducts = [];
    String errorMessage;
    final result = await productRepository.getListProducts();
    result.fold(
      (l) => {errorMessage = l},
      (r) => {newProducts = r},
    );

    if (result.isRight()) {
      return Right(newProducts);
    } else {
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, bool>> deleteProduct(String id) async {
    final result = await productRepository.deleteProdcuts(id);
    bool success = false;
    String messageError;
    result.fold((l) => messageError = l, (r) => success = r);
    if (result.isRight()) {
      return Right(success);
    } else {
      return Left(messageError);
    }
  }
}
