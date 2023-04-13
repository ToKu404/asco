import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/datasources/control_card_datasource.dart';
import 'package:asco/src/domain/entities/assistance_entities/control_card_entity.dart';
import 'package:asco/src/domain/entities/assistance_entities/control_card_result_entity.dart';
import 'package:asco/src/domain/repositories/control_card_repository.dart';

class ControlCardRepositoryImpl implements ControlCardRepository {
  final ControlCardDataSource datasource;

  ControlCardRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, bool>> initForStudent({
    required String practicumUid,
    required List<String>? addedStudentId,
    required List<String>? removeStudentId,
  }) async {
    try {
      final result = await datasource.initForStudent(
        practicumUid: practicumUid,
        addedStudentId: addedStudentId,
        removeStudentId: removeStudentId,
      );

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to create data'));
    }
  }

  @override
  Future<Either<Failure, ControlCardEntity>> single({
    required String uid,
  }) async {
    try {
      final result = await datasource.single(uid: uid);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to get data'));
    }
  }

  @override
  Future<Either<Failure, ControlCardResultEntity>> find({
    String? studentId,
  }) async {
    try {
      final result = await datasource.find(studentId: studentId);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to find data'));
    }
  }
}
