import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:equatable/equatable.dart';

class ClassroomEntity extends Equatable {
  final String? uid;
  final PracticumEntity? practicum;
  final String? classCode;
  final String? meetingDay;
  final int? startHour;
  final int? endHour;
  final int? startMinute;
  final int? endMinute;
  final List<ProfileEntity>? students;

  const ClassroomEntity({
    this.uid,
    this.practicum,
    this.classCode,
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
        practicum,
        classCode,
        meetingDay,
        startHour,
        endHour,
        startMinute,
        endMinute,
        students,
      ];
}
