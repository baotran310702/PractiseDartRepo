import 'package:crudproject/core/usecase/usecase.dart';
import 'package:crudproject/core/utils/typedef.dart';
import 'package:crudproject/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  final AuthenticationRepository _repository;
  const CreateUser(this._repository);

  @override
  ResultVoid call(CreateUserParams params) async => _repository.createUser(
      createAt: params.createAt, name: params.name, avatar: params.avatar);
}

class CreateUserParams extends Equatable {
  final String createAt;
  final String name;
  final String avatar;

  const CreateUserParams(
      {required this.createAt, required this.name, required this.avatar});

  const CreateUserParams.empty()
      : this(
            createAt: '_empty.string',
            name: '_empty.string',
            avatar: '_empty.string');

  @override
  List<Object?> get props => [createAt, name, avatar];
}
