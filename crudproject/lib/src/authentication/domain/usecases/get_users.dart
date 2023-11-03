import 'package:crudproject/core/usecase/usecase.dart';
import 'package:crudproject/core/utils/typedef.dart';
import 'package:crudproject/src/authentication/domain/entities/user.dart';
import 'package:crudproject/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  final AuthenticationRepository _repository;
  const GetUsers(this._repository);

  @override
  ResultFuture<List<User>> call() => _repository.getUser();
}
