import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/datasources/control_card_datasource.dart';
import 'package:asco/src/data/models/assistance_models/control_card_model.dart';
import 'package:asco/src/domain/entities/assistance_entities/control_card_entity.dart';
import 'package:asco/src/domain/repositories/control_card_repository.dart';

class ControlCardRepositoryImpl implements ControlCardRepository {
  final ControlCardDataSource datasource;

  ControlCardRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, bool>> create({
    required ControlCardEntity controlCard,
  }) async {
    try {
      final result = await datasource.create(
        controlCard: ControlCardModel.fromEntity(controlCard),
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
  Future<Either<Failure, List<ControlCardEntity>>> find({
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
