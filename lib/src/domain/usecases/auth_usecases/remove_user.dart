import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveUser {
  final AuthRepository authRepository;
  RemoveUser({required this.authRepository});

  Future<Either<Failure, bool>> execute({required String username}) {
    return authRepository.deleteUser(username: username);
  }
}
