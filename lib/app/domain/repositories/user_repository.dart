import 'package:dartz/dartz.dart';
import 'package:list_of_products/app/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Exception, User>> singUpUser(User user);

  Future<Either<String, User>> loginWithEmail(User user);

  Future<Either<String, bool>> logout();
}
