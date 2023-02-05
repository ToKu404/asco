import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class CreateUser {
  final AuthRepository authRepository;

  CreateUser({required this.authRepository});

  Future<Either<Failure, bool>> execute({required UserEntity userEntity}) {
    return authRepository.createUser(userEntity: userEntity);
  }
}
