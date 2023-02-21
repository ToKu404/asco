import 'package:asco/src/data/datasources/classroom_datasources.dart';
import 'package:asco/src/data/models/classroom_models/classroom_model.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/repositories/classroom_repository.dart';
import 'package:dartz/dartz.dart';

class ClassroomRepositoryImpl implements ClassroomRepository {
  final ClassroomDataSource dataSource;

  ClassroomRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, bool>> create(
      {required ClassroomEntity classroom,
      required String practicumUid}) async {
    try {
      final result = await dataSource.create(
        classroom: ClassroomModel.fromEntity(classroom),
        practicumUid: practicumUid,
      );
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<ClassroomEntity>>> find(
      {String? practicumUid}) async {
    try {
      final result = await dataSource.find(
        practicumUid: practicumUid,
      );

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, ClassroomEntity>> single({required String uid}) async {
    try {
      final result = await dataSource.single(uid: uid);
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }
}
