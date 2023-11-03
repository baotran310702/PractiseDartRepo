//So to understand more about test file
//What does the class depends on
//-> Authentication Repo
//How can we create a fake version of the dependency
//Answer --Use moctail
//How do we control what our dependencies do
//-> Using Mocktail's APIs

import 'package:crudproject/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:crudproject/src/authentication/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late CreateUser usecase;
  late AuthenticationRepository _repository;

  setUp(() {
    _repository = MockAuthRepo();
    usecase = CreateUser(_repository);
  });

  const params = CreateUserParams.empty();

  test('should call the [AuthRepo.createUser]', () async {
    //Arrange
    when(() => _repository
        .createUser(
          createAt: any(named: 'createAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        )
        .then((_) async => const Right(null)));

    //Act
    final result = await usecase(params);

    //Assert
    expect(result, equals(const Right(null)));
    verify(() => _repository.createUser(
        createAt: params.createAt,
        name: params.name,
        avatar: params.avatar)).called(1);

    verifyNoMoreInteractions(_repository);
  });
}
