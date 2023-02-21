import 'package:asco/src/data/datasources/meeting_datasources.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_result_entity.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/repositories/attendances_repository.dart';
import 'package:dartz/dartz.dart';

class AttendancesRepositoryImpl implements AttendancesRepository {
  final MeetingDataSourceImpl dataSource;

  AttendancesRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, bool>> add({required String uid, required AttendanceEntity attendance}) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> create({required AttendanceResultEntity attendances}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<AttendanceResultEntity>>> find({required String classroomUid}) {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AttendanceResultEntity>> single({required String meetingUid, required String classroomUid}) {
    // TODO: implement single
    throw UnimplementedError();
  }

}
