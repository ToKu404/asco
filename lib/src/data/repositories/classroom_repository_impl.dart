import 'package:asco/src/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/datasources/classroom_datasource.dart';
import 'package:asco/src/data/models/classroom_models/classroom_model.dart';
import 'package:asco/src/domain/repositories/classroom_repository.dart';

class ClassroomRepositoryImpl implements ClassroomRepository {
  final ClassroomDataSource datasource;

  ClassroomRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, bool>> create({
    required ClassroomEntity classroom,
    required PracticumEntity? practicum,
  }) async {
    try {
      final result = await datasource.create(
        classroom: ClassroomModel.fromEntity(classroom),
        practicum: practicum,
      );

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to create data'));
    }
  }

  @override
  Future<Either<Failure, ClassroomEntity>> single({required String uid}) async {
    try {
      final result = await datasource.single(uid: uid);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to get data'));
    }
  }

  @override
  Future<Either<Failure, List<ClassroomEntity>>> find({
    String? practicumUid,
  }) async {
    try {
      final result = await datasource.find(practicumUid: practicumUid);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to find data'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateStudent({
    required String classroomUid,
    required List<ProfileEntity> students,
  }) async {
    try {
      final result = await datasource.updateStudents(
        classroomUid: classroomUid,
        students: students,
      );

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to update data'));
    }
  }
}
