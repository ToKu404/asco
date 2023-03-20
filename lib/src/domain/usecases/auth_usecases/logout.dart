import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';

class LogOut {
  final AuthRepository repository;

  LogOut({required this.repository});

  Future<Either<Failure, bool>> execute() {
    return repository.logOut();
  }
}
