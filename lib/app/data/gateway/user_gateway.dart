import 'package:dartz/dartz.dart';
import 'package:list_of_products/app/core/erros.dart';
import 'package:list_of_products/app/core/table_keys.dart';
import 'package:list_of_products/app/data/serializers/user_serializer.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class UserGateway {
  Future<UserSerializer> signUpUser(UserSerializer userSerializer);
  Future<Either<String, UserSerializer>> loginWithEmail(
      UserSerializer userSerializer);
}

class UserGatewayImpl implements UserGateway {
  @override
  Future<UserSerializer> signUpUser(UserSerializer userSerializer) async {
    try {
      final parseUser = ParseUser(
          userSerializer.email, userSerializer.password, userSerializer.email);

      parseUser.set<String>(keyUserName, userSerializer.name);

      final response = await parseUser.signUp();

      final user = UserSerializer.mapParseToUser(response.result);
      return user;
    } catch (e) {
      throw UserErrorSignUp(message: 'Erro ao cadastar');
    }
  }

  @override
  Future<Either<String, UserSerializer>> loginWithEmail(
      UserSerializer userSerializer) async {
    final parseUser =
        ParseUser(userSerializer.email, userSerializer.password, null);
    final response = await parseUser.login();

    if (response.success) {
      return Right(UserSerializer.mapParseToUser(response.result));
    } else {
      String messageError =
          await Future.error(ParseErrors.getDescription(response.error.code));
      throw messageError;
    }
  }
}
