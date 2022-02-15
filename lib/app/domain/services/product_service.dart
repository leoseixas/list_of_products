import 'package:dartz/dartz.dart';
import 'package:list_of_products/app/core/erros.dart';
import 'package:list_of_products/app/domain/entities/products.dart';
import 'package:list_of_products/app/domain/repositories/product_repository.dart';

abstract class ProductService {
  Future<Either<FailureProduct, bool>> saveProduct(Products products);

  Future<Either<FailureProduct, List<Products>>> getListProdutcs();
}

class ProductServiceImpl implements ProductService {
  final ProductRepository productRepository;

  ProductServiceImpl({this.productRepository});

  @override
  Future<Either<FailureProduct, bool>> saveProduct(Products products) async {
    final result = await productRepository.saveProducts(products);
    bool success = false;
    FailureProduct productErrorSave = ProductErrorSave(message: '');
    result.fold((l) => productErrorSave = l, (r) => success = r);
    if (result.isRight()) {
      return Right(success);
    } else {
      return Left(productErrorSave);
    }
  }

  @override
  Future<Either<FailureProduct, List<Products>>> getListProdutcs() async {
    List<Products> newProducts = [];
    FailureProduct errorMessage = ProductErrorList(message: '');
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
}
