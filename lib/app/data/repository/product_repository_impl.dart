import 'package:list_of_products/app/data/gateway/product_gateway.dart';
import 'package:list_of_products/app/data/serializers/products_serializer.dart';
import 'package:list_of_products/app/domain/entities/products.dart';
import 'package:dartz/dartz.dart';
import 'package:list_of_products/app/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductGatewayImpl productGatewayImpl;

  ProductRepositoryImpl({this.productGatewayImpl});

  @override
  Future<Either<String, bool>> saveProducts(Products products) async {
    ProductsSerializer productsSerializer = ProductsSerializer(
        id: products.id,
        name: products.name,
        description: products.description,
        price: products.price,
        fabricator: products.fabricator,
        user: products.user);
    try {
      final result = await productGatewayImpl.saveProduct(productsSerializer);
      bool success;
      String messageError;
      result.fold((l) => messageError = l, (r) => success = r);
      if (success) {
        return Right(success);
      } else {
        return Left(messageError);
      }
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<String, List<Products>>> getListProducts() async {
    try {
      final result = await productGatewayImpl.getListProducts();
      List<Products> products = [];
      for (var list in result) {
        Products newProduct = Products(
            id: list.id,
            name: list.name,
            description: list.description,
            price: list.price,
            fabricator: list.fabricator,
            user: list.user);
        products.add(newProduct);
      }
      return Right(products);
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<String, bool>> deleteProdcuts(String id) async {
    try {
      final result = await productGatewayImpl.deleteProduct(id);
      return Right(result);
    } catch (e) {
      return Left(e);
    }
  }
}
