import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/datasources/assistance_group_datasource.dart';
import 'package:asco/src/data/models/assistance_models/assistance_group_model.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_group_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/domain/repositories/assistance_repository.dart';

class AssistanceGroupRepositoryImpl implements AssistanceGroupRepository {
  final AssistanceGroupDataSource datasource;

  AssistanceGroupRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, bool>> create({
    required AssistanceGroupEntity assistanceGroup,
  }) async {
    try {
      final result = await datasource.create(
        assistanceGroup: AssistanceGroupModel.fromEntity(assistanceGroup),
      );

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure('failed to create data'));
    }
  }

  @override
  Future<Either<Failure, AssistanceGroupEntity>> single({
    required String uuid,
    String? assistant,
  }) async {
    try {
      final result = await datasource.single(
        uuid: uuid,
        assistant: assistant,
      );

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure('failed to get data'));
    }
  }

  @override
  Future<Either<Failure, List<AssistanceGroupEntity>>> find({
    required String practicumUid,
  }) async {
    try {
      final result = await datasource.find(practicumUid: practicumUid);

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure('failed to find data'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateStudents({
    required String assistantGroupUid,
    required List<ProfileEntity> students,
  }) async {
    try {
      final result = await datasource.updateStudents(
        assistantGroupUid: assistantGroupUid,
        students: students,
      );

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure('failed to update data'));
    }
  }
}
