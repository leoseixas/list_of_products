import 'package:list_of_products/app/domain/entities/user.dart';

class Products {
  final String id;
  final String name;
  final String description;
  final num price;
  final String fabricator;
  final User user;

  Products({
    this.id,
    this.name,
    this.description,
    this.price,
    this.fabricator,
    this.user,
  });
}
