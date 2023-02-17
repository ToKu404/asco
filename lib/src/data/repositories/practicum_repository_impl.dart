import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/repositories/practicum_repository.dart';
import 'package:dartz/dartz.dart';

class PracticumRepositoryImpl implements PracticumRepository {
  @override
  Future<Either<Failure, bool>> create({required PracticumEntity userEntity}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PracticumEntity>>> find(
    String? query,
  ) {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PracticumEntity>> single({required String uid}) {
    // TODO: implement single
    throw UnimplementedError();
  }
}
