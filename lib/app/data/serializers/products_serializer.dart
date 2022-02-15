import 'package:list_of_products/app/core/table_keys.dart';
import 'package:list_of_products/app/data/serializers/user_serializer.dart';
import 'package:list_of_products/app/domain/entities/products.dart';
import 'package:list_of_products/app/domain/entities/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProductsSerializer implements Products {
  final String id;
  final String name;
  final String description;
  final num price;
  final String fabricator;
  final User user;

  ProductsSerializer({
    this.id,
    this.name,
    this.description,
    this.price,
    this.fabricator,
    this.user,
  });

  factory ProductsSerializer.mapParseToProducts(ParseObject object) {
    return ProductsSerializer(
      id: object.objectId,
      name: object.get(keyProductName),
      description: object.get(keyProductDescription),
      price: object.get(keyProductPrice),
      fabricator: object.get(keyProductFabricator),
      user: UserSerializer.mapParseToUser(object.get(keyProductUserId)),
    );
  }
}
