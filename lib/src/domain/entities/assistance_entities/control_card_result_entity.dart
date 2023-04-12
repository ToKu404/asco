import 'package:asco/src/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

class ControlCardResultEntity extends Equatable {
  final ProfileEntity? student;
  final String? practicumUid;
  final String? studentId;
  final String? uid;
  final List<ControlCardEntity>? data;

  const ControlCardResultEntity({
    this.student,
    this.data,
    this.studentId,
    this.uid,
    this.practicumUid,
  });

  @override
  List<Object?> get props => [
        student,
        data,
        uid,
        studentId,
        practicumUid,
      ];
}
