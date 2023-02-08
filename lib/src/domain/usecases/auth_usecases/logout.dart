import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogOut {
  final AuthRepository authRepository;
  LogOut({required this.authRepository});

  Future<Either<Failure, bool>> execute() {
    return authRepository.logOut();
  }
}
