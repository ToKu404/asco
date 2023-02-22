import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/datasources/control_card_datasources.dart';
import 'package:asco/src/data/models/assistance_models/control_card_model.dart';
import 'package:asco/src/domain/entities/assistance_entities/control_card_entity.dart';
import 'package:asco/src/domain/repositories/control_card_repository.dart';
import 'package:dartz/dartz.dart';

class ControlCardRepositoryImpl implements ControlCardRepository {
  final ControlCardDataSources datasource;

  ControlCardRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, bool>> create({required ControlCardEntity cc}) async {
    try {
      final result = await datasource.create(
        cc: ControlCardModel.fromEntity(cc),
      );
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<ControlCardEntity>>> find(
      {String? studentId}) async {
    try {
      final result = await datasource.find(
        studentId: studentId,
      );

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, ControlCardEntity>> single(
      {required String uid}) async {
    try {
      final result = await datasource.single(uid: uid);
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }
}
