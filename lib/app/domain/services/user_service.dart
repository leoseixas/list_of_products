import 'package:dartz/dartz.dart';
import 'package:list_of_products/app/core/erros.dart';
import 'package:list_of_products/app/domain/entities/storage_user.dart';
import 'package:list_of_products/app/domain/entities/user.dart';
import 'package:list_of_products/app/domain/repositories/user_repository.dart';

abstract class UserService {
  Future<Either<Exception, bool>> signUpUser(User user);

  Future<Either<String, bool>> loginWithEmail(User user);
}

class UserServiceImpl implements UserService {
  final UserRepository repository;

  UserServiceImpl({this.repository});

  @override
  Future<Either<FailureUser, bool>> signUpUser(User user) async {
    try {
      final result = await repository.singUpUser(user);

      if (result.isRight()) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } catch (e) {
      throw UserErrorSignUp(message: 'Erro ao cadastrar');
    }
  }

  @override
  Future<Either<String, bool>> loginWithEmail(User user) async {
    User userStorage = User();
    String messsageError;

    final result = await repository.loginWithEmail(user);

    result.fold(
      (l) => messsageError = l,
      (r) => {
        userStorage = r,
        StorageUser.user = userStorage,
      },
    );
    if (result.isRight()) {
      return Right(true);
    } else {
      return Left(messsageError);
    }
  }
}
