import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';

class PracticumEntity extends Equatable {
  final String? uid;
  final String? badgePath;
  final String? course;
  final String? courseContractPath;
  final List<ProfileEntity>? listAssistant;

  const PracticumEntity({
    this.uid,
    this.badgePath,
    this.course,
    this.courseContractPath,
    this.listAssistant,
  });

  @override
  List<Object?> get props => [
        uid,
        badgePath,
        course,
        courseContractPath,
        listAssistant,
      ];
}
