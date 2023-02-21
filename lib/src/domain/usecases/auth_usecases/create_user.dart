import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class CreateUser {
  final AuthRepository repository;

  CreateUser({required this.repository});

  Future<Either<Failure, bool>> execute({required UserEntity userEntity}) {
    return repository.createUser(userEntity: userEntity);
  }
}
