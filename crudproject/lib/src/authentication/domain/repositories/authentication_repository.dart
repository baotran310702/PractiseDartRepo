import 'package:crudproject/core/utils/typedef.dart';
import 'package:crudproject/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  /// If you use 2 return values is Exception and void, you have to write logic code to handle 2 case
  /// and return both exception and void and it will conflict the rules of clean architecture
  /// So we use only one params Either a params from lib dartz.
  /// And the files failure.dart will be written here

  ResultVoid createUser(
      {required String createAt, required String name, required String avatar});

  ResultFuture<List<User>> getUser();
}
