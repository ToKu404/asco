import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/datasources/assistance_group_datasources.dart';
import 'package:asco/src/data/datasources/attendances_datasources.dart';
import 'package:asco/src/data/models/assistance_models/assistance_model.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entity.dart';
import 'package:asco/src/domain/repositories/assitance_repository.dart';
import 'package:dartz/dartz.dart';

class AssistanceGroupRepositoryImpl implements AssitanceGroupRepository {
  final AssistanceGroupDataSources datasource;

  AssistanceGroupRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, bool>> create(
      {required AssistanceGroupEntity entity}) async {
    try {
      final result = await datasource.create(
          entity: AssistanceGroupModel.fromEntity(entity));
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<AssistanceGroupEntity>>> find(
      {required String practicumUid}) async {
    try {
      final result = await datasource.find(
        practicumUid: practicumUid,
      );

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, AssistanceGroupEntity>> single(
      {required String uuid, String? assistant}) async {
    try {
      final result = await datasource.single(
        uuid: uuid,
        assistant: assistant,
      );
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }
}
