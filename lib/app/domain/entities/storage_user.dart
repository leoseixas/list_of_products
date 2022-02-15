import 'package:list_of_products/app/domain/entities/user.dart';

class StorageUser {
  StorageUser._internal();
  static final StorageUser _singleton = StorageUser._internal();
  factory StorageUser() => _singleton;

  static User user = User();

  static void clear() {
    user = User();
  }
}
