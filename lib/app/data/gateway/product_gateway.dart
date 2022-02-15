import 'package:dartz/dartz.dart';
import 'package:list_of_products/app/core/erros.dart';
import 'package:list_of_products/app/core/table_keys.dart';
import 'package:list_of_products/app/data/serializers/products_serializer.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class ProductGateway {
  Future<Either<String, bool>> saveProduct(
      ProductsSerializer productsSerializer);

  Future<List<ProductsSerializer>> getListProducts();
}

class ProductGatewayImpl implements ProductGateway {
  @override
  Future<Either<String, bool>> saveProduct(
      ProductsSerializer productsSerializer) async {
    final parseUser = await ParseUser.currentUser() as ParseUser;
    final productObject = ParseObject(keyProductTable);
    if (productsSerializer.id != null) {
      productObject.objectId = productsSerializer.id;
    }
    final parseAcl = ParseACL(owner: parseUser);
    parseAcl.setPublicReadAccess(allowed: true);
    parseAcl.setPublicWriteAccess(allowed: false);
    productObject.setACL(parseAcl);

    productObject.set<String>(keyProductName, productsSerializer.name);
    productObject.set<String>(
        keyProductDescription, productsSerializer.description);
    productObject.set<num>(keyProductPrice, productsSerializer.price);

    productObject.set<String>(
        keyProductFabricator, productsSerializer.fabricator);

    productObject.set<ParseUser>(keyProductUserId, parseUser);

    final response = await productObject.save();
    if (response.success == true) {
      return const Right(true);
    }

    String error = '';
    error = await Future.error(ParseErrors.getDescription(response.error.code));

    return Left(error);
  }

  @override
  Future<List<ProductsSerializer>> getListProducts() async {
    final currentUser = await ParseUser.currentUser() as ParseUser;
    final queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(keyProductTable));

    queryBuilder.whereEqualTo(keyProductUserId, currentUser.toPointer());

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      return response.results
          .map((po) => ProductsSerializer.mapParseToProducts(po))
          .toList();
    } else if (response.success && response.results == null) {
      return [];
    } else {
      throw ProductErrorList(message: 'Erro ao carregar lista');
    }
  }
}
