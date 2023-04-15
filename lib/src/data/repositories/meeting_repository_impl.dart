import 'package:asco/src/data/models/attendance_models/attendance_model.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/datasources/meeting_datasource.dart';
import 'package:asco/src/data/models/meeting_models/detail_meeting_model.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/domain/repositories/meeting_repository.dart';

class MeetingRepositoryImpl implements MeetingRepository {
  final MeetingDataSource datasource;

  MeetingRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, bool>> create({
    required DetailMeetingEntity meeting,
    required List<String> listStudentId,
  }) async {
    try {
      final result = await datasource.create(
        meeting: DetailMeetingModel.fromEntity(meeting),
        listStudentId: listStudentId,
      );

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to create data'));
    }
  }

  @override
  Future<Either<Failure, DetailMeetingEntity>> single({
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
  Future<Either<Failure, List<DetailMeetingEntity>>> find({
    String? classroomUid,
  }) async {
    try {
      final result = await datasource.find(classroomUid: classroomUid);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to find data'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateAttendance(
      {required List<AttendanceEntity> listAttendanceModel,
      required String uid}) async {
    try {
      final result = await datasource.updateAttendance(
          listAttendanceModel: listAttendanceModel
              .map((e) => AttendanceModel.fromEntity(e))
              .toList(),
          uid: uid);
      return Right(result);
    } on FirebaseException {
      return const Left(FirestoreFailure('failed to update data'));
    }
  }
}
