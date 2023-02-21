import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveUser {
  final AuthRepository repository;
  RemoveUser({required this.repository});

  Future<Either<Failure, bool>> execute({required String username}) {
    return repository.deleteUser(username: username);
  }
}
