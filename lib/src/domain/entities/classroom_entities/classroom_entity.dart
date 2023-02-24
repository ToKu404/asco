import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:equatable/equatable.dart';

class ClassroomEntity extends Equatable {
  final String? uid;
  final String? meetingDay;
  final int? startHour;
  final int? startMinute;
  final int? endHour;
  final int? endMinute;
  final String? classCode;
  final String? practicumUid;
  final String? courseName;
  final List<ProfileEntity>? students;

  const ClassroomEntity({
    this.startHour,
    this.endHour,
    this.meetingDay,
    this.uid,
    this.classCode,
    this.endMinute,
    this.startMinute,
    this.practicumUid,
    this.courseName,
    this.students,
  });

  @override
  List<Object?> get props => [
        startHour,
        endHour,
        meetingDay,
        uid,
        practicumUid,
        endMinute,
        startMinute,
        courseName,
        students,
      ];
}
