import 'package:list_of_products/app/core/erros.dart';
import 'package:list_of_products/app/data/gateway/user_gateway.dart';
import 'package:list_of_products/app/data/serializers/user_serializer.dart';
import 'package:list_of_products/app/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:list_of_products/app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserGatewayImpl gateway;

  UserRepositoryImpl({this.gateway});

  @override
  Future<Either<FailureUser, User>> singUpUser(User user) async {
    UserSerializer userSerializer = UserSerializer(
      name: user.name,
      email: user.email,
      password: user.password,
      confirmPassword: user.confirmPassword,
    );
    try {
      final result = await gateway.signUpUser(userSerializer);
      User user = User(
          name: result.name,
          email: result.email,
          password: result.password,
          confirmPassword: result.confirmPassword);
      return Right(user);
    } catch (e) {
      return Left(UserErrorSignUp(message: 'Erro ao cadastrar'));
    }
  }

  @override
  Future<Either<String, User>> loginWithEmail(User user) async {
    UserSerializer userSerializer = UserSerializer(
      name: '',
      email: user.email,
      password: user.password,
      confirmPassword: '',
    );
    String messageError;

    try {
      final result = await gateway.loginWithEmail(userSerializer);
      result.fold((l) => messageError = l, (r) => userSerializer = r);

      User resultUser = User(
        id: userSerializer.id,
        name: userSerializer.name,
        email: userSerializer.email,
      );
      if (result.isRight()) {
        return Right(resultUser);
      } else {
        throw Left(messageError);
      }
    } catch (e) {
      return Left(e);
    }
  }
}
