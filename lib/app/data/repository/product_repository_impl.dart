import 'package:list_of_products/app/core/erros.dart';
import 'package:list_of_products/app/data/gateway/product_gateway.dart';
import 'package:list_of_products/app/data/serializers/products_serializer.dart';
import 'package:list_of_products/app/domain/entities/products.dart';
import 'package:dartz/dartz.dart';
import 'package:list_of_products/app/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductGatewayImpl productGatewayImpl;

  ProductRepositoryImpl({this.productGatewayImpl});

  @override
  Future<Either<FailureProduct, bool>> saveProducts(Products products) async {
    ProductsSerializer productsSerializer = ProductsSerializer(
        name: products.name,
        description: products.description,
        price: products.price,
        fabricator: products.fabricator,
        user: products.user);
    try {
      final result = await productGatewayImpl.saveProduct(productsSerializer);
      bool success;
      result.fold((l) => null, (r) => success = r);
      if (success) {
        return Right(success);
      } else {
        return Left(ProductErrorSave(message: 'Erro ao cadastrar produto'));
      }
    } catch (e) {
      return Left(ProductErrorSave(message: 'Erro ao cadastrar produto'));
    }
  }

  @override
  Future<Either<FailureProduct, List<Products>>> getListProducts() async {
    try {
      final result = await productGatewayImpl.getListProducts();
      List<Products> products = [];
      for (var list in result) {
        products.add(list);
      }
      return Right(products);
    } catch (e) {
      return Left(
          ProductErrorList(message: 'Erro ao carregar lista de produtos'));
    }
  }
}
