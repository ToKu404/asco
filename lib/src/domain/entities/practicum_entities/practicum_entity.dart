import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:equatable/equatable.dart';

class PracticumEntity extends Equatable {
  final String? uid;
  final String? badgePath;
  final String? course;
  final String? courseContractPath;
  final List<ClassroomEntity>? classes;
  final List<UserProfileEntity>? listAssistant;

  const PracticumEntity({
    this.badgePath,
    this.classes,
    this.course,
    this.courseContractPath,
    this.listAssistant,
    this.uid,
  });

  @override
  List<Object?> get props => [
        badgePath,
        classes,
        course,
        courseContractPath,
        listAssistant,
        uid,
      ];
}
