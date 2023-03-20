import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:equatable/equatable.dart';

class ClassroomEntity extends Equatable {
  final String? uid;
  final String? practicumUid;
  final String? classCode;
  final String? courseName;
  final String? meetingDay;
  final int? startHour;
  final int? endHour;
  final int? startMinute;
  final int? endMinute;
  final List<ProfileEntity>? students;

  const ClassroomEntity({
    this.uid,
    this.practicumUid,
    this.classCode,
    this.courseName,
    this.meetingDay,
    this.startHour,
    this.endHour,
    this.startMinute,
    this.endMinute,
    this.students,
  });

  @override
  List<Object?> get props => [
        uid,
        practicumUid,
        classCode,
        courseName,
        meetingDay,
        startHour,
        endHour,
        startMinute,
        endMinute,
        students,
      ];
}
