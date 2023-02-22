import 'package:asco/src/data/datasources/attendances_datasources.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/models/attendance_models/attendance_model.dart';
import 'package:asco/src/data/models/meeting_models/meeting_model.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_result_entity.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/entities/meeting_entities/meeting_entity.dart';
import 'package:asco/src/domain/repositories/attendances_repository.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/profile_entities/detail_profile_entity.dart';

class AttendancesRepositoryImpl implements AttendancesRepository {
  final AttendancesDataSources dataSource;

  AttendancesRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, bool>> update({
    required String uid,
    required AttendanceEntity attendance,
    required AttendanceEntity oldAttendance,
  }) async {
    try {
      final result = await dataSource.update(
        attendance: AttendanceModel.fromEntity(attendance),
        oldAttendance: AttendanceModel.fromEntity(oldAttendance),
        uid: uid,
      );
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<AttendanceResultEntity>>> find(
      {required String classroomUid}) async {
    try {
      final result = await dataSource.find(
        classroomUid: classroomUid,
      );
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, AttendanceResultEntity>> single(
      {required String meetingUid, required String classroomUid}) async {
    try {
      final result = await dataSource.single(
        classroomUid: classroomUid,
        meetingUid: meetingUid,
      );
      return Right(result!);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, bool>> create({
    required MeetingEntity meeting,
    required String classroomUid,
    required List<DetailProfileEntity> students,
  }) async {
    try {
      final result = await dataSource.create(
        classroomUid: classroomUid,
        meeting: MeetingModel.fromEntity(meeting),
        students: students,
      );
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }
}
